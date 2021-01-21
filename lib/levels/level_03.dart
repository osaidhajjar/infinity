import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class Level03 extends StatefulWidget {
  final String title = "المستوى الثالث";
  final String mission = "هيا نسمي الألوان التالية";

  Level03({Key key}) : super(key: key);

  @override
  _Level03State createState() => _Level03State();
}

class _Level03State extends State<Level03> {
  double _width = 0;
  bool _correct = false;
  bool _isCompact;

  TextEditingController _redController = TextEditingController();
  TextEditingController _yellowController = TextEditingController();
  TextEditingController _purpleController = TextEditingController();
  TextEditingController _greyController = TextEditingController();

  void _checkResults() {
    if ((_redController.text.trim() == "احمر" ||
            _redController.text.trim() == "أحمر") &&
        (_yellowController.text.trim() == "اصفر" ||
            _yellowController.text.trim() == "أصفر") &&
        (_purpleController.text.trim() == "بنفسجي" ||
            _purpleController.text.trim() == "بنفسجى" ||
            _purpleController.text.trim() == "بنفسج" ||
            _purpleController.text.trim() == "موف" ||
            _purpleController.text.trim() == "موفي" ||
            _purpleController.text.trim() == "موفى") &&
        (_greyController.text.trim() == "رصاصي" ||
            _greyController.text.trim() == "رصاصى" ||
            _greyController.text.trim() == "رصاص")) {
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
    double pinWidth =
        kIsWeb ? 200 / MediaQuery.of(context).devicePixelRatio : 200;

    _isCompact = !kIsWeb ||
        (MediaQuery.of(context).size.width /
                MediaQuery.of(context).devicePixelRatio) <
            500 / MediaQuery.of(context).devicePixelRatio;

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
                    flex: 30,
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Column(
                            children: [
                              Image(
                                  image: AssetImage('assets/purple_pin.png'),
                                  width: pinWidth,
                                  height: pinWidth),
                              Container(
                                width: pinWidth,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _purpleController,
                                  onChanged: (value) => _checkResults(),
                                  style: TextStyle(
                                      fontSize: kIsWeb
                                          ? 25 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'اكتب اسم اللون هنا',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: kIsWeb
                                            ? 18 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 18,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(flex: 1, fit: FlexFit.loose, child: Center()),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Column(
                            children: [
                              Image(
                                  image: AssetImage('assets/yellow_pin.png'),
                                  width: pinWidth,
                                  height: pinWidth),
                              Container(
                                width: pinWidth,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _yellowController,
                                  onChanged: (value) => _checkResults(),
                                  style: TextStyle(
                                      fontSize: kIsWeb
                                          ? 25 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'اكتب اسم اللون هنا',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: kIsWeb
                                            ? 18 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 18,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Flexible(
                    flex: 30,
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Column(
                            children: [
                              Image(
                                  image: AssetImage('assets/grey_pin.png'),
                                  width: pinWidth,
                                  height: pinWidth),
                              Container(
                                width: pinWidth,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _greyController,
                                  onChanged: (value) => _checkResults(),
                                  style: TextStyle(
                                      fontSize: kIsWeb
                                          ? 25 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'اكتب اسم اللون هنا',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: kIsWeb
                                            ? 18 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 18,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Flexible(flex: 1, fit: FlexFit.loose, child: Center()),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.loose,
                          child: Column(
                            children: [
                              Image(
                                  image: AssetImage('assets/red_pin.png'),
                                  width: pinWidth,
                                  height: pinWidth),
                              Container(
                                width: pinWidth,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: _redController,
                                  onChanged: (value) => _checkResults(),
                                  style: TextStyle(
                                      fontSize: kIsWeb
                                          ? 25 /
                                              MediaQuery.of(context)
                                                  .devicePixelRatio
                                          : 25,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'اكتب اسم اللون هنا',
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade400,
                                        fontSize: kIsWeb
                                            ? 18 /
                                                MediaQuery.of(context)
                                                    .devicePixelRatio
                                            : 18,
                                        fontWeight: FontWeight.w500),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.blue)),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
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
                      image: AssetImage(_correct
                          ? 'assets/star.png'
                          : 'assets/try_again.png'),
                    )))
          ],
        )));
  }
}
