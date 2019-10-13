import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomClock extends StatefulWidget {
  final double clockSize;

  const CustomClock({Key key, this.clockSize = 260.0}) : super(key: key);

  @override
  _CustomClockState createState() => _CustomClockState();
}

class _CustomClockState extends State<CustomClock> {
  GlobalKey _centerWidgetKey;
  Offset _center;
  double angle = 0.0;
  List _hourAngles;

  @override
  void initState() {
    _centerWidgetKey = new GlobalKey();
    _hourAngles = List.generate(12, (i) => (math.pi * 2 / 12 * i) - math.pi);
    /*for(int i=0;i<12;i++)
      if(_hourAngles[i]>math.pi)
        _hourAngles[i]=math.pi-_hourAngles[i];*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: _hourClock(),
    );
  }

  Center _hourClock() {
    int i = 8;
    List<Widget> _clockDiles = _hourAngles.map((angle) {
      i++;
      return Transform.translate(
        offset: Offset(
          math.cos(angle) * ((widget.clockSize - 32) / 2 - 16),
          math.sin(angle) * ((widget.clockSize - 32) / 2 - 16),
        ),
        child: Text(
          "${i >12  ? i %12 : i}",
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 18.0,
          ),
        ),
      );
    }).toList();

    List<Widget> _items = [
      Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(150.0)),
        child: Center(
          child: CircleAvatar(
            key: _centerWidgetKey,
            backgroundColor: Colors.deepPurple,
            radius: 3.0,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Transform.rotate(
          angle: angle,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 2.0,
                        color: Colors.deepPurple,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: Colors.deepPurple,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
    _items.addAll(_clockDiles);

    return Center(
      child: GestureDetector(
        onPanUpdate: (details) {
          //_setCenter();
          double newAngle =
              coordinatesToRadians(_center, details.globalPosition);
          for (double ang in _hourAngles)
            if ((newAngle - ang).abs() < math.pi / 24) {
              setState(() {
                angle = ang;
              });
              break;
            }
        },
        onPanDown: (details) {
          _setCenter();
        },
        onTapDown: (details) {
          _setCenter();
          double newAngle =
              coordinatesToRadians(_center, details.globalPosition);
          print(newAngle);
          for (double ang in _hourAngles) {
            if ((newAngle - ang).abs() < math.pi / 24) {
              setState(() {
                angle = ang;
              });
              break;
            }
          }

          /*setState(() {
            angle = coordinatesToRadians(_center, details.globalPosition);
          });*/
        },
        child: Container(
          height: widget.clockSize,
          width: widget.clockSize,
          color: Colors.white,
          padding: EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: _items,
          ),
        ),
      ),
    );
  }

  void _setCenter() {
    if (_center == null) {
      _center =
          (_centerWidgetKey.currentContext.findRenderObject() as RenderBox)
              .localToGlobal(Offset.zero);
    }
  }

  double coordinatesToRadians(Offset center, Offset cords) {
    var a = cords.dx - center.dx;
    var b = center.dy - cords.dy;
    double ang = math.atan2(-b, a);

    return ang;
  }
}
