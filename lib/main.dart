import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gamification/welcome_screen.dart';

void main() async {
  // debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "لعبة تحدي الألوان",
      theme: ThemeData(fontFamily: 'tajawal'),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child,
          ),
        );
      },
      home: WelcomeScreen(),
    );
  }
}
