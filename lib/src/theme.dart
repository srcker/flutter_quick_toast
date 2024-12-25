import 'package:flutter/material.dart';

import './quick_toast.dart';
import './animations/animation.dart';
import './animations/opacity_animation.dart';
import './animations/offset_animation.dart';
import './animations/scale_animation.dart';

class QuickToastTheme {
    /// color of indicator
    static Color get indicatorColor =>
        QuickToast.instance.loadingStyle == QuickToastStyle.custom
            ? QuickToast.instance.indicatorColor!
            : QuickToast.instance.loadingStyle == QuickToastStyle.dark
                ? Colors.white
                : Colors.black;

    /// progress color of loading
    static Color get progressColor =>
        QuickToast.instance.loadingStyle == QuickToastStyle.custom
            ? QuickToast.instance.progressColor!
            : QuickToast.instance.loadingStyle == QuickToastStyle.dark
                ? Colors.white
                : Colors.black;

    /// background color of loading
    static Color get backgroundColor =>
        QuickToast.instance.loadingStyle == QuickToastStyle.custom
            ? QuickToast.instance.backgroundColor!
            : QuickToast.instance.loadingStyle == QuickToastStyle.dark
                ? Colors.black.withOpacity(0.9)
                : Colors.white;

    /// boxShadow color of loading
    static List<BoxShadow>? get boxShadow =>
        QuickToast.instance.loadingStyle == QuickToastStyle.custom
            ? QuickToast.instance.boxShadow ?? [const BoxShadow()]
            : null;

    /// font color of status
    static Color get textColor =>
        QuickToast.instance.loadingStyle == QuickToastStyle.custom
            ? QuickToast.instance.textColor!
            : QuickToast.instance.loadingStyle == QuickToastStyle.dark
                ? Colors.white
                : Colors.black;

    /// mask color of loading
    static Color maskColor(QuickToastMaskType? maskType) {
        maskType ??= QuickToast.instance.maskType;
        return maskType == QuickToastMaskType.custom
            ? QuickToast.instance.maskColor!
            : maskType == QuickToastMaskType.black
                ? Colors.black.withOpacity(0.5)
                : Colors.transparent;
    }

    /// loading animation
    static QuickToastAnimation get loadingAnimation {
        QuickToastAnimation animation;
        switch (QuickToast.instance.animationStyle) {
            case QuickToastAnimationStyle.custom:
                animation = QuickToast.instance.customAnimation!;
                break;
            case QuickToastAnimationStyle.offset:
                animation = OffsetAnimation();
                break;
            case QuickToastAnimationStyle.scale:
                animation = ScaleAnimation();
                break;
            default:
                animation = OpacityAnimation();
                break;
        }
        return animation;
    }

    /// font size of status
    static double get fontSize => QuickToast.instance.fontSize;

    /// size of indicator
    static double get indicatorSize => QuickToast.instance.indicatorSize;

    /// width of indicator
    static double get lineWidth => QuickToast.instance.lineWidth;

    /// toast position
    static QuickToastToastPosition get toastPosition =>
        QuickToast.instance.toastPosition;

    /// toast position
    static AlignmentGeometry alignment(QuickToastToastPosition? position) =>
        position == QuickToastToastPosition.bottom
            ? AlignmentDirectional.bottomCenter
            : (position == QuickToastToastPosition.top
                ? AlignmentDirectional.topCenter
                : AlignmentDirectional.center);

    /// display duration
    static Duration get displayDuration => QuickToast.instance.displayDuration;

    /// animation duration
    static Duration get animationDuration =>
        QuickToast.instance.animationDuration;

    /// contentPadding of loading
    static EdgeInsets get contentPadding => QuickToast.instance.contentPadding;

    /// padding of status
    static EdgeInsets get textPadding => QuickToast.instance.textPadding;

    /// textAlign of status
    static TextAlign get textAlign => QuickToast.instance.textAlign;

    /// textStyle of status
    static TextStyle? get textStyle => QuickToast.instance.textStyle;

    /// radius of loading
    static double get radius => QuickToast.instance.radius;

    /// should dismiss on user tap
    static bool? get dismissOnTap => QuickToast.instance.dismissOnTap;

    static bool ignoring(QuickToastMaskType? maskType) {
        maskType ??= QuickToast.instance.maskType;
        return QuickToast.instance.userInteractions ??
            (maskType == QuickToastMaskType.none ? true : false);
    }
}
