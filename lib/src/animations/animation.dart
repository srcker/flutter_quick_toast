import 'package:flutter/widgets.dart';

/// 定义一个抽象类，用于快速实现 Toast 动画
abstract class QuickToastAnimation {
    QuickToastAnimation();

    /// 调用方法，通过调用子类实现的 [buildWidget] 构建动画组件
    Widget call(
        Widget child, // 子组件
        AnimationController controller, // 动画控制器
        AlignmentGeometry alignment, // 对齐方式
    ) {
        return buildWidget(
            child,
            controller,
            alignment,
        );
    }

    /// 抽象方法，子类需实现具体的动画构建逻辑
    Widget buildWidget(
        Widget child, // 子组件
        AnimationController controller, // 动画控制器
        AlignmentGeometry alignment, // 对齐方式
    );
}
