import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
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
        appBar: AppBar(
          backgroundColor: Color(0xff644CA2),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Center(
              child: Image(
                height: MediaQuery.of(context).size.height,
                image: AssetImage('assets/bg_main.gif'),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(flex: 60, fit: FlexFit.loose, child: Center()),
                Flexible(
                  flex: 40,
                  fit: FlexFit.loose,
                  child: Column(
                    children: [
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            AppData.currentLevel = 0;
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => AppData.levels[0]),
                                (Route<dynamic> route) => false);
                          },
                          child: Image(
                              image: AssetImage('assets/buttom_start.png'),
                              width: AppData.getSize(170, context),
                              height: AppData.getSize(70, context)),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            if (AppData.currentLevel <
                                AppData.levels.length - 1)
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AppData.levels[AppData.currentLevel]),
                                  (Route<dynamic> route) => false);
                          },
                          child: Image(
                              image: AssetImage('assets/button_continue.png'),
                              width: AppData.getSize(170, context),
                              height: AppData.getSize(70, context)),
                        ),
                      ),
                      Flexible(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LevelsTrackerScreen()),
                                (Route<dynamic> route) => false);
                          },
                          child: Image(
                              image: AssetImage('assets/button_choose.png'),
                              width: AppData.getSize(170, context),
                              height: AppData.getSize(70, context)),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(flex: 10, fit: FlexFit.loose, child: Center()),
              ],
            ),
          ],
        )));
  }
}
