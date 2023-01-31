import 'package:flutter/material.dart';

class ColoredProgressBar extends StatefulWidget {
  ColoredProgressBar({
    super.key,
    required Color begin,
    required Color end,
    required this.value,
    this.max = 100,
    this.duration = const Duration(milliseconds: 600),
  }) {
    colorTween = ColorTween(
      begin: begin,
      end: end,
    );
  }

  late final ColorTween colorTween;
  final double value;
  final double max;
  final Duration duration;

  @override
  State<StatefulWidget> createState() => _ColoredProgressBarState();
}

class _ColoredProgressBarState extends State<ColoredProgressBar>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  static final Tween<double> tween = Tween(begin: 0, end: 1);
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    animation = CurvedAnimation(
        parent: tween.animate(controller), curve: Curves.easeInOut);

    animation.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double v = widget.value / widget.max;
    v = v * animation.value;
    Color color = widget.colorTween.lerp(v) ?? Colors.black;
    return LinearProgressIndicator(
      minHeight: 10,
      value: v,
      backgroundColor: Colors.transparent,
      color: color,
    );
  }
}
