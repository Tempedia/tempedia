import 'package:flutter/material.dart';

import 'dart:math';

import 'package:flutter_flip_card/modal/flip_side.dart';

/// [CustomGestureFlipCard]  A component that provides a gsture flip card animation
class CustomGestureFlipCard extends StatefulWidget {
  ///[frontWidget] The Front side widget of the card
  final Widget frontWidget;

  ///[backWidget] The Back side widget of the card
  final Widget backWidget;

  /// [axis] The flip axis [Horizontal] and [Vertical]
  final FlipAxis axis;
  final Function(bool)? callback;

  /// [animationDuration] The amount of milliseconds a turn animation will take.
  final Duration animationDuration;
  const CustomGestureFlipCard({
    Key? key,
    required this.frontWidget,
    required this.backWidget,
    this.axis = FlipAxis.vertical,
    this.animationDuration = const Duration(milliseconds: 800),
    this.callback,
  }) : super(key: key);

  @override
  createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<CustomGestureFlipCard>
    with TickerProviderStateMixin {
  bool isFront = true;
  bool isFrontStart = true;
  double dragPosition = 0;
  late AnimationController animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    animationController.addListener(() {
      setState(() {
        dragPosition = animation.value;
        setImageSide();
      });
    });
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (widget.callback != null) {
          widget.callback!(isFront);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double angle = dragPosition / 180 * pi;
    late Matrix4 transform;
    late Matrix4 transformForBack;

    if (widget.axis == FlipAxis.horizontal) {
      transform = Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(angle);
      transformForBack = Matrix4.identity()..rotateX(pi);
    } else {
      transform = Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle);
      transformForBack = Matrix4.identity()..rotateY(pi);
    }
    GestureDetector horizontalRotate = GestureDetector(
      onHorizontalDragStart: (de) {
        animationController.stop();
        isFrontStart = isFront;
      },
      onHorizontalDragUpdate: (det) => setState(() {
        dragPosition -= det.delta.dx;
        dragPosition %= 360;
        setImageSide();
      }),
      onHorizontalDragEnd: (de) {
        final velocity = de.velocity.pixelsPerSecond.dx.abs();
        if (velocity >= 100) {
          isFront = !isFrontStart;
        }
        double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;
        animation = Tween<double>(
          begin: dragPosition,
          end: end,
        ).animate(animationController);
        if (animationController.isAnimating) {
          return;
        } else {
          animationController.forward(from: 0);
        }
      },
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: isFront
            ? widget.frontWidget
            : Transform(
                transform: transformForBack,
                alignment: Alignment.center,
                child: widget.backWidget,
              ),
      ),
    );

    GestureDetector verticalRotate = GestureDetector(
      onVerticalDragStart: (de) {
        animationController.stop();
        isFrontStart = isFront;
      },
      onVerticalDragUpdate: (det) => setState(() {
        dragPosition += det.delta.dy;
        dragPosition %= 360;
        setImageSide();
      }),
      onVerticalDragEnd: (de) {
        final velocity = de.velocity.pixelsPerSecond.dy.abs();
        if (velocity >= 100) {
          isFront = !isFrontStart;
        }

        double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;
        animation = Tween<double>(
          begin: dragPosition,
          end: end,
        ).animate(animationController);
        if (animationController.isAnimating) {
          return;
        } else {
          animationController.forward(from: 0);
        }
      },
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: isFront
            ? widget.frontWidget
            : Transform(
                transform: transformForBack,
                alignment: Alignment.center,
                child: widget.backWidget,
              ),
      ),
    );

    return widget.axis == FlipAxis.vertical ? horizontalRotate : verticalRotate;
  }

  void setImageSide() {
    if (dragPosition <= 90 || dragPosition >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
