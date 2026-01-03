import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CurvedMovieCard extends StatelessWidget {
  final Widget child;
  final double percentage; // -1 (left) to 1 (right), 0 is center
  final double curvature;

  const CurvedMovieCard({
    super.key,
    required this.child,
    required this.percentage,
    this.curvature = 0.2, // Adjusts how "curved" the cylinder looks
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CylindricalClipper(
        percentage: percentage,
        curvature: curvature,
      ),
      child: child,
    );
  }
}

class _CylindricalClipper extends CustomClipper<Path> {
  final double percentage;
  final double curvature;

  _CylindricalClipper({required this.percentage, required this.curvature});

  @override
  Path getClip(Size size) {
    Path path = Path();

    // curveIntensity determines the max depth of the curve (how much we shave off top/bottom)
    // 20.0 was used previously.
    double curveIntensity = 20.0;

    double h = size.height;
    double w = size.width;
    double delta = 1.0;

    // Top Edge
    for (double x = 0; x <= w; x += delta) {
      double centeredX = (x - w / 2) / w;
      double globalPos = percentage + centeredX;

      // yOffset = Intensity * (1 - pos^2)
      // At pos=0 (center screen), max offset (shorter)
      // At pos=1 (edge screen), min offset (taller)
      double yOffset = curveIntensity * (1.0 - (globalPos * globalPos));
      if (yOffset < 0) yOffset = 0;

      if (x == 0)
        path.moveTo(x, yOffset);
      else
        path.lineTo(x, yOffset);
    }

    // Bottom Edge
    for (double x = w; x >= 0; x -= delta) {
      double centeredX = (x - w / 2) / w;
      double globalPos = percentage + centeredX;
      double yOffset = curveIntensity * (1.0 - (globalPos * globalPos));
      if (yOffset < 0) yOffset = 0;

      path.lineTo(x, h - yOffset);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _CylindricalClipper oldClipper) {
    return oldClipper.percentage != percentage ||
        oldClipper.curvature != curvature;
  }
}

/// A widget that renders a URL image warped onto the curved mesh

class MeshCurvedImage extends StatefulWidget {
  final String imageUrl;
  final double percentage;

  const MeshCurvedImage({
    super.key,
    required this.imageUrl,
    required this.percentage,
  });

  @override
  State<MeshCurvedImage> createState() => _MeshCurvedImageState();
}

class _MeshCurvedImageState extends State<MeshCurvedImage> {
  ui.Image? _image;
  ImageStream? _imageStream;
  ImageStreamListener? _imageStreamListener;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resolveImage();
  }

  @override
  void didUpdateWidget(MeshCurvedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageUrl != oldWidget.imageUrl) {
      _resolveImage();
    }
  }

  void _resolveImage() {
    // Use CachedNetworkImageProvider for automatic disk/memory caching
    final ImageProvider provider = CachedNetworkImageProvider(widget.imageUrl);
    final ImageStream newStream = provider.resolve(
      createLocalImageConfiguration(context),
    );

    if (newStream.key != _imageStream?.key) {
      _stopListening();
      _imageStream = newStream;
      _imageStreamListener = ImageStreamListener(_handleImage);
      _imageStream!.addListener(_imageStreamListener!);
    }
  }

  void _handleImage(ImageInfo info, bool synchronousCall) {
    if (mounted) {
      setState(() {
        _image = info.image;
      });
    }
  }

  void _stopListening() {
    if (_imageStream != null && _imageStreamListener != null) {
      _imageStream!.removeListener(_imageStreamListener!);
    }
  }

  @override
  void dispose() {
    _stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      // Placeholder while loading
      // Using a solid color or gradient as fallback
      return Container(color: Colors.grey[900]);
    }

    return CustomPaint(
      painter: _MeshImagePainter(image: _image!, percentage: widget.percentage),
      child: Container(),
    );
  }
}

class _MeshImagePainter extends CustomPainter {
  final ui.Image image;
  final double percentage;

  _MeshImagePainter({required this.image, required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..filterQuality = FilterQuality.high;

    // Define the mesh grid size
    final int cols = 10;
    final int rows = 10;

    final List<Offset> vertices = [];
    final List<Offset> textureCoords = [];
    final List<int> indices = [];

    // Curve params (Must match Logic in Clipper!)
    final double curveIntensity = 20.0;

    final double cellW = size.width / cols;
    // final double cellH = size.height / rows;

    final double texCellW = image.width.toDouble() / cols;
    final double texCellH = image.height.toDouble() / rows;

    // Generate Vertices
    for (int r = 0; r <= rows; r++) {
      for (int c = 0; c <= cols; c++) {
        final double x = c * cellW;
        // final double y = r * cellH; // Unused, we use r directly for interpolation

        // Calculate curve displacement for this X
        double centeredX = (x - size.width / 2) / size.width;
        double globalPos = percentage + centeredX;

        // Match Clipper Logic: yOffset = curveIntensity * (1 - pos^2)
        // Shift depends on Y.
        // Top row (r=0) shifts DOWN by yOffset
        // Bottom row (r=rows) shifts UP by yOffset
        // Middle rows shift proportionally.
        // Normalized Y (0..1)
        double nv = r / rows;

        // Displacement:
        // topDisplacement (positive Y) = yOffset
        // bottomDisplacement (negative Y from bottom) = -yOffset => y_new = h - yOffset
        // So effectively, we interpolate the y boundaries.
        // y_top_curve = yOffset
        // y_bottom_curve = h - yOffset
        // y_final = lerp(y_top_curve, y_bottom_curve, nv)

        double offsetAmount = curveIntensity * (1.0 - (globalPos * globalPos));
        if (offsetAmount < 0) offsetAmount = 0;

        double yTop = offsetAmount;
        double yBottom = size.height - offsetAmount;

        double warpedY = ui.lerpDouble(yTop, yBottom, nv)!;

        vertices.add(Offset(x, warpedY));

        // Texture Coords (Standard mapping)
        textureCoords.add(Offset(c * texCellW, r * texCellH));
      }
    }

    // Generate Indices (Two triangles per cell)
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        final int i0 = r * (cols + 1) + c;
        final int i1 = i0 + 1;
        final int i2 = (r + 1) * (cols + 1) + c;
        final int i3 = i2 + 1;

        // Triangle 1
        indices.add(i0);
        indices.add(i1);
        indices.add(i2);

        // Triangle 2
        indices.add(i1);
        indices.add(i3);
        indices.add(i2);
      }
    }

    final ui.Vertices mesh = ui.Vertices(
      VertexMode.triangles,
      vertices,
      textureCoordinates: textureCoords,
      indices: indices,
    );

    canvas.drawImage(
      image,
      Offset.zero,
      Paint()..color = const Color(0x00000000),
    ); // Just to ensure image is kept alive? No.
    // Actually drawVertices uses the image as shader if provided?
    // No, drawVertices takes a Paint with shader.

    // We need to create an ImageShader
    final Float64List matrix4 = Matrix4.identity().storage;
    final ImageShader shader = ImageShader(
      image,
      TileMode.clamp,
      TileMode.clamp,
      matrix4,
    );

    paint.shader = shader;

    canvas.drawVertices(mesh, BlendMode.srcOver, paint);
  }

  @override
  bool shouldRepaint(covariant _MeshImagePainter oldDelegate) {
    return oldDelegate.percentage != percentage || oldDelegate.image != image;
  }
}
