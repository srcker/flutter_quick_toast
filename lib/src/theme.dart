// The MIT License (MIT)
//
// Copyright (c) 2020 nslogx
//
// Permission is hereby granted, free of charge, to any person obtaining a
// copy of this software and associated documentation files (the "Software"),
// to deal in the Software without restriction, including without limitation
// the rights to use, copy, modify, merge, publish, distribute, sublicense,
// and/or sell copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
// OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.

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

    /// width of progress indicator
    static double get progressWidth => QuickToast.instance.progressWidth;

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
