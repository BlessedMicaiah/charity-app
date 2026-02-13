import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color color;
  final double spread;
  final double blur;
  final double offset;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;
  final bool isPressed;
  final VoidCallback? onTap;

  const NeumorphicContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.borderRadius = 12.0,
    this.color = AppColors.background,
    this.spread = 1.0,
    this.blur = 15.0,
    this.offset = 5.0,
    this.padding,
    this.shape = BoxShape.rectangle,
    this.isPressed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final lightShadow = BoxShadow(
      color: AppColors.shadowLight,
      offset: Offset(-offset, -offset),
      blurRadius: blur,
      spreadRadius: spread,
    );

    final darkShadow = BoxShadow(
      color: AppColors.shadowDark,
      offset: Offset(offset, offset),
      blurRadius: blur,
      spreadRadius: spread,
    );

    // If pressed, we invert the shadows or use an inner shadow effect.
    // Implementing inner shadow in Flutter is complex without a package.
    // For MVP, we can simulate pressed state by removing shadows or reducing elevation
    // and darkening the color slightly, or using a "flat" look.
    // A better approach for "pressed" without complex painting is to just invert the offset
    // to simulate "inset", but standard BoxShadow doesn't do inset.
    // So for "pressed", we'll just flatten it (no shadow) and darken background slightly.

    final decoration = BoxDecoration(
      color: isPressed ? color.withOpacity(0.95) : color,
      borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
      shape: shape,
      boxShadow: isPressed
          ? <BoxShadow>[] // "Pressed" looks flat or we could add a subtle inner shadow if using a custom painter
          : [lightShadow, darkShadow],
      border: isPressed
        ? Border.all(color: AppColors.shadowDark.withOpacity(0.1), width: 1)
        : null,
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: decoration,
        child: child,
      ),
    );
  }
}
