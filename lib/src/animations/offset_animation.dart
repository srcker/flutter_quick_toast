import 'package:flutter/widgets.dart';

import 'animation.dart';

/// 定义一个偏移动画类，继承自 QuickToastAnimation
class OffsetAnimation extends QuickToastAnimation {
    OffsetAnimation();

    /// 构建带有偏移动画的组件
    @override
    Widget buildWidget(
        Widget child, // 子组件
        AnimationController controller, // 动画控制器
        AlignmentGeometry alignment, // 对齐方式
    ) {
        // 根据对齐方式设置起始偏移量
        Offset begin = alignment == AlignmentDirectional.topCenter
            ? const Offset(0, -1) // 从顶部向下偏移
            : alignment == AlignmentDirectional.bottomCenter
                ? const Offset(0, 1) // 从底部向上偏移
                : const Offset(0, 0); // 无偏移

        // 定义偏移动画，从起始位置移动到 (0, 0)
        Animation<Offset> animation = Tween(
            begin: begin,
            end: const Offset(0, 0),
        ).animate(controller);

        // 返回包含透明度和偏移动画的组件
        return Opacity(
            opacity: controller.value, // 根据动画进度调整透明度
            child: SlideTransition(
                position: animation, // 应用偏移动画
                child: child, // 子组件
            ),
        );
    }
}
