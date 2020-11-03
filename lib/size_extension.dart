import 'screen_scale_properties.dart';

void sizeExtensions() {}

extension SizeExtension on num {
  ///[ScreenScale.setWidth]
  double get w => ScreenScale.convertWidth(this);

  ///[ScreenScale.setHeight]
  double get h => ScreenScale.convertHeight(this);

  ///[ScreenScale.setSp]
  double get px => ScreenScale.convertFontSize(this);

  ///[ScreenScale.setSp]
  double get ptScaled =>
      ScreenScale.convertFontSize(this, allowFontScaling: true);

  ///[ScreenScale.setSp]
  double get ptNoScaling =>
      ScreenScale.convertFontSize(this, allowFontScaling: false);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get wp => ScreenScale.screenWidth * this;

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get hp => ScreenScale.screenHeight * this;
}
