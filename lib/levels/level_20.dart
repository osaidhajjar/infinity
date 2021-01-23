import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level20 extends StatefulWidget {
  final String title = "المستوى العشرون";
  final String mission =
      "برأيك أي لون من هذه الألوان يحقق التضاد اللوني مع اللون البرتقالي";

  Level20({Key key}) : super(key: key);

  @override
  _Level20State createState() => _Level20State();
}

class _Level20State extends State<Level20> {
  double _width = 0;
  double _widthCircle = 0;
  Color selectedColor = Colors.grey;
  bool _correct = false;
  bool _isCompact;

  List<Widget> _colorsWidgets;

  void _checkResults(bool correct) {
    if (correct) {
      setState(() {
        _width = kIsWeb ? 300 / MediaQuery.of(context).devicePixelRatio : 300;
        _correct = true;
      });

      AppData.currentLevel++;
      Timer(Duration(seconds: 5), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => AppData.levels[AppData.currentLevel]),
            (Route<dynamic> route) => false);
      });
    } else {
      setState(() {
        _width = kIsWeb ? 300 / MediaQuery.of(context).devicePixelRatio : 300;
        _correct = false;
      });

      Timer(Duration(seconds: 2), () {
        setState(() {
          _width = 0;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _colorsWidgets = [
      GestureDetector(
        onTap: () => _checkResults(true),
        child: Image(
          image: AssetImage('assets/brush_blue.gif'),
          width: AppData.getSize(100, context),
          height: AppData.getSize(250, context),
        ),
      ),
      GestureDetector(
        onTap: () => _checkResults(false),
        child: Image(
          image: AssetImage('assets/brush_yellow.gif'),
          width: AppData.getSize(100, context),
          height: AppData.getSize(250, context),
        ),
      ),
      GestureDetector(
        onTap: () => _checkResults(false),
        child: Image(
          image: AssetImage('assets/brush_black.gif'),
          width: AppData.getSize(100, context),
          height: AppData.getSize(250, context),
        ),
      ),
      GestureDetector(
        onTap: () => _checkResults(false),
        child: Image(
          image: AssetImage('assets/brush_red.gif'),
          width: AppData.getSize(100, context),
          height: AppData.getSize(250, context),
        ),
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
                  flex: 25,
                  fit: FlexFit.loose,
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(widget.mission,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: kIsWeb
                                  ? 30 / MediaQuery.of(context).devicePixelRatio
                                  : 30,
                              color: Colors.black)),
                      Image(
                          image: AssetImage('assets/brush_orange.gif'),
                          width: AppData.getSize(50, context),
                          height: AppData.getSize(125, context))
                    ],
                  )),
                ),

                // Flexible(flex: 10, fit: FlexFit.loose, child: Center()),
                Flexible(
                  flex: 45,
                  fit: FlexFit.tight,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _colorsWidgets
                          .map((cSpot) => Flexible(
                                flex: 10,
                                fit: FlexFit.loose,
                                child: Padding(
                                  padding: EdgeInsets.all(kIsWeb
                                      ? 30 /
                                          MediaQuery.of(context)
                                              .devicePixelRatio
                                      : 30),
                                  child: cSpot,
                                ),
                              ))
                          .toList()),
                ),
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
                Flexible(flex: 20, fit: FlexFit.loose, child: Center()),
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
                    width: _width,
                    height: _width,
                    duration: Duration(seconds: 1),
                    child: _correct
                        ? Container(
                            color: Colors.purple,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(AppData.getSize(20, context)),
                              child: Image(
                                image: AssetImage('assets/trophy4.gif'),
                              ),
                            ),
                          )
                        : Image(
                            image: AssetImage('assets/wrong.png'),
                          )))
          ],
        )));
  }
}
