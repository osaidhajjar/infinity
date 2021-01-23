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
    print((MediaQuery.of(context).size.width /
        MediaQuery.of(context).devicePixelRatio));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppData.appBarColor,
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
            AppData.getBackgroundWidget(context),
            Column(children: [
              Flexible(flex: 5, fit: FlexFit.loose, child: Center()),
              Flexible(
                flex: 70,
                fit: FlexFit.loose,
                child: ListView(
                    children: List<int>.generate(
                            ((AppData.levels.length - 1) / 5).ceil(), (j) => j)
                        .map((row) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List<int>.generate(
                                    5, (i) => (row * 5) + i)
                                .map((e) => Flexible(
                                      flex: 10,
                                      fit: FlexFit.loose,
                                      child: Container(
                                          width: AppData.getSize(80, context),
                                          height: AppData.getSize(80, context),
                                          child: e >=
                                                  (AppData.levels.length - 1)
                                              ? Center()
                                              : e > AppData.currentLevel &&
                                                      false
                                                  ? Icon(Icons.lock,
                                                      size: AppData.getSize(
                                                          40, context))
                                                  : GestureDetector(
                                                      onTap: () {
                                                        AppData.currentLevel =
                                                            e;
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AppData.levels[
                                                                        e]));
                                                      },
                                                      child: Center(
                                                        child: CircleAvatar(
                                                          radius:
                                                              AppData.getSize(
                                                                  24, context),
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                AppData
                                                                    .appBarColor,
                                                            radius:
                                                                AppData.getSize(
                                                                    20,
                                                                    context),
                                                            child: Center(
                                                                child: Text(
                                                              (e + 1)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: AppData
                                                                      .getSize(
                                                                          20,
                                                                          context)),
                                                            )),
                                                          ),
                                                        ),
                                                      ),
                                                    )),
                                    ))
                                .toList()))
                        .toList()),
              ),
              Flexible(flex: 5, fit: FlexFit.loose, child: Center()),
            ]),
          ],
        )));
  }
}
