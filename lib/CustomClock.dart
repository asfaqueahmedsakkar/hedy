import 'dart:math' as math;

import 'package:flutter/material.dart';

class CustomClock extends StatefulWidget {
  final double clockSize;
  final TimeOfDay initialTime;

  const CustomClock({Key key, this.clockSize = 280.0, this.initialTime})
      : super(key: key);

  @override
  _CustomClockState createState() => _CustomClockState();
}

class _CustomClockState extends State<CustomClock> {
  GlobalKey _centerWidgetKey;
  Offset _center;
  double angle = 0.0;
  List _hourAngles;
  List _minuteAngles;

  bool setHour = true;
  bool isAm = true;

  int hour = 0;
  int minute = 0;

  @override
  void initState() {
    if (widget.initialTime != null) {
      hour = widget.initialTime.hour % 12;
      minute = widget.initialTime.minute % 60;
      isAm = widget.initialTime.hour / 12 >= 1.0 ? false : true;
    }
    _centerWidgetKey = new GlobalKey();
    _hourAngles = List.generate(12, (i) => (math.pi * 2 / 12 * i) - math.pi);
    _minuteAngles = List.generate(60, (i) => (math.pi * 2 / 60 * i) - math.pi);
    angle = _hourAngles[(hour + 3) % 12];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: widget.clockSize,
              color: Colors.deepPurple,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setHour = true;

                        angle = _hourAngles[(hour + 3) % 12];
                      });
                    },
                    child: Text(
                      hour == 0 ? "12" : hour.toString(),
                      style: TextStyle(
                        color: setHour ? Colors.white : Colors.white70,
                        fontSize: setHour ? 52.0 : 46.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      ":",
                      style: TextStyle(
                        color: setHour ? Colors.white : Colors.white70,
                        fontSize: 46.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        setHour = false;
                        angle = _minuteAngles[(minute + 15) % 60];
                      });
                    },
                    child: SizedBox(
                      width: 56.0,
                      child: Center(
                        child: Text(
                          "${(minute == 0 ? "60" : minute.toString()).padLeft(2, "0")}",
                          style: TextStyle(
                            color: !setHour ? Colors.white : Colors.white70,
                            fontSize: !setHour ? 52.0 : 46.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isAm = true;
                          });
                        },
                        child: SizedBox(
                          height: 18.0,
                          child: Text(
                            "AM",
                            style: TextStyle(
                              color: isAm ? Colors.white : Colors.white70,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isAm = false;
                          });
                        },
                        child: SizedBox(
                          height: 18.0,
                          child: Text(
                            "PM",
                            style: TextStyle(
                              color: !isAm ? Colors.white : Colors.white70,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            setHour ? _hourClock() : _minuteClock(),
            Container(
              alignment: Alignment.centerRight,
              color: Colors.white,
              width: widget.clockSize,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    width: 60.0,
                    child: RawMaterialButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 60.0,
                    child: RawMaterialButton(
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pop(
                            context,
                            TimeOfDay(
                                minute: minute, hour: isAm ? hour : hour + 12));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Center _hourClock() {
    int i = 8;
    List<Widget> _clockDiles = _hourAngles.map((angle) {
      i++;
      int j = i > 12 ? i % 12 : i;
      return Transform.translate(
        offset: Offset(
          math.cos(angle) * ((widget.clockSize - 32) / 2 - 15),
          math.sin(angle) * ((widget.clockSize - 32) / 2 - 15),
        ),
        child: Text(
          "$j",
          style: TextStyle(
            color: j == hour || (j == 12 && hour == 0)
                ? Colors.white
                : Colors.deepPurple,
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
          for (int i = 0; i < _hourAngles.length; i++) {
            double ang = _hourAngles[i];
            if ((newAngle - ang).abs() < math.pi / 18) {
              setState(() {
                angle = ang;
                hour = (i + 9) % 12;
              });
              break;
            }
          }
        },
        onPanDown: (details) {
          _setCenter();
        },
        onTapUp: (details) {
          _setCenter();
          double newAngle =
              coordinatesToRadians(_center, details.globalPosition);
          for (int i = 0; i < _hourAngles.length; i++) {
            double ang = _hourAngles[i];
            if ((newAngle - ang).abs() < math.pi / 18) {
              setState(() {
                angle = ang;
                hour = (i + 9) % 12;
                setHour = false;
                angle = _minuteAngles[(minute + 15) % 60];
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

  Center _minuteClock() {
    int i = 44;
    List<Widget> _clockDiles = _minuteAngles.map((angle) {
      i++;
      int j = i > 60 ? i % 60 : i;

      int k = j + 2, l = j - 2;

      bool makeDeep =
          j == minute || (j == 60 && minute == 0) || (k > minute && l < minute);
      return Transform.translate(
        offset: Offset(
          math.cos(angle) * ((widget.clockSize - 32) / 2 - 15),
          math.sin(angle) * ((widget.clockSize - 32) / 2 - 15),
        ),
        child: j % 5 == 0
            ? Text(
                "$j",
                style: TextStyle(
                  color: makeDeep ? Colors.white : Colors.deepPurple,
                  fontSize: 18.0,
                ),
              )
            : SizedBox(),
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
          for (int i = 0; i < _minuteAngles.length; i++) {
            double ang = _minuteAngles[i];
            if ((newAngle - ang).abs() < math.pi * 2 / 120) {
              setState(() {
                angle = ang;
                minute = (i + 45) % 60;
              });
              break;
            }
          }
        },
        onPanDown: (details) {
          _setCenter();
        },
        onTapDown: (details) {
          _setCenter();
          double newAngle =
              coordinatesToRadians(_center, details.globalPosition);
          for (int i = 0; i < _minuteAngles.length; i++) {
            double ang = _minuteAngles[i];
            if ((newAngle - ang).abs() < math.pi / 90) {
              setState(() {
                angle = ang;
                minute = (i + 45) % 60;
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
