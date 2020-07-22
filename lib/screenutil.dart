/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */

import 'package:flutter/material.dart';

ScreenProperties _instance;
const int screenDefaultWidth = 1080;
const int screenDefaultHeight = 1920;

class ScreenProperties {
  /// UI设计中手机尺寸 , px
  /// Size of the phone in UI Design , px
  final num uiWidthPx;
  final num uiHeightPx;

  /// 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  /// allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  final bool allowFontScaling;

  final double screenWidth;
  final double screenHeight;
  final double pixelRatio;
  final double statusBarHeight;
  final double bottomBarHeight;
  final double textScaleFactor;

  final double scaleWidth;
  final double scaleHeight;

  ScreenProperties.instance(
      {this.uiWidthPx,
      this.uiHeightPx,
      this.allowFontScaling,
      this.screenWidth,
      this.screenHeight,
      this.pixelRatio,
      this.statusBarHeight,
      this.bottomBarHeight,
      this.textScaleFactor})
      : assert(uiWidthPx != null),
        assert(uiHeightPx != null),
        scaleWidth =
            uiWidthPx == null ? 1 : screenWidth / (uiWidthPx * pixelRatio),
        scaleHeight =
            uiHeightPx == null ? 1 : screenHeight / (uiHeightPx * pixelRatio);

  factory ScreenProperties(
      {double width, double height, bool allowFontScaling}) {
    if (width != null || height != null || allowFontScaling != null) {
      return _instance = ScreenProperties.instance(
        uiWidthPx: width ?? WidgetsBinding.instance.window.physicalSize.width,
        uiHeightPx:
            height ?? WidgetsBinding.instance.window.physicalSize.height,
        allowFontScaling: allowFontScaling,
        pixelRatio: WidgetsBinding.instance.window.devicePixelRatio,
        screenWidth: WidgetsBinding.instance.window.physicalSize.width,
        screenHeight: WidgetsBinding.instance.window.physicalSize.height,
        statusBarHeight: WidgetsBinding.instance.window.padding.top,
        bottomBarHeight: WidgetsBinding.instance.window.padding.bottom,
        textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
      );
    } else {
      if (_instance == null) {
        throw "Not initialized";
      }
      return _instance;
    }
  }

  double get scaleText => scaleWidth;

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你先要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  num convertWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  num convertHeight(num height) => height * scaleHeight;

  ///字体大小适配方法
  ///@param [fontSize] UI设计上字体的大小,单位px.
  ///Font size adaptation method
  ///@param [fontSize] The size of the font on the UI design, in px.
  ///@param [allowFontScaling]
  num convertFontSize(num fontSize, {bool allowFontScaling}) {
    allowFontScaling ??= this.allowFontScaling ?? false;
    return allowFontScaling
        ? (fontSize * scaleText)
        : ((fontSize * scaleText) / textScaleFactor);
  }
}

class ScreenUtil {
  ScreenUtil._();
  factory ScreenUtil({double width, double height, bool allowFontScaling}) {
    ScreenProperties(
        width: width, height: height, allowFontScaling: allowFontScaling);
    return ScreenUtil._();
  }

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  static double get textScaleFactor => instance.textScaleFactor;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  static double get pixelRatio => instance.pixelRatio;

  static ScreenProperties get instance {
    if (_instance == null) {
      throw "You must initialize ScreenUtil first";
    }
    return _instance;
  }

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  static double get screenWidth => instance.screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  static double get screenHeight => instance.screenHeight;

  /// 当前设备宽度 px
  /// The vertical extent of this size. px
  static double get screenWidthPx => instance.screenWidth * instance.pixelRatio;

  /// 当前设备高度 px
  /// The vertical extent of this size. px
  static double get screenHeightPx =>
      instance.screenHeight * instance.pixelRatio;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top
  static double get statusBarHeight => instance.statusBarHeight;

  /// 底部安全区距离 dp
  /// The offset from the bottom.
  static double get bottomBarHeight => instance.bottomBarHeight;
}
