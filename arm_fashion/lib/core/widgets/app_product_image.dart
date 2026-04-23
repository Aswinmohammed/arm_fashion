import 'package:flutter/material.dart';

class AppProductImage extends StatelessWidget {
  const AppProductImage({
    super.key,
    required this.imagePath,
    required this.fit,
    required this.fallbackIcon,
    required this.fallbackIconColor,
    this.fallbackBackgroundColor,
    this.padding = EdgeInsets.zero,
    this.iconSize = 72,
  });

  final String imagePath;
  final BoxFit fit;
  final IconData fallbackIcon;
  final Color fallbackIconColor;
  final Color? fallbackBackgroundColor;
  final EdgeInsets padding;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Image.asset(
        imagePath,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: fallbackBackgroundColor,
            ),
            child: Center(
              child: Icon(
                fallbackIcon,
                size: iconSize,
                color: fallbackIconColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
