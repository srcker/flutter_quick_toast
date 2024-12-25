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
        _value = widget.value.clamp(0.0, 1.0); // 初始化并确保进度值在有效范围内
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
            child: CircularProgressIndicator(
                value: _value, // 绑定进度值
                backgroundColor: QuickToastTheme.backgroundColor,// 设置背景色
                color: QuickToastTheme.progressColor, // 设置颜色
                strokeWidth: QuickToastTheme.lineWidth, // 设置线宽
            ),
        );
    }
}
