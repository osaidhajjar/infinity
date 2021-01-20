import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:gamification/widgets/color_spot_widget.dart';

class Level01 extends StatefulWidget {
  final String title = "المستوى الأول";
  final String mission = "ضع بقع الألوان في مكانها الصحيح";

  Level01({Key key}) : super(key: key);

  @override
  _Level01State createState() => _Level01State();
}

class _Level01State extends State<Level01> {
  List<ColorSpotWidget> _colorsWidgets;
  List<Color> whatInColdBox = [Colors.grey, Colors.grey, Colors.grey];
  List<Color> whatInHotBox = [Colors.grey, Colors.grey, Colors.grey];
  double _width = 0;
  bool correct = false;

  void _checkResults() {
    if (whatInColdBox.contains(Colors.green) &&
        whatInColdBox.contains(Colors.blue) &&
        whatInColdBox.contains(Colors.purple) &&
        whatInHotBox.contains(Colors.red) &&
        whatInHotBox.contains(Colors.orange) &&
        whatInHotBox.contains(Colors.yellow)) {
      setState(() {
        _width = 100;
        correct = true;
        AppData.currentLevel++;
      });
      Timer(Duration(seconds: 2), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) => AppData.levels[AppData.currentLevel]),
            (Route<dynamic> route) => false);
      });
    } else if (!whatInColdBox.contains(Colors.grey) &&
        !whatInHotBox.contains(Colors.grey)) {
      setState(() {
        _width = 100;
        correct = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _colorsWidgets = [
      ColorSpotWidget(color: Colors.green),
      ColorSpotWidget(color: Colors.yellow),
      ColorSpotWidget(color: Colors.blue),
      ColorSpotWidget(color: Colors.red),
      ColorSpotWidget(color: Colors.orange),
      ColorSpotWidget(color: Colors.purple)
    ];
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
          children: [
            Flexible(flex: 10, fit: FlexFit.tight, child: Center()),
            Flexible(
              flex: 10,
              fit: FlexFit.tight,
              child: FittedBox(
                child: Center(
                    child: Text(widget.mission,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black))),
              ),
            ),
            Flexible(
              flex: 20,
              fit: FlexFit.tight,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _colorsWidgets
                      .map((cSpot) => Flexible(
                            flex: 10,
                            fit: FlexFit.tight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: cSpot,
                            ),
                          ))
                      .toList()),
            ),
            Flexible(flex: 10, fit: FlexFit.tight, child: Center()),
            Flexible(
              flex: 40,
              fit: FlexFit.tight,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(image: AssetImage('assets/cold_box.gif')),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: DragTarget<Color>(
                          builder: (_, candidateData, rejectedData) {
                            return Image(
                                image: AssetImage('assets/spot.png'),
                                color: whatInColdBox[0]);
                          },
                          onWillAccept: (data) => [
                                    Colors.green,
                                    Colors.blue,
                                    Colors.purple
                                  ].contains(data) &&
                                  whatInColdBox[0] == Colors.grey
                              ? true
                              : false,
                          onAccept: (data) {
                            whatInColdBox[0] = data;
                            _checkResults();
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 100),
                      child: DragTarget<Color>(
                          builder: (_, candidateData, rejectedData) {
                        return Image(
                            image: AssetImage('assets/spot.png'),
                            color: whatInColdBox[1]);
                      }, onWillAccept: (data) {
                        print(whatInColdBox.contains(data));
                        return [Colors.green, Colors.blue, Colors.purple]
                                    .contains(data) &&
                                whatInColdBox[1] == Colors.grey
                            ? true
                            : false;
                      }, onAccept: (data) {
                        whatInColdBox[1] = data;
                        _checkResults();
                      }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: DragTarget<Color>(
                          builder: (_, candidateData, rejectedData) {
                            return Image(
                                image: AssetImage('assets/spot.png'),
                                color: whatInColdBox[2]);
                          },
                          onWillAccept: (data) => [
                                    Colors.green,
                                    Colors.blue,
                                    Colors.purple
                                  ].contains(data) &&
                                  whatInColdBox[2] == Colors.grey
                              ? true
                              : false,
                          onAccept: (data) {
                            whatInColdBox[2] = data;
                            _checkResults();
                          }),
                    )
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image(image: AssetImage('assets/hot_box.gif')),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: DragTarget<Color>(
                          builder: (_, candidateData, rejectedData) {
                            return Image(
                                image: AssetImage('assets/spot.png'),
                                color: whatInHotBox[0]);
                          },
                          onWillAccept: (data) => [
                                    Colors.yellow,
                                    Colors.orange,
                                    Colors.red
                                  ].contains(data) &&
                                  whatInHotBox[0] == Colors.grey
                              ? true
                              : false,
                          onAccept: (data) {
                            whatInHotBox[0] = data;
                            _checkResults();
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 100),
                      child: DragTarget<Color>(
                          builder: (_, candidateData, rejectedData) {
                            return Image(
                                image: AssetImage('assets/spot.png'),
                                color: whatInHotBox[1]);
                          },
                          onWillAccept: (data) => [
                                    Colors.yellow,
                                    Colors.orange,
                                    Colors.red
                                  ].contains(data) &&
                                  whatInHotBox[1] == Colors.grey
                              ? true
                              : false,
                          onAccept: (data) {
                            whatInHotBox[1] = data;
                            _checkResults();
                          }),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 100),
                      child: DragTarget<Color>(
                          builder: (_, candidateData, rejectedData) {
                            return Image(
                                image: AssetImage('assets/spot.png'),
                                color: whatInHotBox[2]);
                          },
                          onWillAccept: (data) => [
                                    Colors.yellow,
                                    Colors.orange,
                                    Colors.red
                                  ].contains(data) &&
                                  whatInHotBox[2] == Colors.grey
                              ? true
                              : false,
                          onAccept: (data) {
                            whatInHotBox[2] = data;
                            _checkResults();
                          }),
                    )
                  ],
                )
              ]),
            ),
            Flexible(flex: 10, fit: FlexFit.tight, child: Center()),
            Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: correct
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
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            child: Center(
                              child: Text(
                                'إعادة المحاولة',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            )),
                      )),
            ),
            Flexible(
              flex: 20,
              fit: FlexFit.tight,
              child: Center(
                  child: AnimatedContainer(
                      width: _width,
                      height: _width,
                      duration: Duration(seconds: 1),
                      child: Image(
                        image: AssetImage(correct
                            ? 'assets/star.png'
                            : 'assets/try_again.png'),
                      ))),
            )
          ],
        )));
  }
}
