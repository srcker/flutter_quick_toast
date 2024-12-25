import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import './widgets/container.dart';
import './widgets/progress.dart';
import './widgets/overlay_entry.dart';
import './widgets/loading.dart';
import './animations/animation.dart';
import 'theme.dart';

/// Toast 的样式枚举类型
enum QuickToastStyle { light, dark, custom }

/// Toast 的位置枚举类型
enum QuickToastToastPosition { top, center, bottom }

/// 动画样式枚举类型
enum QuickToastAnimationStyle { opacity, offset, scale, custom }

/// 遮罩类型枚举类型
enum QuickToastMaskType { none, clear, black, custom }

/// 遮罩类型枚举类型
enum QuickToastType { toast, widget }

/// 加载状态枚举类型
enum QuickToastStatus { show, dismiss }

/// 加载状态回调类型定义
typedef QuickToastStatusCallback = void Function(QuickToastStatus status);


/// QuickToast 主类
class QuickToast {

    /// 加载样式，默认为 [QuickToastStyle.dark]
    late QuickToastStyle loadingStyle;

    /// 加载遮罩类型，默认为 [QuickToastMaskType.none]
    late QuickToastMaskType maskType;

    /// 提示信息的位置，默认为 [QuickToastToastPosition.center]
    late QuickToastToastPosition toastPosition;

    /// 加载动画样式，默认为 [QuickToastAnimationStyle.opacity]
    late QuickToastAnimationStyle animationStyle;

    /// 状态文本的对齐方式，默认为 [TextAlign.center]
    late TextAlign textAlign;

    /// 加载内容的内边距
    late EdgeInsets contentPadding;

    /// 状态文本的内边距
    late EdgeInsets textPadding;

    /// 加载指示器的尺寸，默认 40.0
    late double indicatorSize;

    /// 加载框的圆角半径，默认 5.0
    late double radius;

    /// 状态文本的字体大小，默认 15.0
    late double fontSize;

    /// 加载指示器的线条宽度，默认 4.0，仅用于 [ring] 和 [dualRing] 类型
    late double lineWidth;

    /// 成功、错误、信息和吐司显示的持续时间，默认 2000 毫秒
    late Duration displayDuration;

    /// 加载动画的持续时间，默认 200 毫秒
    late Duration animationDuration;

    /// 弹窗类型，默认为 [QuickToastType.toast]
    QuickToastType? type;

    /// 自定义加载动画，默认值为 null
    QuickToastAnimation? customAnimation;

    /// 状态文本的样式，默认值为 null
    TextStyle? textStyle;

    /// 加载状态文本颜色，仅在 [QuickToastStyle.custom] 下使用
    Color? textColor;

    /// 加载指示器颜色，仅在 [QuickToastStyle.custom] 下使用
    Color? indicatorColor;

    /// 加载进度颜色，仅在 [QuickToastStyle.custom] 下使用
    Color? progressColor;

    /// 加载框背景颜色，仅在 [QuickToastStyle.custom] 下使用
    Color? backgroundColor;

    /// 加载框的阴影，仅在 [QuickToastStyle.custom] 下使用
    List<BoxShadow>? boxShadow;

    /// 加载遮罩颜色，仅在 [QuickToastMaskType.custom] 下使用
    Color? maskColor;

    /// 加载时是否允许用户交互
    bool? userInteractions;

    /// 是否允许点击加载框消失
    bool? dismissOnTap;

    /// 加载指示器组件
    Widget? indicatorWidget;

    /// 成功组件
    Widget? successWidget;

    /// 错误组件
    Widget? errorWidget;

    /// 信息组件
    Widget? infoWidget;

	/// 用于存储 Toast 的 Widget
    Widget? _w; 

	/// Toast 的 OverlayEntry 实例
    QuickToastOverlayEntry? overlayEntry; 

	/// 快速 Toast 容器的 GlobalKey
    GlobalKey<QuickToastContainerState>? _key;

	/// 快速 Toast 进度条的 GlobalKey
    GlobalKey<QuickToastProgressState>? _progressKey; 

	/// 用于控制 Toast 显示时长的计时器
    Timer? _timer;

    /// 获取当前显示的 Widget
    Widget? get w => _w;

    /// 获取加载容器的 Key
    GlobalKey<QuickToastContainerState>? get key => _key;

    /// 获取进度容器的 Key
    GlobalKey<QuickToastProgressState>? get progressKey => _progressKey;
    final List<QuickToastStatusCallback> _statusCallbacks = <QuickToastStatusCallback>[];

    /// 单例模式的工厂构造函数
    factory QuickToast() => _instance;

    static final QuickToast _instance = QuickToast._internal();

	QuickToast._internal() {
		loadingStyle = QuickToastStyle.dark;
		maskType = QuickToastMaskType.none;
		toastPosition = QuickToastToastPosition.center;
		animationStyle = QuickToastAnimationStyle.opacity;
		textAlign = TextAlign.center;
		indicatorSize = 35.0;
		radius = 5.0;
		fontSize = 14.0;
		lineWidth = 3.0;
		displayDuration = const Duration(milliseconds: 2000);
		animationDuration = const Duration(milliseconds: 200);
		textPadding = const EdgeInsets.only(bottom: 10.0);
		contentPadding = const EdgeInsets.symmetric(
			vertical: 15.0,
			horizontal: 20.0,
		);
	}

