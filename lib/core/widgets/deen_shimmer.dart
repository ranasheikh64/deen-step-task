import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Reusable gradient shimmer effect for skeleton loading states
class DeenShimmer extends StatefulWidget {
  const DeenShimmer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.borderRadius = 8,
    this.baseColor = const Color(0xFF18221D),
    this.highlightColor = const Color(0xFF2B3A32),
  });

  final Widget? child;
  final double? width;
  final double? height;
  final double borderRadius;
  final Color baseColor;
  final Color highlightColor;

  @override
  State<DeenShimmer> createState() => _DeenShimmerState();
}

class _DeenShimmerState extends State<DeenShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    final inTest = !kIsWeb && Platform.environment.containsKey('FLUTTER_TEST');
    if (inTest) {
      _controller.value = 0.5;
    } else {
      _controller.repeat();
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final v = _controller.value;
            return LinearGradient(
              begin: const Alignment(-1.5, -0.2),
              end: const Alignment(1.5, 0.2),
              stops: [(v - 0.25).clamp(0.0, 1.0), v, (v + 0.25).clamp(0.0, 1.0)],
              colors: [widget.baseColor, widget.highlightColor, widget.baseColor],
            ).createShader(bounds);
          },
          child: widget.child ??
              Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.baseColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                ),
              ),
        );
      },
    );
  }
}
