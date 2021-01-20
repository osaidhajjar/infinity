import 'package:flutter/material.dart';
import 'package:gamification/app_data.dart';
import 'package:gamification/welcome_screen.dart';

class LevelsTrackerScreen extends StatefulWidget {
  LevelsTrackerScreen({Key key}) : super(key: key);

  @override
  _LevelsTrackerScreenState createState() => _LevelsTrackerScreenState();
}

class _LevelsTrackerScreenState extends State<LevelsTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("اللامالانهاية")),
          leading: GestureDetector(
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  (Route<dynamic> route) => false),
              child: Icon(Icons.home)),
        ),
        body: SafeArea(
            child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Opacity(
                opacity: 0.3,
                child: Image(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 4,
              children: List<int>.generate(AppData.levels.length - 1, (i) => i)
                  .map((e) {
                print(e.toString());
                return e > AppData.currentLevel
                    ? Icon(Icons.lock)
                    : Center(
                        child: GestureDetector(
                          onTap: () {
                            if (e <= AppData.currentLevel)
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AppData.levels[e]));
                          },
                          child: CircleAvatar(
                            radius: 20,
                            child: Center(child: Text((e + 1).toString())),
                          ),
                        ),
                      );
              }).toList(),
            ),
          ],
        )));
  }
}
