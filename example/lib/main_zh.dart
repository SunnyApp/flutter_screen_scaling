import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter_ScreenUtil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Flutter Screen Util"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)

    ScreenScaleProperties(
        width: 750, height: 1334, allowFontScaling: false, allowSubpixel: true);

    return ExampleWidget(title: 'FlutterScreenUtil示例');
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    printScreenInformation();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(ScreenScale.convertWidth(10)),
                  width: ScreenScale.convertWidth(375),
                  height: ScreenScale.convertHeight(200),
                  color: Colors.red,
                  child: Text(
                    '我的宽度:${0.5.wp}dp \n'
                    '我的高度:${ScreenScale.convertHeight(200)}dp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenScale.convertFontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenScale.convertWidth(10)),
                  width: 375.w,
                  height: 200.h,
                  color: Colors.blue,
                  child: Text(
                      '我的宽度:${375.w}dp \n'
                      '我的高度:${200.h}dp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenScale.convertFontSize(24))),
                ),
              ],
            ),
            Text('设备宽度:${ScreenScale.screenWidthPx}px'),
            Text('设备高度:${ScreenScale.screenHeightPx}px'),
            Text('设备宽度:${ScreenScale.screenWidth}dp'),
            Text('设备高度:${ScreenScale.screenHeight}dp'),
            Text('设备的像素密度:${ScreenScale.pixelRatio}'),
            Text('底部安全区距离:${ScreenScale.bottomBarHeight}dp'),
            Text('状态栏高度:${ScreenScale.statusBarHeight}dp'),
            Text(
              '实际宽度的dp与设计稿px的比例:${ScreenScale.scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度的dp与设计稿px的比例:${ScreenScale.scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 100.h,
            ),
            Text('系统的字体缩放比例:${ScreenScale.textScaleFactor}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('我的文字大小在设计稿上是24px，不会随着系统的文字缩放比例变化',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.px,
                    )),
                Text('我的文字大小在设计稿上是24px，会随着系统的文字缩放比例变化',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenScale.convertFontSize(24,
                            allowFontScaling: true))),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.title),
        onPressed: () {
          ScreenScaleProperties(
              width: 1500,
              height: 1334,
              allowFontScaling: false,
              allowSubpixel: true);
          setState(() {});
        },
      ),
    );
  }

  void printScreenInformation() {
    print('设备宽度:${ScreenScale.screenWidth}'); //Device width
    print('设备高度:${ScreenScale.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenScale.pixelRatio}'); //Device pixel density
    print(
        '底部安全区距离:${ScreenScale.bottomBarHeight}dp'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        '状态栏高度:${ScreenScale.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit px

    print('实际宽度的dp与设计稿px的比例:${ScreenScale.scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenScale.scaleHeight}');

    print(
        '宽度和字体相对于设计稿放大的比例:${ScreenScale.scaleWidth * ScreenScale.pixelRatio}');
    print('高度相对于设计稿放大的比例:${ScreenScale.scaleHeight * ScreenScale.pixelRatio}');
    print('系统的字体缩放比例:${ScreenScale.textScaleFactor}');

    print('屏幕宽度的0.5:${0.5.wp}');
    print('屏幕高度的0.5:${0.5.hp}');
  }
}
