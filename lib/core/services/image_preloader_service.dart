import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImagePreloaderService {
  final Set<String> _preloadedUrls = {};

  Future<void> preloadImage(BuildContext context, String imageUrl) async {
    if (_preloadedUrls.contains(imageUrl)) return;

    _preloadedUrls.add(imageUrl);
    try {
      await precacheImage(CachedNetworkImageProvider(imageUrl), context);
    } catch (e) {
      // Handle error or just ignore if prefetch fails
      debugPrint('Error preloading image: $imageUrl - $e');
      _preloadedUrls.remove(imageUrl); // Allow retry later if needed
    }
  }
}
