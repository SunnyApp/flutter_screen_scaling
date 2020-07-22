import 'package:flutter_screenutil/screenutil.dart';

extension SizeExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtil.instance.convertWidth(this);

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil.instance.convertHeight(this);

  ///[ScreenUtil.setSp]
  double get px => ScreenUtil.instance.convertFontSize(this);

  ///[ScreenUtil.setSp]
  double get ptScaled =>
      ScreenUtil.instance.convertFontSize(this, allowFontScaling: true);

  ///[ScreenUtil.setSp]
  double get ptNoScaling =>
      ScreenUtil.instance.convertFontSize(this, allowFontScaling: false);

  ///屏幕宽度的倍数
  ///Multiple of screen width
  double get wp => ScreenUtil.screenWidth * this;

  ///屏幕高度的倍数
  ///Multiple of screen height
  double get hp => ScreenUtil.screenHeight * this;
}
