import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_box_widget.dart';
import 'package:gamification/widgets/color_spot_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level12 extends StatefulWidget {
  final String title = "المستوى الثاني عشر";
  final String mission = "ماهو ناتج المعادلة التالية ؟";

  Level12({Key key}) : super(key: key);

  @override
  _Level12State createState() => _Level12State();
}

class _Level12State extends State<Level12> {
  double _width = 0;
  String selectedColor = "nothing";
  bool _correct = false;
  bool _isCompact;

  List<ColorBoxWidget> _colorsWidgets = [
    ColorBoxWidget(color: "orange"),
    ColorBoxWidget(color: "pink"),
    ColorBoxWidget(color: "purple")
  ];

  void _checkResults() {
    if (selectedColor == "orange") {
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
                Flexible(
                  flex: 20,
                  fit: FlexFit.loose,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 10,
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: EdgeInsets.all(kIsWeb
                                ? 20 / MediaQuery.of(context).devicePixelRatio
                                : 20),
                            child: Image(
                                image: AssetImage('assets/box_yellow.png'),
                                width: kIsWeb
                                    ? 100 /
                                        MediaQuery.of(context).devicePixelRatio
                                    : 100,
                                height: kIsWeb
                                    ? 100 /
                                        MediaQuery.of(context).devicePixelRatio
                                    : 100),
                          ),
                        ),
                        Flexible(
                            flex: 10,
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: EdgeInsets.all(kIsWeb
                                  ? 20 / MediaQuery.of(context).devicePixelRatio
                                  : 20),
                              child: Text(
                                '+',
                                style: TextStyle(
                                    fontSize: kIsWeb
                                        ? 50 /
                                            MediaQuery.of(context)
                                                .devicePixelRatio
                                        : 50),
                              ),
                            )),
                        Flexible(
                          flex: 10,
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: EdgeInsets.all(kIsWeb
                                ? 20 / MediaQuery.of(context).devicePixelRatio
                                : 20),
                            child: Image(
                                image: AssetImage('assets/box_red.png'),
                                width: kIsWeb
                                    ? 100 /
                                        MediaQuery.of(context).devicePixelRatio
                                    : 100,
                                height: kIsWeb
                                    ? 100 /
                                        MediaQuery.of(context).devicePixelRatio
                                    : 100),
                          ),
                        ),
                        Flexible(
                            flex: 10,
                            fit: FlexFit.loose,
                            child: Padding(
                              padding: EdgeInsets.all(kIsWeb
                                  ? 20 / MediaQuery.of(context).devicePixelRatio
                                  : 20),
                              child: Text(
                                '=',
                                style: TextStyle(
                                    fontSize: kIsWeb
                                        ? 50 /
                                            MediaQuery.of(context)
                                                .devicePixelRatio
                                        : 50),
                              ),
                            )),
                        Flexible(
                          flex: 10,
                          fit: FlexFit.loose,
                          child: DragTarget<String>(
                              builder: (_, candidateData, rejectedData) {
                                return selectedColor != "orange"
                                    ? Padding(
                                        padding: EdgeInsets.all(kIsWeb
                                            ? 8 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 8),
                                        child: Text(
                                          '?',
                                          style: TextStyle(
                                              fontSize: kIsWeb
                                                  ? 50 /
                                                      MediaQuery.of(context)
                                                          .devicePixelRatio
                                                  : 50),
                                        ),
                                      )
                                    : Image(
                                        image: AssetImage('assets/box_' +
                                            selectedColor +
                                            '.png'),
                                        width: kIsWeb
                                            ? 100 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 100,
                                        height: kIsWeb
                                            ? 100 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 100);
                              },
                              onWillAccept: (data) =>
                                  data == "orange" ? true : false,
                              onAccept: (data) {
                                selectedColor = data;
                                _checkResults();
                              }),
                        )
                      ]),
                ),
                Flexible(flex: 10, fit: FlexFit.loose, child: Center()),
                Flexible(
                  flex: 20,
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
