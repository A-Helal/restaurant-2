import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:restaurant_task/core/utils/app_colors.dart';
import 'package:restaurant_task/core/utils/constants.dart';

class MenuItemImage extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final double? height;
  final double? width;

  const MenuItemImage({
    super.key,
    required this.imageUrl,
    this.borderRadius,
    this.height,
    this.width,
  });

  bool _isBase64(String url) {
    return url.startsWith('data:image') || url.length > 100 && !url.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.zero;

    return Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: radius,
        color: AppColors.shimmerBase,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: _isBase64(imageUrl)
            ? _buildBase64Image(imageUrl)
            : CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => _buildErrorWidget(),
        ),
      ),
    );
  }

  Widget _buildBase64Image(String base64String) {
    try {
      final cleaned = base64String.split(',').last;
      Uint8List bytes = base64Decode(cleaned);
      return Image.memory(
        bytes,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    } catch (e) {
      return _buildErrorWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColors.shimmerBase,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.restaurant, size: 40, color: AppColors.iconSecondary),
          const SizedBox(height: Constants.paddingSmall),
          Text(
            'Image not available',
            style: TextStyle(
              fontSize: Constants.fontSizeSmall,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
