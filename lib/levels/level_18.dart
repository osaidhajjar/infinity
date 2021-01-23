import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level18 extends StatefulWidget {
  final String title = "المستوى الثامن عشر";
  final String mission = "ركز جيداً، واخبرني ايهما اكثر وضوحا";

  Level18({Key key}) : super(key: key);

  @override
  _Level18State createState() => _Level18State();
}

class _Level18State extends State<Level18> {
  double _width = 0;
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
        onTap: () => _checkResults(false),
        child: Container(
            width: AppData.getSize(150, context),
            height: AppData.getSize(150, context),
            color: Colors.grey,
            child: Center(
              child: CircleAvatar(
                  radius: AppData.getSize(50, context),
                  backgroundColor: Colors.blue[800]),
            )),
      ),
      GestureDetector(
        onTap: () => _checkResults(true),
        child: Container(
            width: AppData.getSize(150, context),
            height: AppData.getSize(150, context),
            color: Colors.grey,
            child: Center(
              child: CircleAvatar(
                  radius: AppData.getSize(50, context),
                  backgroundColor: Colors.yellow),
            )),
      ),
      GestureDetector(
        onTap: () => _checkResults(false),
        child: Container(
            width: AppData.getSize(150, context),
            height: AppData.getSize(150, context),
            color: Colors.grey,
            child: Center(
              child: CircleAvatar(
                  radius: AppData.getSize(50, context),
                  backgroundColor: Colors.green[800]),
            )),
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

                // Flexible(flex: 10, fit: FlexFit.loose, child: Center()),
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
