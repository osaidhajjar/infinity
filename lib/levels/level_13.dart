import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_spot_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level13 extends StatefulWidget {
  final String title = "المستوى الثالث عشر";
  final String mission = "ساعدني للحصول على اللون البنفسجي";

  Level13({Key key}) : super(key: key);

  @override
  _Level13State createState() => _Level13State();
}

class _Level13State extends State<Level13> {
  double _width = 0;
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
    double dropHeight = AppData.getSize(250, context);
    double dropWidth = AppData.getSize(100, context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Image(
          width: dropWidth,
          height: dropHeight,
          image: AssetImage('assets/drop_' + color + '.png'),
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
        onTap: () => setState(() {
          showStar1 = !showStar1;
          _checkResults(true);
        }),
        child: getptionWidget('red', showStar1),
      ),
      GestureDetector(
        onTap: () => setState(() {
          showStar2 = !showStar2;
          _checkResults(true);
        }),
        child: getptionWidget('blue', showStar2),
      ),
      GestureDetector(
        onTap: () => setState(() {
          _checkResults(false);
        }),
        child: getptionWidget('green', false),
      ),
      GestureDetector(
        onTap: () => setState(() {
          _checkResults(true);
        }),
        child: getptionWidget('yellow', false),
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

                Flexible(flex: 55, fit: FlexFit.loose, child: Center()),
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
                    )))
          ],
        )));
  }
}
