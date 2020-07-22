import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)

    ScreenProperties(width: 750, height: 1334, allowFontScaling: false);

    return ExampleWidget(title: 'FlutterScreenUtil示例');
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key key, this.title}) : super(key: key);

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
                  padding: EdgeInsets.all(ScreenUtil.instance.convertWidth(10)),
                  width: ScreenUtil.instance.convertWidth(375),
                  height: ScreenUtil.instance.convertHeight(200),
                  color: Colors.red,
                  child: Text(
                    '我的宽度:${0.5.wp}dp \n'
                    '我的高度:${ScreenUtil.instance.convertHeight(200)}dp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil.instance.convertFontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil.instance.convertWidth(10)),
                  width: 375.w,
                  height: 200.h,
                  color: Colors.blue,
                  child: Text(
                      '我的宽度:${375.w}dp \n'
                      '我的高度:${200.h}dp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil.instance.convertFontSize(24))),
                ),
              ],
            ),
            Text('设备宽度:${ScreenUtil.screenWidthPx}px'),
            Text('设备高度:${ScreenUtil.screenHeightPx}px'),
            Text('设备宽度:${ScreenUtil.screenWidth}dp'),
            Text('设备高度:${ScreenUtil.screenHeight}dp'),
            Text('设备的像素密度:${ScreenUtil.pixelRatio}'),
            Text('底部安全区距离:${ScreenUtil.bottomBarHeight}dp'),
            Text('状态栏高度:${ScreenUtil.statusBarHeight}dp'),
            Text(
              '实际宽度的dp与设计稿px的比例:${ScreenUtil.instance.scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              '实际高度的dp与设计稿px的比例:${ScreenUtil.instance.scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 100.h,
            ),
            Text('系统的字体缩放比例:${ScreenUtil.textScaleFactor}'),
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
                        fontSize: ScreenUtil.instance
                            .convertFontSize(24, allowFontScaling: true))),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.title),
        onPressed: () {
          ScreenProperties(width: 1500, height: 1334, allowFontScaling: false);
          setState(() {});
        },
      ),
    );
  }

  void printScreenInformation() {
    print('设备宽度:${ScreenUtil.screenWidth}'); //Device width
    print('设备高度:${ScreenUtil.screenHeight}'); //Device height
    print('设备的像素密度:${ScreenUtil.pixelRatio}'); //Device pixel density
    print(
        '底部安全区距离:${ScreenUtil.bottomBarHeight}dp'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        '状态栏高度:${ScreenUtil.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit px

    print('实际宽度的dp与设计稿px的比例:${ScreenUtil.instance.scaleWidth}');
    print('实际高度的dp与设计稿px的比例:${ScreenUtil.instance.scaleHeight}');

    print(
        '宽度和字体相对于设计稿放大的比例:${ScreenUtil.instance.scaleWidth * ScreenUtil.pixelRatio}');
    print(
        '高度相对于设计稿放大的比例:${ScreenUtil.instance.scaleHeight * ScreenUtil.pixelRatio}');
    print('系统的字体缩放比例:${ScreenUtil.textScaleFactor}');

    print('屏幕宽度的0.5:${0.5.wp}');
    print('屏幕高度的0.5:${0.5.hp}');
  }
}
