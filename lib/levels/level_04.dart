import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_spot_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level04 extends StatefulWidget {
  final String title = "المستوى الرابع";
  final String mission = "يعتبر اللون البنفسجي من الألوان";

  Level04({Key key}) : super(key: key);

  @override
  _Level04State createState() => _Level04State();
}

class _Level04State extends State<Level04> {
  double _width = 0;
  Color selectedColor = Colors.grey;
  bool _correct = false;
  bool _isCompact;

  void _checkResults(bool isCorrect) {
    if (isCorrect) {
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
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    fit: FlexFit.loose,
                    child: Center(
                        child: Image(
                      image: AssetImage('assets/box_purple.png'),
                    ))),
                Flexible(
                    flex: 20,
                    fit: FlexFit.loose,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: GestureDetector(
                                  onTap: () => _checkResults(true),
                                  child: Image(
                                      image:
                                          AssetImage('assets/button_cold.png'),
                                      width: kIsWeb
                                          ? 170 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 170,
                                      height: kIsWeb
                                          ? 70 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 70),
                                ),
                              )),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.loose,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: GestureDetector(
                                  onTap: () => _checkResults(false),
                                  child: Image(
                                      image:
                                          AssetImage('assets/button_hot.png'),
                                      width: kIsWeb
                                          ? 170 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 170,
                                      height: kIsWeb
                                          ? 70 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 70),
                                ),
                              ))
                        ])),
                Flexible(flex: 35, fit: FlexFit.loose, child: Center()),
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
