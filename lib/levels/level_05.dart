import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_spot_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level05 extends StatefulWidget {
  final String title = "المستوى الخامس";
  final String mission = "هيا لنخلط اللونين الذين سينتجو اللون الأحمر الغامق";

  Level05({Key key}) : super(key: key);

  @override
  _Level05State createState() => _Level05State();
}

class _Level05State extends State<Level05> {
  double _width = 0;
  int selectedColors = 0;
  Color firstColor = Colors.grey;
  bool _correct = false;
  bool _isCompact;

  List<ColorSpotWidget> _colorsWidgets = [
    ColorSpotWidget(color: Colors.black),
    ColorSpotWidget(color: Colors.orange),
    ColorSpotWidget(color: Colors.red),
    ColorSpotWidget(color: Colors.grey[200])
  ];

  void _checkResults() {
    if (selectedColors == 2) {
      Timer(Duration(milliseconds: 500), () {
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
                // Flexible(flex: 10, fit: FlexFit.loose, child: Center()),
                Flexible(
                    flex: 40,
                    fit: FlexFit.loose,
                    child: Center(
                        child: DragTarget<Color>(
                            builder: (_, candidateData, rejectedData) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image(
                                        gaplessPlayback: true,
                                        image:
                                            AssetImage('assets/brush_base.png'),
                                        width: kIsWeb
                                            ? 400 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 400,
                                        height: kIsWeb
                                            ? 300 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 300),
                                  ),
                                  selectedColors == 0
                                      ? Text(
                                          '?',
                                          style: TextStyle(
                                              fontSize: kIsWeb
                                                  ? 50 /
                                                      MediaQuery.of(context)
                                                          .devicePixelRatio
                                                  : 50),
                                        )
                                      : Image(
                                          image: AssetImage('assets/spot.png'),
                                          color: selectedColors <= 1
                                              ? firstColor
                                              : Colors.red[900],
                                          width: kIsWeb
                                              ? 70 /
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio
                                              : 70,
                                          height: kIsWeb
                                              ? 70 /
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio
                                              : 70)
                                ],
                              );
                            },
                            onWillAccept: (data) =>
                                data == Colors.red || data == Colors.black
                                    ? true
                                    : false,
                            onAccept: (data) {
                              firstColor = data;
                              selectedColors++;
                              _checkResults();
                            }))),

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
                                image: AssetImage('assets/trophy1.gif'),
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