	static QuickToast get instance => _instance;
	static bool get isShow => _instance.w != null;


	/// 初始化 QuickToast
	static TransitionBuilder init({TransitionBuilder? builder}) {
		return (BuildContext context, Widget? child) {
			if (builder != null) {
				return builder(context, QuickToastLoading(child: child));
			} else {
				return QuickToastLoading(child: child);
			}
		};
	}


	/// 显示加载中提示框，支持状态、指示器和遮罩类型的自定义
	static Future<void> show({
		required Widget widget,
		String? status,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		// 如果未提供指示器，则使用默认的加载指示器
		return _instance._show(
			status: status,
			maskType: maskType,
			dismissOnTap: dismissOnTap,
			w: SizedBox(
				width: QuickToastTheme.indicatorSize,
				height: QuickToastTheme.indicatorSize,
				child: widget,
			),
		);
	}

	/// 显示加载中提示框，支持状态、指示器和遮罩类型的自定义
	static Future<void> showWidget({
		required Widget widget,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		// 如果未提供指示器，则使用默认的加载指示器
		return _instance._show(
			maskType: maskType,
			dismissOnTap: dismissOnTap,
			type: QuickToastType.widget,
			w: widget,
		);
	}

	/// 显示加载中提示框，支持状态、指示器和遮罩类型的自定义
	static Future<void> showLoading({
		String? status,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		// 如果未提供指示器，则使用默认的加载指示器
		return _instance._show(
			status: status,
			maskType: maskType,
			dismissOnTap: dismissOnTap,
			w: SizedBox(
				width: QuickToastTheme.indicatorSize,
				height: QuickToastTheme.indicatorSize,
				child: CircularProgressIndicator(
					strokeWidth: QuickToastTheme.lineWidth,
					color: QuickToastTheme.indicatorColor,
					backgroundColor: QuickToastTheme.backgroundColor,
				),
			),
		);
	}

	/// 显示进度条提示框，值范围为 0.0 ~ 1.0
	static Future<void> showProgress(
		double value, {
		String? status,
		QuickToastMaskType? maskType,
	}) async {
		assert(value >= 0.0 && value <= 1.0, 'progress value should be 0.0 ~ 1.0',);

		// 如果加载样式为自定义，则必须提供进度条颜色
		if (_instance.loadingStyle == QuickToastStyle.custom) {
			assert(_instance.progressColor != null, );
		}

		if (_instance.w == null || _instance.progressKey == null) {
			// 如果当前没有显示内容，先取消现有的显示
			if (_instance.key != null) await dismiss(animation: false);

			GlobalKey<QuickToastProgressState> progressKey = GlobalKey<QuickToastProgressState>();

			Widget w = QuickToastProgress(
				key: progressKey,
				value: value,
			);

			_instance._show(
				status: status,
				maskType: maskType,
				dismissOnTap: false,
				w: w,
			);
			_instance._progressKey = progressKey;
		}

		// 更新进度
		_instance.progressKey?.currentState?.updateProgress(min(1.0, value));
		// 更新状态
		if (status != null) _instance.key?.currentState?.updateStatus(status);
	}

	/// 显示成功提示框
	static Future<void> showSuccess(
		String status, {
		Duration? duration,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		Widget w = _instance.successWidget ??
			Icon(
				Icons.done,
				color: QuickToastTheme.indicatorColor,
				size: QuickToastTheme.indicatorSize,
			);

		return _instance._show(
			status: status,
			duration: duration ?? QuickToastTheme.displayDuration,
			maskType: maskType,
			dismissOnTap: dismissOnTap,
			w: w,
		);
	}

	/// 显示错误提示框
	static Future<void> showError(
		String status, {
		Duration? duration,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		Widget w = _instance.errorWidget ??
			Icon(
				Icons.clear,
				color: QuickToastTheme.indicatorColor,
				size: QuickToastTheme.indicatorSize,
			);

		return _instance._show(
			status: status,
			duration: duration ?? QuickToastTheme.displayDuration,
			maskType: maskType,
			dismissOnTap: dismissOnTap,
			w: w,
		);
	}

	/// 显示信息提示框
	static Future<void> showInfo(
		String status, {
		Duration? duration,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		Widget w = _instance.infoWidget ??
			Icon(
				Icons.info_outline,
				color: QuickToastTheme.indicatorColor,
				size: QuickToastTheme.indicatorSize,
			);

		return _instance._show(
			status: status,
			duration: duration ?? QuickToastTheme.displayDuration,
			maskType: maskType,
			dismissOnTap: dismissOnTap,
			w: w,
		);
	}

	/// 显示简单的 Toast 提示
	static Future<void> showToast(
		String status, {
		Duration? duration,
		QuickToastToastPosition? toastPosition,
		QuickToastMaskType? maskType,
		bool? dismissOnTap,
	}) {
		return _instance._show(
			status: status,
			duration: duration ?? QuickToastTheme.displayDuration,
			toastPosition: toastPosition ?? QuickToastTheme.toastPosition,
			maskType: maskType,
			dismissOnTap: dismissOnTap,
		);
	}

	/// 关闭提示框
	static Future<void> dismiss({
		bool animation = true,
	}) {
		_instance._cancelTimer();
		return _instance._dismiss(animation);
	}

	/// 添加加载状态回调
	static void addStatusCallback(QuickToastStatusCallback callback) {
		if (!_instance._statusCallbacks.contains(callback)) {
			_instance._statusCallbacks.add(callback);
		}
	}

	/// 移除单个加载状态回调
	static void removeCallback(QuickToastStatusCallback callback) {
		if (_instance._statusCallbacks.contains(callback)) {
			_instance._statusCallbacks.remove(callback);
		}
	}

	/// 移除所有加载状态回调
	static void removeAllCallbacks() {
		_instance._statusCallbacks.clear();
	}

	/// 显示加载提示框
	/// [status] - 提示文本
	/// [duration] - 显示时长
	/// [toastPosition] - 提示框位置
	/// [maskType] - 遮罩类型
	Future<void> _show({
		Widget? w, // 加载指示器组件
		String? status, // 状态文本
		Duration? duration, // 显示时长
		QuickToastMaskType? maskType, // 遮罩类型
		bool? dismissOnTap, // 是否点击遮罩关闭
		EdgeInsets? contentPadding, // 内容内边距
		QuickToastType? type,
		QuickToastToastPosition? toastPosition, // 提示框位置
	}) async {
		// 确保已初始化 overlayEntry
		assert(overlayEntry != null, '您需要在 MaterialApp 中调用 QuickToast.init()');

		// 如果加载样式是自定义样式，确保相关参数不为空
		if (loadingStyle == QuickToastStyle.custom) {
			assert(backgroundColor != null, '当加载样式为自定义时，backgroundColor 不能为空');
			assert(indicatorColor != null, '当加载样式为自定义时，indicatorColor 不能为空');
			assert(textColor != null, '当加载样式为自定义时，textColor 不能为空');
		}

		// 如果遮罩类型为自定义，确保遮罩颜色不为空
		maskType ??= _instance.maskType;
		if (maskType == QuickToastMaskType.custom) {
			assert(maskColor != null, '当遮罩类型为自定义时，maskColor 不能为空');
		}

		// 如果动画样式为自定义，确保动画参数不为空
		if (animationStyle == QuickToastAnimationStyle.custom) {
			assert(customAnimation != null, '当动画样式为自定义时，customAnimation 不能为空');
		}

		// 设置默认提示框位置
		bool animation = _w == null; // 是否需要动画
		_progressKey = null; // 重置进度组件键
		if (_key != null) await dismiss(animation: false); // 如果已有提示框，先关闭

		// 创建完成回调
		Completer<void> completer = Completer<void>();
		_key = GlobalKey<QuickToastContainerState>();
		_w = QuickToastContainer(
			key: _key,
			status: status,
			indicator: w,
			animation: animation,
			toastPosition: toastPosition??QuickToastToastPosition.center,
			maskType: maskType,
			type: type ?? QuickToastType.toast,
			dismissOnTap: dismissOnTap,
			completer: completer,
		);

		// 当提示框显示完成后触发回调
		completer.future.whenComplete(() {
			_callback(QuickToastStatus.show); // 调用状态回调
			if (duration != null) {
				_cancelTimer(); // 取消之前的计时器
				_timer = Timer(duration, () async {
					await dismiss(); // 到时关闭提示框
				});
			}
		});

		// 触发界面重绘
		_markNeedsBuild();
		return completer.future;
	}

	/// 关闭提示框
	Future<void> _dismiss(bool animation) async {
		// 如果提示框未加载，直接重置
		if (key != null && key?.currentState == null) {
			_reset();
			return;
		}

		// 调用提示框状态的 dismiss 方法，并在完成后重置
		return key?.currentState?.dismiss(animation).whenComplete(() {
			_reset();
		});
	}

	/// 重置提示框状态
	void _reset() {
		_w = null;
		_key = null;
		_progressKey = null;
		_cancelTimer(); // 取消计时器
		_markNeedsBuild(); // 重绘界面
		_callback(QuickToastStatus.dismiss); // 触发关闭回调
	}

	/// 调用状态回调
	void _callback(QuickToastStatus status) {
		for (final QuickToastStatusCallback callback in _statusCallbacks) {
			callback(status); // 执行每个回调函数
		}
	}

	/// 触发界面重绘
	void _markNeedsBuild() {
		overlayEntry?.markNeedsBuild();
	}

	/// 取消计时器
	void _cancelTimer() {
		_timer?.cancel();
		_timer = null;
	}

}
