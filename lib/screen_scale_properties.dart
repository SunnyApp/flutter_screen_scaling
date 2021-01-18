/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */

import 'dart:math' as math;

import 'package:flutter/material.dart';

ScreenScaleProperties _instance;
const int screenDefaultWidth = 1080;
const int screenDefaultHeight = 1920;

// ignore: non_constant_identifier_names
ScreenScaleProperties get ScreenScale {
  return _instance ??=
      ScreenScaleProperties(allowFontScaling: true, allowSubpixel: true);
}

class ScreenScaleProperties {
  /// UI设计中手机尺寸 , px
  /// Size of the phone in UI Design , px
  final num uiWidthPx;
  final num uiHeightPx;

  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  /// allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  final bool allowFontScaling;

  final bool allowSubpixel;

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  final double textScaleFactor;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  final double pixelRatio;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  final double screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  final double screenHeight;

  /// 当前设备宽度 px
  /// The vertical extent of this size. px
  double get screenWidthPx => screenHeight * pixelRatio;

  /// 当前设备高度 px
  /// The vertical extent of this size. px
  double get screenHeightPx => screenHeight * pixelRatio;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top
  final double statusBarHeight;

  /// 底部安全区距离 dp
  /// The offset from the bottom.
  final double bottomBarHeight;

  final double scaleWidth;
  final double scaleHeight;

  ScreenScaleProperties._(
      {@required this.uiWidthPx,
      @required this.uiHeightPx,
      @required this.allowFontScaling,
      @required this.allowSubpixel,
      @required this.screenWidth,
      @required this.screenHeight,
      @required this.pixelRatio,
      @required this.statusBarHeight,
      @required this.bottomBarHeight,
      @required this.textScaleFactor})
      : scaleWidth = screenWidth / (uiWidthPx * pixelRatio),
        scaleHeight = screenHeight / (uiHeightPx * pixelRatio);

  factory ScreenScaleProperties({
    double width,
    double height,
    bool allowFontScaling,
    @required bool allowSubpixel,
    double maxWidth,
  }) {
    if (maxWidth == null &&
        width == null &&
        height == null &&
        allowFontScaling == null) {
      return ScreenScale;
    }
    final pixelRatio = WidgetsBinding.instance.window.devicePixelRatio;
    final physicalWidth = WidgetsBinding.instance.window.physicalSize.width;
    var widthCalc = maxWidth != null
        ? math.min(maxWidth * pixelRatio, physicalWidth)
        : physicalWidth;
    return _instance = ScreenScaleProperties._(
      uiWidthPx: width ??
          WidgetsBinding.instance.window.physicalSize.width / pixelRatio,
      uiHeightPx: height ??
          (WidgetsBinding.instance.window.physicalSize.height / pixelRatio),
      allowFontScaling: allowFontScaling ?? false,
      allowSubpixel: allowSubpixel ?? allowFontScaling ?? false,
      pixelRatio: WidgetsBinding.instance.window.devicePixelRatio,
      screenWidth: widthCalc,
      screenHeight: WidgetsBinding.instance.window.physicalSize.height,
      statusBarHeight: WidgetsBinding.instance.window.padding.top,
      bottomBarHeight: WidgetsBinding.instance.window.padding.bottom,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    );
  }

  ScreenScaleProperties init({
    double width,
    double height,
    bool allowFontScaling,
    @required bool allowSubpixel,
    double maxWidth,
  }) {
    return ScreenScaleProperties(
        width: width,
        height: height,
        maxWidth: maxWidth,
        allowFontScaling: allowFontScaling,
        allowSubpixel: allowSubpixel);
  }

  double get scaleText => scaleWidth;

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你先要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double convertWidth(num width) => scaleWidth * width;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double convertHeight(num height) => scaleHeight * height;

  ///字体大小适配方法
  ///@param [fontSize] UI设计上字体的大小,单位px.
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the UI design, in px.
  ///@param [allowFontScaling]
  double convertFontSize(num fontSize,
      {bool allowFontScaling, bool allowSubpixel}) {
    allowSubpixel ??= this.allowSubpixel;
    allowFontScaling ??= this.allowFontScaling;
    var scaling = allowFontScaling
        ? (scaleText * fontSize)
        : ((scaleText * fontSize) / textScaleFactor);

    return allowSubpixel ? scaling : scaling.roundToDouble();
  }
}
