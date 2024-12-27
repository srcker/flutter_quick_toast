# Flutter QuickToast
> A lightweight Toast library for Flutter, which is implemented purely in Flutter and enables you to easily call the toast and loading functions without the need for context. 

[![Pub Version](https://img.shields.io/pub/v/quick_toast)](https://pub.dev/packages/quick_toast)
[![GitHub License](https://img.shields.io/github/license/srcker/flutter_quick_toast)](https://github.com/srcker/flutter_quick_toast)

[English](./README.md) ｜ 简体中文


## 安装

将以下代码添加到您项目中的 `pubspec.yaml` 文件:

```yaml
dependencies:
  quick_toast: ^latest
```

## 导入

```dart
import 'package:quick_toast/quick_toast.dart';
```

## 如何使用

首先, 在`MaterialApp`/`CupertinoApp`中初始化`QuickToast`:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter QuickToast',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter QuickToast'),
      builder: QuickToast.init(),
    );
  }
}
```

然后, 请尽情使用吧:

```dart
QuickToast.showLoading(status: 'loading...');

QuickToast.showProgress(0.3, status: 'downloading...');

QuickToast.showSuccess('Great Success!');

QuickToast.showError('Failed with Error');

QuickToast.showInfo('Useful Information.');

QuickToast.showToast('Toast');

QuickToast.showWidget(widget: Text('Custom Widget'));

QuickToast.show(status: 'danger.',widget: const Icon(Icons.report_problem));

QuickToast.dismiss();
```

添加 Loading 状态回调

```dart
QuickToast.addStatusCallback((status) {
  print('QuickToast Status $status');
});
```

移除 Loading 状态回调

```dart
QuickToast.removeCallback(statusCallback);

QuickToast.removeAllCallbacks();
```

## 自定义

❗️**注意:**

- **`textColor`、`indicatorColor`、`progressColor`、`backgroundColor` 仅对 `QuickToastStyle.custom`有效。**

- **`maskColor` 仅对 `QuickToastMaskType.custom`有效。**

```dart
/// loading的样式, 默认[QuickToastStyle.dark].
QuickToastStyle loadingStyle;

/// loading的遮罩类型, 默认[QuickToastMaskType.none].
QuickToastMaskType maskType;

/// toast的位置, 默认 [QuickToastToastPosition.center].
QuickToastToastPosition toastPosition;

/// 动画类型, 默认 [QuickToastAnimationStyle.opacity].
QuickToastAnimationStyle animationStyle;

/// 自定义动画, 默认 null.
QuickToastAnimation customAnimation;

/// 文本的对齐方式 , 默认[TextAlign.center].
TextAlign textAlign;

/// 文本的样式 , 默认 null.
TextStyle textStyle;

/// loading内容区域的内边距.
EdgeInsets contentPadding;

/// 文本的内边距.
EdgeInsets textPadding;

/// 指示器的大小, 默认40.0.
double indicatorSize;

/// loading的圆角大小, 默认5.0.
double radius;

/// 文本大小, 默认15.0.
double fontSize;

/// 进度条指示器的宽度, 默认2.0.
double progressWidth;

/// 指示器的宽度, 默认4.0, 仅对[QuickToastIndicatorType.ring, QuickToastIndicatorType.dualRing]有效.
double lineWidth;

/// [showSuccess] [showError] [showInfo]的展示时间, 默认2000ms.
Duration displayDuration;

/// 动画时间, 默认200ms.
Duration animationDuration;

/// 文本的颜色, 仅对[QuickToastStyle.custom]有效.
Color textColor;

/// 指示器的颜色, 仅对[QuickToastStyle.custom]有效.
Color indicatorColor;

/// 进度条指示器的颜色, 仅对[QuickToastStyle.custom]有效.
Color progressColor;

/// loading的背景色, 仅对[QuickToastStyle.custom]有效.
Color backgroundColor;

/// 遮罩的背景色, 仅对[QuickToastMaskType.custom]有效.
Color maskColor;

/// 当loading展示的时候，是否允许用户操作.
bool userInteractions;

/// 点击背景是否关闭.
bool dismissOnTap;

/// 指示器自定义组件
Widget indicatorWidget;

/// 展示成功状态的自定义组件
Widget successWidget;

/// 展示失败状态的自定义组件
Widget errorWidget;

/// 展示信息状态的自定义组件
Widget infoWidget;
```

因为 `QuickToast` 是一个全局单例, 所以你可以在任意一个地方自定义它的样式:

```dart
QuickToast.instance
  ..displayDuration = const Duration(milliseconds: 2000)
  ..indicatorType = QuickToastIndicatorType.fadingCircle
  ..loadingStyle = QuickToastStyle.dark
  ..indicatorSize = 45.0
  ..radius = 10.0
  ..progressColor = Colors.yellow
  ..backgroundColor = Colors.green
  ..indicatorColor = Colors.yellow
  ..textColor = Colors.yellow
  ..maskColor = Colors.blue.withOpacity(0.5)
  ..userInteractions = true
  ..dismissOnTap = false
  ..customAnimation = CustomAnimation();
```

更多的example可查看 👉 [flutter_quick_toast example](https://github.com/srcker/flutter_quick_toast/tree/main/example)


## 更新日志

[CHANGELOG](./CHANGELOG.md)

## 开源许可协议

[MIT License](./LICENSE)

## ❤️❤️❤️

感谢 [flutter_easyloading](https://github.com/nslogx/flutter_easyloading) ❤️

感谢 [JetBrains Open Source](https://www.jetbrains.com/community/opensource/#support) 提供支持
