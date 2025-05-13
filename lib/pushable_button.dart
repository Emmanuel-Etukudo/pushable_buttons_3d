import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pushable_buttons_3d/animation_controller_state.dart';

class PushableButton extends StatefulWidget {
  const PushableButton({
    super.key,
    this.child,
    required this.hslColor,
    required this.height,
    this.elevation = 8.0,
    this.shadow,
    this.onPressed,
    required this.opacity,
    this.width,
    this.blurIntensity = 10.0,
    this.borderRadius,
  }) : assert(height > 0);

  /// child widget (normally a Text or Icon)
  final Widget? child;

  /// Color of the top layer
  /// The color of the bottom layer is derived by decreasing the luminosity by 0.15
  final HSLColor hslColor;

  /// Width of the button (optional)
  final double? width;

  /// Blur intensity for the glass morphism effect
  final double blurIntensity;

  /// Border radius for the button
  final BorderRadius? borderRadius;

  /// Opacity of the button
  final double opacity;

  /// height of the top layer
  final double height;

  /// elevation or "gap" between the top and bottom layer
  final double elevation;

  /// An optional shadow to make the button look better
  /// This is added to the bottom layer only
  final BoxShadow? shadow;

  /// button pressed callback
  final VoidCallback? onPressed;

  @override
  PushableButtonState createState() =>
      PushableButtonState(Duration(milliseconds: 100));
}

class PushableButtonState extends AnimationControllerState<PushableButton> {
  PushableButtonState(super.animationDuration);

  bool _isDragInProgress = false;
  Offset _gestureLocation = Offset.zero;

  void _handleTapDown(TapDownDetails details) {
    _gestureLocation = details.localPosition;
    animationController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    animationController.reverse();
    widget.onPressed?.call();
  }

  void _handleTapCancel() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (!_isDragInProgress && mounted) {
        animationController.reverse();
      }
    });
  }

  void _handleDragStart(DragStartDetails details) {
    _gestureLocation = details.localPosition;
    _isDragInProgress = true;
    animationController.forward();
  }

  void _handleDragEnd(Size buttonSize) {
    //print('drag end (in progress: $_isDragInProgress)');
    if (_isDragInProgress) {
      _isDragInProgress = false;
      animationController.reverse();
    }
    if (_gestureLocation.dx >= 0 &&
        _gestureLocation.dy < buttonSize.width &&
        _gestureLocation.dy >= 0 &&
        _gestureLocation.dy < buttonSize.height) {
      widget.onPressed?.call();
    }
  }

  void _handleDragCancel() {
    if (_isDragInProgress) {
      _isDragInProgress = false;
      animationController.reverse();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _gestureLocation = details.localPosition;
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = widget.height + widget.elevation;
    final borderRadius =
        widget.borderRadius ?? BorderRadius.circular(widget.height / 2);

    return SizedBox(
      height: totalHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = Size(constraints.maxWidth, constraints.maxHeight);
          return GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            onHorizontalDragStart: _handleDragStart,
            onHorizontalDragEnd: (_) => _handleDragEnd(buttonSize),
            onHorizontalDragCancel: _handleDragCancel,
            onHorizontalDragUpdate: _handleDragUpdate,
            onVerticalDragStart: _handleDragStart,
            onVerticalDragEnd: (_) => _handleDragEnd(buttonSize),
            onVerticalDragCancel: _handleDragCancel,
            onVerticalDragUpdate: _handleDragUpdate,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                final top = animationController.value * widget.elevation;
                final hslColor = widget.hslColor;
                final bottomHslColor = hslColor.withLightness(
                  hslColor.lightness - 0.15,
                );
                return Stack(
                  children: [
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: widget.blurIntensity / 2,
                            sigmaY: widget.blurIntensity / 2,
                          ),
                          child: Container(
                            height: totalHeight - top,
                            decoration: BoxDecoration(
                              color: bottomHslColor.toColor().withValues(
                                alpha: widget.opacity * 0.7,
                              ),
                              // boxShadow:
                              //     widget.shadow != null ? [widget.shadow!] : [],
                              borderRadius: borderRadius,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      left: 0,
                      right: 0,
                      top: top,
                      child: ClipRRect(
                        borderRadius: borderRadius,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: widget.blurIntensity,
                            sigmaY: widget.blurIntensity,
                          ),
                          child: Container(
                            height: widget.height,
                            decoration: BoxDecoration(
                              color: hslColor.toColor().withValues(
                                alpha: widget.opacity,
                              ),
                              borderRadius: borderRadius,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                            ),
                            child: Center(child: widget.child),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
