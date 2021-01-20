import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/levels/finish_screen.dart';
import 'package:gamification/levels/levels_tracker_screen.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Center(child: Text("اللامالانهاية"))),
        body: SafeArea(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            ListView(
              children: [
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    AppData.currentLevel = 0;
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => AppData.levels[0]),
                        (Route<dynamic> route) => false);
                  },
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        width: 200,
                        height: 70,
                        child: Center(
                          child: Text(
                            'ابدأ اللعب',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    if (AppData.currentLevel < AppData.levels.length - 1)
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  AppData.levels[AppData.currentLevel]),
                          (Route<dynamic> route) => false);
                  },
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppData.currentLevel ==
                                    AppData.levels.length - 1
                                ? Colors.grey
                                : Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        width: 200,
                        height: 70,
                        child: Center(
                          child: Text(
                            'استمر',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => LevelsTrackerScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        width: 200,
                        height: 70,
                        child: Center(
                          child: Text(
                            'اختر مرحلة',
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        )));
  }
}
