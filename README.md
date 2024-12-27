# Flutter QuickToast
> A lightweight Toast library for Flutter, which is implemented purely in Flutter and enables you to easily call the toast and loading functions without the need for context. 


[![Pub Version](https://img.shields.io/pub/v/quick_toast)](https://pub.dev/packages/quick_toast)
[![GitHub License](https://img.shields.io/github/license/srcker/flutter_quick_toast)](https://github.com/srcker/flutter_quick_toast)

English | [简体中文](./README.zh_CN.md)

## Installation

Add the following code to the `pubspec.yaml` file in your project:

```yaml
dependencies:
  quick_toast: ^latest
```

## Import

```dart
import 'package:quick_toast/quick_toast.dart';
```

## How to Use

First, initialize `QuickToast` in your `MaterialApp`/`CupertinoApp`:

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

Then, feel free to use it:

```dart
QuickToast.showLoading(status: 'loading...');

QuickToast.showProgress(0.3, status: 'downloading...');

QuickToast.showSuccess('Great Success!');

QuickToast.showError('Failed with Error');

QuickToast.showInfo('Useful Information.');

QuickToast.showToast('Toast');

QuickToast.showWidget(widget: Text('Custom Widget'));

QuickToast.show(status: 'danger.', widget: const Icon(Icons.report_problem));

QuickToast.dismiss();
```

Add a Loading status callback

```dart
QuickToast.addStatusCallback((status) {
  print('QuickToast Status $status');
});
```

Remove a Loading status callback

```dart
QuickToast.removeCallback(statusCallback);

QuickToast.removeAllCallbacks();
```

## Customization

❗️**Note:**

- **`textColor`, `indicatorColor`, `progressColor`, `backgroundColor` are only valid for `QuickToastStyle.custom`.**

- **`maskColor` is only valid for `QuickToastMaskType.custom`.**

```dart
/// The style of the loading, default [QuickToastStyle.dark].
QuickToastStyle loadingStyle;

/// The mask type of the loading, default [QuickToastMaskType.none].
QuickToastMaskType maskType;

/// The position of the toast, default [QuickToastToastPosition.center].
QuickToastToastPosition toastPosition;

/// The animation style, default [QuickToastAnimationStyle.opacity].
QuickToastAnimationStyle animationStyle;

/// Custom animation, default null.
QuickToastAnimation customAnimation;

/// The alignment of the text, default [TextAlign.center].
TextAlign textAlign;

/// The style of the text, default null.
TextStyle textStyle;

/// The padding of the content area in loading.
EdgeInsets contentPadding;

/// The padding of the text.
EdgeInsets textPadding;

/// The size of the indicator, default 40.0.
double indicatorSize;

/// The radius of the loading, default 5.0.
double radius;

/// The size of the font, default 15.0.
double fontSize;

/// The width of the progress bar indicator, default 2.0.
double progressWidth;

/// The width of the indicator, default 4.0, only valid for [QuickToastIndicatorType.ring, QuickToastIndicatorType.dualRing].
double lineWidth;

/// The display duration of [showSuccess], [showError], [showInfo], default 2000ms.
Duration displayDuration;

/// The duration of the animation, default 200ms.
Duration animationDuration;

/// The color of the text, only valid for [QuickToastStyle.custom].
Color textColor;

/// The color of the indicator, only valid for [QuickToastStyle.custom].
Color indicatorColor;

/// The color of the progress bar indicator, only valid for [QuickToastStyle.custom].
Color progressColor;

/// The background color of the loading, only valid for [QuickToastStyle.custom].
Color backgroundColor;

/// The background color of the mask, only valid for [QuickToastMaskType.custom].
Color maskColor;

/// Whether to allow user interactions when loading is displayed.
bool userInteractions;

/// Whether to dismiss on tap.
bool dismissOnTap;

/// Custom indicator widget
Widget indicatorWidget;

/// Custom widget for showing success status
Widget successWidget;

/// Custom widget for showing error status
Widget errorWidget;

/// Custom widget for showing info status
Widget infoWidget;
```

Since `QuickToast` is a global singleton, you can customize its style from any place:

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

For more examples, please check 👉 [flutter_quick_toast example](https://github.com/srcker/flutter_quick_toast/tree/main/example)

## Changelog

[CHANGELOG](./CHANGELOG.md)

## Open Source License

[MIT License](./LICENSE)

## ❤️❤️❤️

Thanks to [flutter_easyloading](https://github.com/nslogx/flutter_easyloading) ❤️

Thanks to [JetBrains Open Source](https://www.jetbrains.com/community/opensource/#support) for support