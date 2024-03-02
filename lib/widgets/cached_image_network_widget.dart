import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final int index;
  final Map<String, String> urls;
  final Function(int) onRemove;

  CustomCachedNetworkImage({
    required this.imageUrl,
    required this.index,
    required this.urls,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        errorListener: (e) {
          if (e is SocketException) {
            print('Error with ${e.address} and message ${e.message}');
          } else {
            print('Image Exception is: ${e.runtimeType}');
          }
          onRemove(index);
        },
        errorWidget: (context, url, error) {
          return Container();
        },
      ),
    );
  }
}
