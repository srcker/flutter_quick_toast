import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme.dart';

class QuickToastProgress extends StatefulWidget {
    final double value;

    const QuickToastProgress({
        super.key,
        required this.value,
    });

    @override
    QuickToastProgressState createState() => QuickToastProgressState();
}

class QuickToastProgressState extends State<QuickToastProgress> {
    // 进度值，应在0.0到1.0之间。
    double _value = 0;

    @override
    void initState() {
        super.initState();
        _value = widget.value; // 初始化进度值
    }

    @override
    void dispose() {
        super.dispose();
    }

    void updateProgress(double value) {
        setState(() {
            _value = value.clamp(0.0, 1.0); // 确保进度值在0.0到1.0之间
        });
    }

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            width: QuickToastTheme.indicatorSize,
            height: QuickToastTheme.indicatorSize,
            child: _CircleProgress(
                value: _value,
                color: QuickToastTheme.progressColor,
                width: QuickToastTheme.progressWidth,
            ),
        );
    }
}

class _CircleProgress extends ProgressIndicator {
    @override
	final double value;

    final double width;
	
    @override
	final Color color;

    const _CircleProgress({
        required this.value,
        required this.width,
        required this.color,
    });

    @override
    __CircleProgressState createState() => __CircleProgressState();
}

class __CircleProgressState extends State<_CircleProgress> {
    @override
    void initState() {
        super.initState();
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return CustomPaint(
            painter: _CirclePainter(
                color: widget.color,
                value: widget.value,
                width: widget.width,
            ),
        );
    }
}

class _CirclePainter extends CustomPainter {
    final Color color;
    final double value;
    final double width;

    _CirclePainter({
        required this.color,
        required this.value,
        required this.width,
    });

    @override
    void paint(Canvas canvas, Size size) {
        final paint = Paint()
            ..color = color
            ..strokeWidth = width
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round;
        canvas.drawArc(
            Offset.zero & size,
            -math.pi / 2,
            math.pi * 2 * value,
            false,
            paint,
        );
    }

    @override
    bool shouldRepaint(_CirclePainter oldDelegate) {
        return value != oldDelegate.value;
    }
}
