import 'dart:ui';

import 'package:flutter/material.dart';

/// Custom class for creating glass morphism text effects
class GlassMorphismText extends StatelessWidget {
  const GlassMorphismText({
    super.key,
    required this.text,
    this.style,
    this.glowColor,
    this.glowIntensity = 0.5,
    this.blurRadius = 2.0,
    this.letterSpacing,
    this.gradient,
    this.textAlign,
    this.textEffect = GlassTextEffect.glow,
  });

  /// Text to display
  final String text;

  /// Base text style
  final TextStyle? style;

  /// Color of the glow effect
  final Color? glowColor;

  /// Intensity of the glow effect (0.0 to 1.0)
  final double glowIntensity;

  /// Blur radius for backdrop filter
  final double blurRadius;

  /// Letter spacing
  final double? letterSpacing;

  /// Optional gradient for text
  final Gradient? gradient;

  /// Text alignment
  final TextAlign? textAlign;

  /// Type of glass text effect to apply
  final GlassTextEffect textEffect;

  @override
  Widget build(BuildContext context) {
    // Base text style with white color if none provided
    final baseStyle = (style ??
            TextStyle(fontSize: 24, fontWeight: FontWeight.bold))
        .copyWith(
          color: Colors.white.withValues(alpha: 0.9),
          letterSpacing: letterSpacing,
        );

    // Shadow color for glow effect
    final shadowColor = glowColor ?? Colors.white;

    switch (textEffect) {
      case GlassTextEffect.glow:
        return Text(
          text,
          textAlign: textAlign,
          style: baseStyle.copyWith(
            shadows: [
              Shadow(
                blurRadius: 8.0,
                color: shadowColor.withValues(alpha: glowIntensity),
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 12.0,
                color: shadowColor.withValues(alpha: glowIntensity * 0.7),
                offset: Offset(0, 0),
              ),
            ],
          ),
        );

      case GlassTextEffect.frosted:
        return Stack(
          alignment: Alignment.center,
          children: [
            // Blurred shadow text
            Text(
              text,
              textAlign: textAlign,
              style: baseStyle.copyWith(
                color: Colors.white.withValues(alpha: 0.3),
              ),
            ),
            // Main text with blur filter
            ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: blurRadius,
                  sigmaY: blurRadius,
                ),
                child: Text(
                  text,
                  textAlign: textAlign,
                  style: baseStyle.copyWith(
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.white.withValues(alpha: 0.5),
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );

      case GlassTextEffect.gradient:
        return ShaderMask(
          shaderCallback:
              (bounds) => (gradient ??
                      LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.8),
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ))
                  .createShader(bounds),
          child: Text(
            text,
            textAlign: textAlign,
            style: baseStyle.copyWith(
              color: Colors.white, // Will be masked by shader
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: shadowColor.withValues(alpha: glowIntensity * 0.5),
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        );

      case GlassTextEffect.neon:
        return Text(
          text,
          textAlign: textAlign,
          style: baseStyle.copyWith(
            shadows: [
              Shadow(
                blurRadius: 5,
                color: shadowColor.withValues(alpha: glowIntensity * 0.8),
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 10,
                color: shadowColor.withValues(alpha: glowIntensity * 0.5),
                offset: Offset(0, 0),
              ),
              Shadow(
                blurRadius: 15,
                color: shadowColor.withValues(alpha: glowIntensity * 0.3),
                offset: Offset(0, 0),
              ),
            ],
          ),
        );
    }
  }
}

/// Enum defining different glass text effects
enum GlassTextEffect {
  glow, // Simple glow effect
  frosted, // Frosted glass effect with blur
  gradient, // Gradient text
  neon, // Neon light effect
}
