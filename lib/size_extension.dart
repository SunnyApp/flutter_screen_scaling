import 'dart:math' as math;

import 'screen_scale_properties.dart';

void sizeExtensions() {}

class Px {}

extension SizeExtension on num {
  ///[ScreenScale.setWidth]
  double get w => ScreenScale.convertWidth(this).roundTo(3);

  ///[ScreenScale.setHeight]
  double get h => ScreenScale.convertHeight(this).roundTo(3);

  ///[ScreenScale.setSp]
  double get px => ScreenScale.convertFontSize(this).roundTo(3);

  ///[ScreenScale.setSp]
  double get ptScaled =>
      ScreenScale.convertFontSize(this, allowFontScaling: true).roundTo(3);

  ///[ScreenScale.setSp]
  double get ptNoScaling =>
      ScreenScale.convertFontSize(this, allowFontScaling: false).roundTo(3);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get wp => (ScreenScale.screenWidth * this).roundTo(3);

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get hp => (ScreenScale.screenHeight * this).roundTo(3);

  double roundTo([int? precision]) {
    var mod = math.pow(10.0, precision!);
    return ((this * mod).round().toDouble() / mod);
  }
}
