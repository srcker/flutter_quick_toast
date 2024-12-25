import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../theme.dart';
import '../quick_toast.dart';

T? _ambiguate<T>(T? value) => value;

class QuickToastContainer extends StatefulWidget {
    // 指示器组件
    final Widget? indicator;
    // 显示的状态文本
    final String? status;
    // 点击时是否自动消失
    final bool? dismissOnTap;
    // 提示框的位置
    final QuickToastToastPosition? toastPosition;
    // 提示框的类型
    final QuickToastType? type;
    // 遮罩的类型
    final QuickToastMaskType? maskType;
    // 完成器，用于完成异步操作
    final Completer<void>? completer;
    // 是否启用动画效果
    final bool animation;

    const QuickToastContainer({
        super.key,
        this.indicator,
        this.type,
        this.status,
        this.dismissOnTap,
        this.toastPosition,
        this.maskType,
        this.completer,
        this.animation = true,
    });

    // 创建对应的 State 对象
    @override
    QuickToastContainerState createState() => QuickToastContainerState();
}

class QuickToastContainerState extends State<QuickToastContainer> with SingleTickerProviderStateMixin {
    String? _status;
    Color? _maskColor;
    late AnimationController _animationController;
    late AlignmentGeometry _alignment;
    late bool _dismissOnTap, _ignoring;

    // 判断当前调度器是否处于持续回调阶段
    bool get isPersistentCallbacks => _ambiguate(SchedulerBinding.instance)!.schedulerPhase == SchedulerPhase.persistentCallbacks;

    @override
    void initState() {
        super.initState();
        if (!mounted) return;
        _status = widget.status;

         // 获取对齐方式
        _alignment = _getAlignment();

         // 获取是否在点击时关闭
        _dismissOnTap = _getDismissOnTap();

         // 获取是否忽略点击事件
        _ignoring = _getIgnoring();

         // 获取遮罩颜色
        _maskColor = _getMaskColor();

         // 添加动画状态监听器
        _animationController = AnimationController(vsync: this, duration: QuickToastTheme.animationDuration)..addStatusListener(_onAnimationStatusChanged);
        show(widget.animation);
    }

    // 获取对齐方式
    AlignmentGeometry _getAlignment() {
        return (widget.indicator == null && widget.status?.isNotEmpty == true)
            ? QuickToastTheme.alignment(widget.toastPosition)
            : AlignmentDirectional.center;
    }

    // 获取是否在点击时关闭
    bool _getDismissOnTap() {
        return widget.dismissOnTap ?? (QuickToastTheme.dismissOnTap ?? false);
    }

    // 获取是否忽略点击事件
    bool _getIgnoring() {
        return _dismissOnTap ? false : QuickToastTheme.ignoring(widget.maskType);
    }

    // 获取遮罩颜色
    Color? _getMaskColor() {
        return QuickToastTheme.maskColor(widget.maskType);
    }

    // 动画状态改变时的处理逻辑
    void _onAnimationStatusChanged(AnimationStatus status) {
        if (status == AnimationStatus.completed && !(widget.completer?.isCompleted ?? false)) {
            widget.completer?.complete();
        }
    }

    @override
    void dispose() {
        _animationController.dispose(); // 释放动画控制器
        super.dispose();
    }

    // 显示动画
    Future<void> show(bool animation) {
        if (isPersistentCallbacks) {
            return _postFrameCallback(() => _animationController.forward(from: animation ? 0 : 1));
        } else {
            return _animationController.forward(from: animation ? 0 : 1);
        }
    }

    // 关闭动画
    Future<void> dismiss(bool animation) {
        if (isPersistentCallbacks) {
            return _postFrameCallback(() => _animationController.reverse(from: animation ? 1 : 0));
        } else {
            return _animationController.reverse(from: animation ? 1 : 0);
        }
    }

    // 更新状态
    void updateStatus(String status) {
        if (_status == status) return;
        setState(() => _status = status);
    }

    // 在下一帧回调中执行操作
    Future<void> _postFrameCallback(VoidCallback callback) {
        Completer<void> completer = Completer<void>();
        _ambiguate(SchedulerBinding.instance)!.addPostFrameCallback((_) {
            callback();
            completer.complete();
        });
        return completer.future;
    }

    // 点击事件处理
    void _onTap() async {
        try {
            if (_dismissOnTap) await QuickToast.dismiss();
        } catch (e) {
            // 处理错误，这里可以根据需要记录错误信息或者显示错误提示
            print('点击关闭时发生错误: $e');
        }
    }

    @override
    Widget build(BuildContext context) {
        return Stack(
            alignment: _alignment,
            children: <Widget>[
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => Opacity(
                        opacity: _animationController.value,
                        child: IgnorePointer(
                            ignoring: _ignoring,
                            child: _dismissOnTap
                                ? GestureDetector(
                                    onTap: _onTap,
                                    behavior: HitTestBehavior.translucent,
                                    child: _buildMaskContainer(),
                                )
                                : _buildMaskContainer(),
                        ),
                    ),
                ),
                AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) => QuickToastTheme.loadingAnimation.buildWidget(
                        widget.type == QuickToastType.toast ? _Indicator(indicator: widget.indicator, status: _status) : widget.indicator!,
                        _animationController,
                        _alignment,
                    ),
                ),
            ],
        );
    }

    // 构建遮罩容器
    Widget _buildMaskContainer() {
        return Container(
            width: double.infinity,
            height: double.infinity,
            color: _maskColor,
        );
    }
}



class _Indicator extends StatelessWidget {
    final Widget? indicator;
    final String? status;

    const _Indicator({
        required this.indicator,
        required this.status,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: const EdgeInsets.all(50.0),
            decoration: BoxDecoration(
                color: QuickToastTheme.backgroundColor,
                borderRadius: BorderRadius.circular(QuickToastTheme.radius),
                boxShadow: QuickToastTheme.boxShadow,
            ),
            padding: QuickToastTheme.contentPadding,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                    if (indicator != null)
                        Container(
                            margin: status?.isNotEmpty == true ? QuickToastTheme.textPadding : EdgeInsets.zero,
                            child: indicator,
                        ),
                    if (status != null)
                        Text(
                            status!,
                            style: QuickToastTheme.textStyle ?? TextStyle(color: QuickToastTheme.textColor, fontSize: QuickToastTheme.fontSize),
                            textAlign: QuickToastTheme.textAlign,
                        ),
                ],
            ),
        );
    }
}
