import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ColorBoxWidget extends StatefulWidget {
  final String color;
  final _ColorBoxWidgetState localState = _ColorBoxWidgetState();

  ColorBoxWidget({this.color, Key key}) : super(key: key);

  void reset() => localState.draggedToTarget = false;

  @override
  _ColorBoxWidgetState createState() => localState;
}

class _ColorBoxWidgetState extends State<ColorBoxWidget> {
  bool draggedToTarget = false;

  Widget get baseWidget => Image(
      image: AssetImage('assets/box_' + widget.color + '.png'),
      width: kIsWeb ? 100 / MediaQuery.of(context).devicePixelRatio : 100,
      height: kIsWeb ? 100 / MediaQuery.of(context).devicePixelRatio : 100);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Draggable<String>(
          data: widget.color,
          childWhenDragging: Container(
              width:
                  kIsWeb ? 100 / MediaQuery.of(context).devicePixelRatio : 100,
              height:
                  kIsWeb ? 100 / MediaQuery.of(context).devicePixelRatio : 100),
          feedback: baseWidget,
          child: draggedToTarget
              ? Container(
                  width: kIsWeb
                      ? 100 / MediaQuery.of(context).devicePixelRatio
                      : 100,
                  height: kIsWeb
                      ? 100 / MediaQuery.of(context).devicePixelRatio
                      : 100)
              : baseWidget,
          onDragCompleted: () => setState(() => draggedToTarget = true),
        )
      ],
    );
  }
}
