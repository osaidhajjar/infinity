import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_spot_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level15 extends StatefulWidget {
  final String title = "المستوى الخامس عشر";
  final String mission = "ما هو اللون الناقص من دائرة الالوان";

  Level15({Key key}) : super(key: key);

  @override
  _Level15State createState() => _Level15State();
}

class _Level15State extends State<Level15> {
  double _width = 0;
  Color selectedColor = Colors.grey;
  bool _correct = false;
  bool _isCompact;

  List<ColorSpotWidget> _colorsWidgets = [
    ColorSpotWidget(color: Colors.blue),
    ColorSpotWidget(color: Colors.green),
    ColorSpotWidget(color: Colors.black),
    ColorSpotWidget(color: Colors.orange)
  ];

  void _checkResults() {
    if (selectedColor == Colors.green) {
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
                        child: DragTarget<Color>(
                            builder: (_, candidateData, rejectedData) {
                              return Image(
                                  gaplessPlayback: true,
                                  image: AssetImage('assets/pie' +
                                      (selectedColor == Colors.green
                                          ? ''
                                          : '_missing_green') +
                                      '.gif'),
                                  width: kIsWeb
                                      ? 400 /
                                          MediaQuery.of(context)
                                              .devicePixelRatio
                                      : 400,
                                  height: kIsWeb
                                      ? 300 /
                                          MediaQuery.of(context)
                                              .devicePixelRatio
                                      : 300);
                            },
                            onWillAccept: (data) =>
                                data == Colors.green ? true : false,
                            onAccept: (data) {
                              selectedColor = data;
                              _checkResults();
                            }))),
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
                                  padding: const EdgeInsets.all(8.0),
                                  child: cSpot,
                                ),
                              ))
                          .toList()),
                ),
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
                    child: _correct
                        ? Container(
                            color: Colors.purple,
                            child: Padding(
                              padding:
                                  EdgeInsets.all(AppData.getSize(20, context)),
                              child: Image(
                                image: AssetImage('assets/trophy3.gif'),
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
