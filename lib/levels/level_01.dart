import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_spot_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level01 extends StatefulWidget {
  final String title = "المستوى الأول";
  final String mission = "ضع بقع الألوان في مكانها الصحيح";

  Level01({Key key}) : super(key: key);

  @override
  _Level01State createState() => _Level01State();
}

class _Level01State extends State<Level01> {
  List<Color> _whatInColdBox = [Colors.grey, Colors.grey, Colors.grey];
  List<Color> _whatInHotBox = [Colors.grey, Colors.grey, Colors.grey];
  double _width = 0;
  bool _correct = false;
  bool _isCompact;

  List<ColorSpotWidget> _colorsWidgets = [
    ColorSpotWidget(color: Colors.green),
    ColorSpotWidget(color: Colors.yellow),
    ColorSpotWidget(color: Colors.blue),
    ColorSpotWidget(color: Colors.red),
    ColorSpotWidget(color: Colors.orange),
    ColorSpotWidget(color: Colors.purple)
  ];

  List<Color> _coldColors = [Colors.green, Colors.blue, Colors.purple];
  List<Color> _hotColors = [Colors.red, Colors.orange, Colors.yellow];

  void _checkResults() {
    bool userCompletedWork = (!_whatInColdBox.contains(Colors.grey) &&
        !_whatInHotBox.contains(Colors.grey));

    if (userCompletedWork) {
      bool resultCheck = true;

      _whatInColdBox.forEach((element) {
        if (!_coldColors.contains(element)) resultCheck = false;
      });

      _whatInHotBox.forEach((element) {
        if (!_hotColors.contains(element)) resultCheck = false;
      });

      if (resultCheck) {
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
      }
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

    print("====== width: " + (MediaQuery.of(context).size.width).toString());
    print("====== width/ratio: " +
        (MediaQuery.of(context).size.width /
                MediaQuery.of(context).devicePixelRatio)
            .toString());
    print("====== ratio: " +
        (MediaQuery.of(context).devicePixelRatio).toString());

    print("====== isCompact: " + _isCompact.toString());

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false),
              child: Icon(Icons.home)),
        ),
        body: SafeArea(
            child: Stack(
          children: [
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: _isCompact
                              ? coldWidget()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    coldWidget(),
                                  ],
                                ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: _isCompact
                              ? hotWidget()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    hotWidget(),
                                  ],
                                ),
                        ),
                      ]),
                ),
                Flexible(flex: 5, fit: FlexFit.loose, child: Center()),
                Flexible(
                  flex: 10,
                  fit: FlexFit.loose,
                  child: _correct
                      ? Center()
                      : GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => Level01()),
                                (Route<dynamic> route) => false);
                          },
                          child: Center(
                            child: Container(
                                width: kIsWeb
                                    ? 200 /
                                        MediaQuery.of(context).devicePixelRatio
                                    : 200,
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(kIsWeb
                                            ? 20 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 20.0))),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      'إعادة المحاولة',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: kIsWeb
                                              ? 20 /
                                                  MediaQuery.of(context)
                                                      .devicePixelRatio
                                              : 20),
                                    ),
                                  ),
                                )),
                          )),
                ),
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
                      image: AssetImage(_correct
                          ? 'assets/star.png'
                          : 'assets/try_again.png'),
                    )))
          ],
        )));
  }

  Widget hotWidget() {
    double spotSize =
        kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70;

    double boxSize =
        kIsWeb ? 300 / MediaQuery.of(context).devicePixelRatio : 300;

    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image(
              image: AssetImage('assets/hot_box.gif'),
              width: boxSize,
              height: boxSize,
              fit: BoxFit.scaleDown),
        ),
        Container(
          width: boxSize,
          height: boxSize,
          child: Align(
            alignment: Alignment(0.4, 0.4),
            child: DragTarget<Color>(
                builder: (_, candidateData, rejectedData) {
                  return Image(
                      image: AssetImage('assets/spot.png'),
                      color: _whatInHotBox[0],
                      width: spotSize,
                      height: spotSize);
                },
                onWillAccept: (data) =>
                    _hotColors.contains(data) && _whatInHotBox[0] == Colors.grey
                        ? true
                        : false,
                onAccept: (data) {
                  _whatInHotBox[0] = data;
                  _checkResults();
                }),
          ),
        ),
        Container(
            width: boxSize,
            height: boxSize,
            child: Align(
              alignment: Alignment(-0.6, 0.4),
              child:
                  DragTarget<Color>(builder: (_, candidateData, rejectedData) {
                return Image(
                    image: AssetImage('assets/spot.png'),
                    color: _whatInHotBox[1],
                    width: spotSize,
                    height: spotSize);
              }, onWillAccept: (data) {
                print(_whatInColdBox.contains(data));
                return _hotColors.contains(data) &&
                        _whatInHotBox[1] == Colors.grey
                    ? true
                    : false;
              }, onAccept: (data) {
                _whatInHotBox[1] = data;
                _checkResults();
              }),
            )),
        Container(
          width: boxSize,
          height: boxSize,
          child: Align(
            alignment: Alignment(0, 0.05),
            child: DragTarget<Color>(
                builder: (_, candidateData, rejectedData) {
                  return Image(
                      image: AssetImage('assets/spot.png'),
                      color: _whatInHotBox[2],
                      width: spotSize,
                      height: spotSize);
                },
                onWillAccept: (data) =>
                    _hotColors.contains(data) && _whatInHotBox[2] == Colors.grey
                        ? true
                        : false,
                onAccept: (data) {
                  _whatInHotBox[2] = data;
                  _checkResults();
                }),
          ),
        )
      ],
    );
  }

  Widget coldWidget() {
    double spotSize =
        kIsWeb ? 70 / MediaQuery.of(context).devicePixelRatio : 70;

    double boxSize =
        kIsWeb ? 300 / MediaQuery.of(context).devicePixelRatio : 300;
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Image(
              image: AssetImage('assets/cold_box.gif'),
              width: boxSize,
              height: boxSize),
        ),
        Container(
          width: boxSize,
          height: boxSize,
          child: Align(
            alignment: Alignment(0.4, 0.4),
            child: DragTarget<Color>(
                builder: (_, candidateData, rejectedData) {
                  return Image(
                      image: AssetImage('assets/spot.png'),
                      color: _whatInColdBox[0],
                      width: spotSize,
                      height: spotSize);
                },
                onWillAccept: (data) => _coldColors.contains(data) &&
                        _whatInColdBox[0] == Colors.grey
                    ? true
                    : false,
                onAccept: (data) {
                  _whatInColdBox[0] = data;
                  _checkResults();
                }),
          ),
        ),
        Container(
            width: boxSize,
            height: boxSize,
            child: Align(
              alignment: Alignment(-0.6, 0.4),
              child:
                  DragTarget<Color>(builder: (_, candidateData, rejectedData) {
                return Image(
                    image: AssetImage('assets/spot.png'),
                    color: _whatInColdBox[1],
                    width: spotSize,
                    height: spotSize);
              }, onWillAccept: (data) {
                print(_whatInColdBox.contains(data));
                return _coldColors.contains(data) &&
                        _whatInColdBox[1] == Colors.grey
                    ? true
                    : false;
              }, onAccept: (data) {
                _whatInColdBox[1] = data;
                _checkResults();
              }),
            )),
        Container(
          width: boxSize,
          height: boxSize,
          child: Align(
            alignment: Alignment(0, 0.05),
            child: DragTarget<Color>(
                builder: (_, candidateData, rejectedData) {
                  return Image(
                      image: AssetImage('assets/spot.png'),
                      color: _whatInColdBox[2],
                      width: spotSize,
                      height: spotSize);
                },
                onWillAccept: (data) => _coldColors.contains(data) &&
                        _whatInColdBox[2] == Colors.grey
                    ? true
                    : false,
                onAccept: (data) {
                  _whatInColdBox[2] = data;
                  _checkResults();
                }),
          ),
        )
      ],
    );
  }
}
