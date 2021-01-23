import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level19 extends StatefulWidget {
  final String title = "المستوى التاسع عشر";
  final String mission =
      "فالنقم باختيار لونين من هذه الألوان لتحقيق التوافق اللوني";

  Level19({Key key}) : super(key: key);

  @override
  _Level19State createState() => _Level19State();
}

class _Level19State extends State<Level19> {
  double _width = 0;
  double _widthCircle = 0;
  int selectedColors = 0;
  bool _correct = false;
  bool colorsCorrect = true;
  bool _isCompact;

  bool showStar1 = false;
  bool showStar2 = false;

  List<Widget> _colorsWidgets;

  void _checkResults(bool correct) {
    if (!correct) {
      setState(() {
        _width = kIsWeb ? 300 / MediaQuery.of(context).devicePixelRatio : 300;
        _correct = false;
      });

      Timer(Duration(seconds: 2), () {
        setState(() {
          _width = 0;
        });
      });
    } else if (showStar1 && showStar2) {
      if (colorsCorrect) {
        Timer(Duration(milliseconds: 500), () {
          setState(() {
            _width =
                kIsWeb ? 300 / MediaQuery.of(context).devicePixelRatio : 300;
            _correct = true;
          });

          AppData.currentLevel++;
          Timer(Duration(seconds: 5), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => AppData.levels[AppData.currentLevel]),
                (Route<dynamic> route) => false);
          });
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget getptionWidget(String color, bool showCheck) {
    double dropHeight = AppData.getSize(100, context);
    double dropWidth = AppData.getSize(100, context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          width: dropWidth,
          height: dropHeight,
          image: AssetImage('assets/box_' + color + '.png'),
        ),
        Container(
          width: dropWidth,
          height: dropHeight,
          child: showCheck
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Icon(Icons.check_circle,
                      color: AppData.appBarColor,
                      size: kIsWeb
                          ? 50 / MediaQuery.of(context).devicePixelRatio
                          : 50),
                )
              : Center(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _colorsWidgets = [
      GestureDetector(
        onTap: () {
          _checkResults(false);
        },
        child: getptionWidget('yellow', false),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            showStar1 = !showStar1;
          });
          _checkResults(true);
        },
        child: getptionWidget('red', showStar1),
      ),
      GestureDetector(
        onTap: () {
          _checkResults(false);
        },
        child: getptionWidget('black', false),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            showStar2 = !showStar2;
          });
          _checkResults(true);
        },
        child: getptionWidget('purple', showStar2),
      ),
      GestureDetector(
        onTap: () {
          _checkResults(false);
        },
        child: getptionWidget('white', false),
      ),
    ];

    _isCompact = !kIsWeb ||
        (MediaQuery.of(context).size.width /
                MediaQuery.of(context).devicePixelRatio) <
            500 / MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
        appBar: AppData.getAppBar(widget.title, context),
        body: SafeArea(
            child: Stack(
          children: [
            AppData.getBackgroundWidget(context),
            Column(
              children: [
                Flexible(flex: 5, fit: FlexFit.loose, child: Center()),
                Flexible(
                  flex: 10,
                  fit: FlexFit.loose,
                  child: Center(
                      child: Text(widget.mission,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: kIsWeb
                                  ? 30 / MediaQuery.of(context).devicePixelRatio
                                  : 30,
                              color: Colors.black))),
                ),
                Flexible(
                  flex: 40,
                  fit: FlexFit.tight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _colorsWidgets
                          .map((cSpot) => Flexible(
                                flex: 10,
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      AppData.getSize(20, context)),
                                  child: cSpot,
                                ),
                              ))
                          .toList()),
                ),
                // Flexible(flex: 10, fit: FlexFit.loose, child: Center()),
                Flexible(
                    flex: 25,
                    fit: FlexFit.loose,
                    child: Center(
                        child: GestureDetector(
                      onTap: () => setState(() {
                        _widthCircle = AppData.getSize(400, context);
                        _correct = true;
                      }),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            width: AppData.getSize(100, context),
                            height: AppData.getSize(100, context),
                            image: AssetImage('assets/color_circle.jpg'),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.all(AppData.getSize(10, context)),
                            child: Text(
                              'الإستعانة بالدائرة اللونية',
                              style: TextStyle(
                                  fontSize: AppData.getSize(20, context)),
                            ),
                          )
                        ],
                      ),
                    ))),
                Flexible(flex: 30, fit: FlexFit.loose, child: Center()),
              ],
            ),
            _correct
                ? Opacity(opacity: 0.3, child: Container(color: Colors.black))
                : Center(),
            Center(
                child: AnimatedContainer(
                    width: _width,
                    height: _width,
                    duration: Duration(seconds: 1),
                    child: Image(
                      image: AssetImage(
                          _correct ? 'assets/correct.png' : 'assets/wrong.png'),
                    ))),
            Center(
                child: AnimatedContainer(
                    width: _widthCircle,
                    height: _widthCircle,
                    duration: Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _widthCircle = 0;
                          _correct = false;
                        });
                      },
                      child: Image(
                        image: AssetImage('assets/color_circle.jpg'),
                      ),
                    )))
          ],
        )));
  }
}
