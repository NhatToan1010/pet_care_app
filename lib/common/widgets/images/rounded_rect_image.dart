import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/popups/shimmers/default_shimmer.dart';

class RoundedRectImage extends StatelessWidget {
  const RoundedRectImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.onTap,
    this.fit = BoxFit.contain,
    this.radius = AppSize.borderRadiusLarge,
    this.isNetworkImage = false,
    this.backgroundColor = AppPallete.transparentColor,
    this.imageColor,
    this.imgWidth,
    this.imgHeight,
    this.boxShadow,
    this.border,
    this.defaultRadius = true,
    this.borderRadius,
  });

  final String imageUrl;
  final double? width, height, imgWidth, imgHeight;
  final double radius;
  final bool isNetworkImage;
  final bool defaultRadius;
  final BoxFit? fit;
  final Color? backgroundColor, imageColor;
  final EdgeInsetsGeometry? padding, margin;
  final VoidCallback? onTap;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: border,
          borderRadius:
              defaultRadius ? BorderRadius.circular(radius) : borderRadius,
          boxShadow: boxShadow,
        ),
        child: ClipRRect(
          borderRadius:
              defaultRadius ? BorderRadius.circular(radius) : borderRadius!,
          child: isNetworkImage
              ? CachedNetworkImage(
                  width: imgWidth,
                  height: imgHeight,
                  imageUrl: imageUrl,
                  fit: fit,
                  color: imageColor,
                  progressIndicatorBuilder: (context, url, downloadIndicator) =>
                      const CustomShimmerEffect(
                          width: double.infinity, height: 200),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image(
                  width: imgWidth,
                  height: imgHeight,
                  image: AssetImage(imageUrl),
                  color: imageColor,
                  fit: fit,
                ),
        ),
      ),
    );
  }
}
