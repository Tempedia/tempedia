import 'dart:math';

import 'package:flutter/material.dart';

class RadarPainter extends CustomPainter {
  final List<String> labels;
  final List<num> data;
  final num max;

  RadarPainter({required this.labels, required this.data, this.max = 100});

  @override
  void paint(Canvas canvas, Size size) {
    const padding = 20;
    double len = size.width;
    if (size.height < len) {
      len = size.height;
    }
    final radius = len / 2 - padding * 2;

    final mainPaint = Paint();
    mainPaint.strokeWidth = 2;
    mainPaint.style = PaintingStyle.stroke;
    mainPaint.strokeCap = StrokeCap.round;
    mainPaint.strokeJoin = StrokeJoin.round;
    mainPaint.color = const Color(0xFFC3C3C3);

    const labelTextStyle = TextStyle(
      color: Color(0xFF666666),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    var path = Path();

    for (var i = 0; i < labels.length; i++) {
      final angle = (2 * pi / labels.length) * i;
      path.moveTo(len / 2, len / 2);
      path.lineTo(len / 2 + radius * sin(angle), len / 2 - radius * cos(angle));

      final textSpan = TextSpan(
        text: labels[i],
        style: labelTextStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: len,
      );
      final offset = Offset(
        len / 2 +
            (radius + textPainter.size.width / 2 + 4) * sin(angle) -
            (textPainter.size.width / 2),
        len / 2 -
            (radius + textPainter.size.width / 2 + 4) * cos(angle) -
            (textPainter.size.height / 2),
      );
      textPainter.paint(canvas, offset);
    }
    canvas.drawPath(path, mainPaint);

    final secondPaint = Paint();
    secondPaint.strokeWidth = 1;
    secondPaint.style = PaintingStyle.stroke;
    secondPaint.strokeCap = StrokeCap.round;
    secondPaint.strokeJoin = StrokeJoin.round;
    secondPaint.color = const Color(0xFFC3C3C3);
    for (var i = 1; i < 5; i++) {
      final r = radius / 4 * i;
      final path = Path();
      for (var j = 0; j < labels.length; j++) {
        final angle = (2 * pi / labels.length) * j;
        if (j == 0) {
          path.moveTo(len / 2 + r * sin(angle), len / 2 - r * cos(angle));
        } else {
          path.lineTo(len / 2 + r * sin(angle), len / 2 - r * cos(angle));
        }
      }
      path.close();
      canvas.drawPath(path, secondPaint);
    }

    // 绘制数据
    final dataPaint = Paint();
    dataPaint.strokeWidth = 2;
    dataPaint.style = PaintingStyle.fill;
    dataPaint.strokeCap = StrokeCap.round;
    dataPaint.strokeJoin = StrokeJoin.round;
    dataPaint.color = const Color(0x775aa1e4);

    const dataTextStyle = TextStyle(
      color: Color(0xFF5b8ef9),
      // fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    final dataPath = Path();
    for (var i = 0; i < data.length; i++) {
      final angle = (2 * pi / labels.length) * i;
      final r = data[i] / max * radius;
      if (i == 0) {
        dataPath.moveTo(len / 2 + r * sin(angle), len / 2 - r * cos(angle));
      } else {
        dataPath.lineTo(len / 2 + r * sin(angle), len / 2 - r * cos(angle));
      }

      final textSpan = TextSpan(
        text: '${data[i].toInt()}',
        style: dataTextStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: len,
      );
      final offset = Offset(
        len / 2 +
            (r + textPainter.size.width / 2 + 4) * sin(angle) -
            (textPainter.size.width / 2),
        len / 2 -
            (r + textPainter.size.width / 2 + 4) * cos(angle) -
            (textPainter.size.height / 2),
      );
      textPainter.paint(canvas, offset);
    }
    dataPath.close();
    canvas.drawPath(dataPath, dataPaint);
    dataPaint.style = PaintingStyle.stroke;
    dataPaint.color = const Color(0xFF5b8ef9);
    canvas.drawPath(dataPath, dataPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class RadarChart extends StatefulWidget {
  final List<String> labels;
  final List<num> data;
  final num max;
  final Duration duration;

  const RadarChart({
    super.key,
    required this.labels,
    required this.data,
    this.max = 100,
    this.duration = const Duration(milliseconds: 600),
  });

  @override
  State<StatefulWidget> createState() => _RadarChartState();
}

class _RadarChartState extends State<RadarChart> with TickerProviderStateMixin {
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
    final List<num> data = [];
    for (var d in widget.data) {
      data.add(d * animation.value);
    }
    return CustomPaint(
      painter: RadarPainter(labels: widget.labels, data: data, max: widget.max),
    );
  }
}
