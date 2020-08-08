import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screen_scaling/flutter_screen_scaling.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Screen Scaling',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    ScreenScaleProperties(width: 750, height: 1334, allowFontScaling: false);

    return ExampleWidget(title: 'Screen Scaling Demo');
  }
}

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    //printScreenInformation();
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
                  width: 375.w,
                  height: 200.h,
                  color: Colors.red,
                  child: Text(
                    'My width:${375.w}dp \n'
                    'My height:${200.h}dp',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenScale.convertFontSize(24)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenScale.convertWidth(10)),
                  width: ScreenScale.convertWidth(375),
                  height: ScreenScale.convertHeight(200),
                  color: Colors.blue,
                  child: Text(
                      'My width:${0.5.wp}dp \n'
                      'My height:${ScreenScale.convertHeight(200)}dp',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenScale.convertFontSize(24))),
                ),
              ],
            ),
            Text('Device width:${ScreenScale.screenWidthPx}px'),
            Text('Device height:${ScreenScale.screenHeightPx}px'),
            Text('Device width:${ScreenScale.screenWidth}dp'),
            Text('Device height:${ScreenScale.screenHeight}dp'),
            Text('Device pixel density:${ScreenScale.pixelRatio}'),
            Text('Bottom safe zone distance:${ScreenScale.bottomBarHeight}dp'),
            Text('Status bar height:${ScreenScale.statusBarHeight}dp'),
            Text(
              'Ratio of actual width dp to design draft px:${ScreenScale.scaleWidth}',
              textAlign: TextAlign.center,
            ),
            Text(
              'Ratio of actual height dp to design draft px:${ScreenScale.scaleHeight}',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ScreenScale.convertHeight(100),
            ),
            Text('System font scaling factor:${ScreenScale.textScaleFactor}'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'My font size is 24px on the design draft and will not change with the system.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.px,
                    )),
                Text(
                    'My font size is 24px on the design draft and will change with the system.',
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
          ScreenScale.init(width: 1500, height: 1334, allowFontScaling: false);
          setState(() {});
        },
      ),
    );
  }

  void printScreenInformation() {
    print('Device width dp:${ScreenScale.screenWidth}'); //Device width
    print('Device height dp:${ScreenScale.screenHeight}'); //Device height
    print(
        'Device pixel density:${ScreenScale.pixelRatio}'); //Device pixel density
    print(
        'Bottom safe zone distance dp:${ScreenScale.bottomBarHeight}'); //Bottom safe zone distance，suitable for buttons with full screen
    print(
        'Status bar height px:${ScreenScale.statusBarHeight}dp'); //Status bar height , Notch will be higher Unit px
    print(
        'Ratio of actual width dp to design draft px:${ScreenScale.scaleWidth}');
    print(
        'Ratio of actual height dp to design draft px:${ScreenScale.scaleHeight}');
    print(
        'The ratio of font and width to the size of the design:${ScreenScale.scaleWidth * ScreenScale.pixelRatio}');
    print(
        'The ratio of  height width to the size of the design:${ScreenScale.scaleHeight * ScreenScale.pixelRatio}');
    print('System font scaling:${ScreenScale.textScaleFactor}');
    print('0.5 times the screen width:${0.5.wp}');
    print('0.5 times the screen height:${0.5.hp}');
  }
}
