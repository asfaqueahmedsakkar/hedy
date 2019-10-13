import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/CustomClock.dart';
import 'package:hedy/CutomButton.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:http/http.dart' as http;

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  StreamController _streamController;

  List<Settings> settings = [
    Settings()
      ..id = 1
      ..frequency = 4,
    Settings()
      ..id = 2
      ..frequency = 4,
    Settings()
      ..id = 3
      ..frequency = 4,
  ];

  @override
  void initState() {
    _getCurrentSettings();
    _streamController = new StreamController();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Settings",
          style: TextStyle(fontSize: 24.0, color: Colors.black),
        ),
      ),
      body: StreamBuilder(
        stream: _streamController.stream,
        builder: (context, snapShot) {
          if (snapShot.hasData && snapShot.data != null) {
            return ListView(
              children: <Widget>[
                _settingsWithTitle(
                  msg: "Things to say",
                  currentSelected: settings[0].frequency,
                  id: settings[0].id,
                ),
                _settingsWithTitle(
                  msg: "Things to do",
                  currentSelected: settings[1].frequency,
                  id: settings[1].id,
                ),
                _settingsWithTitle(
                  msg: "Things to buy",
                  currentSelected: settings[2].frequency,
                  id: settings[2].id,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 160.0,
                    child: CustomButton(
                      title: "Save",
                      onPress: () {
                        _saveSettings();
                      },
                      fillColor: AppColor.magenta,
                      borderColor: Colors.white,
                    ),
                  ),
                )
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _settingsWithTitle({String msg, int currentSelected, int id}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 16.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.2),
          )),
          child: Text(
            msg,
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
          ),
        ),
        SettingsItem(
          showDate: false,
          title: "Once a day",
          index: 1,
          currentSelect: currentSelected,
          onSelect: (index) {
            _onSelect(id, index);
          },
        ),
        SettingsItem(
          title: "Once a week",
          index: 2,
          currentSelect: currentSelected,
          onSelect: (index) {
            showDialog(
              context: context,
              builder: (context) {
                return _buildWeekDaysDialog(id);
              },
            );
          },
          onTimePress: () {
            _onSelect(id, 3);
          },
          onDatePress: () {
            showDialog(
              context: context,
              builder: (context) {
                return _buildWeekDaysDialog(id);
              },
            );
          },
        ),
        SettingsItem(
          title: "Once a month",
          index: 3,
          currentSelect: currentSelected,
          onSelect: (index) {
            showDialog(
              context: context,
              builder: (context) {
                return _buildMonthDaysDialog(id);
              },
            );
          },
          onTimePress: () {
            _onSelect(id, 3);
          },
          onDatePress: () {
            showDialog(
              context: context,
              builder: (context) {
                return _buildMonthDaysDialog(id);
              },
            );
          },
        ),
        SettingsItem(
          title: "Never",
          showDate: false,
          showTime: false,
          index: 4,
          currentSelect: currentSelected,
          onSelect: (index) {
            _onSelect(id, index);
          },
        ),
      ],
    );
  }

  Center _buildWeekDaysDialog(int id) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: AppColor.magenta,
                height: 64.0,
                child: Center(
                  child: Text(
                    "Day of the week",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              DayOfWeekButton(
                title: "Monday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 1,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
              DayOfWeekButton(
                title: "Tuesday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 2,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
              DayOfWeekButton(
                title: "Wednesday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 3,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
              DayOfWeekButton(
                title: "Thursday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 4,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
              DayOfWeekButton(
                title: "Friday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 5,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
              DayOfWeekButton(
                title: "Saturday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 6,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
              DayOfWeekButton(
                title: "Sunday",
                onPress: (index) {
                  _setWeekDay(id, index);
                },
                index: 7,
                currentSelected: _getCurrentSelectedDayOfWeek(id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelect(int id, int index) {
    setState(() {
      settings[id - 1].frequency = index;
      if (index != 4) {
        showDialog(
            context: context,
            builder: (context) => CustomClock(
                  clockSize: 260,
                  initialTime: settings[id - 1].time,
                )).then(
          (td) {
            if (td == null) return;
            settings[id - 1].time = td;
          },
        );
      }
    });
  }

  int _getCurrentSelectedDayOfWeek(int id) {
    return settings[id - 1].day;
  }

  void _setWeekDay(int id, index) {
    Navigator.pop(context);
    setState(() {
      settings[id - 1].day = index;
    });
    _onSelect(id, 2);
  }

  Widget _buildMonthDaysDialog(int id) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: AppColor.magenta,
                height: 64.0,
                child: Center(
                  child: Text(
                    "Day of the month",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
              Container(
                width: 300.0,
                height: 360.0,
                color: Colors.grey[200],
                child: GridView.count(
                  padding: EdgeInsets.all(2.0),
                  crossAxisCount: 5,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  children: List.generate(
                    30,
                    (index) => Container(
                          child: RawMaterialButton(
                            elevation: 0.0,
                            highlightElevation: 0.0,
                            fillColor:
                                _getCurrentSelectedDayOfMonth(id) == index + 1
                                    ? Colors.grey[300]
                                    : Colors.white,
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: AppColor.magenta,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () {
                              _setMonthDay(id, index + 1);
                            },
                          ),
                        ),
                  ).toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _setMonthDay(int id, index) {
    Navigator.pop(context);
    setState(() {
      settings[id - 1].day = index;
    });
    _onSelect(id, 3);
  }

  int _getCurrentSelectedDayOfMonth(int id) {
    return settings[id - 1].day;
  }

  void _getCurrentSettings() async {
    http.post("http://app.hedy.info/api/user/settings", body: {
      "id_user": BlocProvider.of<InfoBloc>(context).currentUser.id.toString(),
    }).then((r) {
      print(r.body);
      dynamic json = jsonDecode(r.body);
      dynamic settings = json["user_settings"];
      if (settings != null) {
        int i = 0;
        for (dynamic json in settings)
          if (json != null) this.settings[i++] = Settings.fromJson(json);
      }
      _streamController.add(true);
    });
  }

  void _saveSettings() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    dynamic settings = this
        .settings
        .map((s) => {
              "\"thing\"": s.id,
              "\"frequency\"": s.frequency == 1
                  ? "\"day\""
                  : s.frequency == 2
                      ? "\"week\""
                      : s.frequency == 3 ? "\"month\"" : "\"never\"",
              "\"day\"": s.day,
              "\"timeofday\"": _formattedTime(s.time),
            })
        .toList();
    await http.post("http://app.hedy.info/api/subscribe", body: {
      "id_user": BlocProvider.of<InfoBloc>(context).currentUser.id.toString(),
      "id_device": BlocProvider.of<InfoBloc>(context).oneSignalUid.toString(),
      "action": "subscribe",
    });
    http.Response resp =
        await http.post("http://app.hedy.info/api/settings", body: {
      "id_user": BlocProvider.of<InfoBloc>(context).currentUser.id.toString(),
      "settings_data": settings.toString(),
    });
    Navigator.pop(context);
    if (resp.statusCode == 200) {
      dynamic json = jsonDecode(resp.body);
      if (json["status"] == 1)
        _showDialog("Settings successfully updated", onOkPress: () {
          Navigator.pop(context);
          Navigator.pop(context);
        });
      else
        _showDialog("Sorry, settings update failed", onOkPress: () {
          Navigator.pop(context);
        });
    } else {
      _showDialog("Sorry, settings update failed", onOkPress: () {
        Navigator.pop(context);
      });
    }
  }

  void _showDialog(String msg, {Function onOkPress}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => SimpleDialog(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              title: Text(
                "Hedy",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              children: <Widget>[
                Text(
                  msg,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 60.0,
                    child: FlatButton(
                      color: AppColor.magenta,
                      child: Text(
                        "Ok",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      onPressed: onOkPress,
                    ),
                  ),
                )
              ],
            ));
  }

  String _formattedTime(TimeOfDay timeOfDay) {
    if (timeOfDay == null) return null;
    return "\"${_formattedInt(timeOfDay.hour)}:${_formattedInt(timeOfDay.minute)}:${_formattedInt(0)}\"";
  }

  _formattedInt(int data) {
    return data.toString().padLeft(2, "0");
  }
}

class Settings {
  int id = 0;
  int frequency = 0;
  int day = 0;
  TimeOfDay time = TimeOfDay.now();

  Settings();

  Settings.fromJson(json) {
    id = json["thing"];
    frequency = json["frequency"] == "day"
        ? 1
        : json["frequency"] == "week"
            ? 2
            : json["frequency"] == "month" ? 3 : 4;
    day = json["day"];
    String _t = json["timeofday"];
    if (_t != null) {
      List t = _t.split(":");

      time = TimeOfDay(minute: int.parse(t[1]), hour: int.parse(t[0]));
    }
  }
}

class DayOfWeekButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final int currentSelected;
  final int index;

  const DayOfWeekButton({
    Key key,
    this.title,
    this.onPress,
    this.index,
    this.currentSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: currentSelected == index ? Colors.grey[300] : Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Colors.grey,
            width: 0.2,
          ))),
      height: 54.0,
      child: RawMaterialButton(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: Text(
            title ?? "Monday",
            style: TextStyle(
              color: AppColor.magenta,
              fontWeight: FontWeight.w300,
              fontSize: 20.0,
            ),
          ),
        ),
        onPressed: () {
          onPress(index);
        },
      ),
    );
  }
}

class SettingsItem extends StatefulWidget {
  final String title;
  final int index;
  final currentSelect;
  final Function onTimePress;
  final Function onDatePress;
  final Function(int index) onSelect;
  final bool showTime;
  final bool showDate;

  const SettingsItem(
      {Key key,
      @required this.title,
      this.onTimePress,
      this.onDatePress,
      this.showTime = true,
      this.showDate = true,
      @required this.index,
      @required this.currentSelect,
      this.onSelect})
      : super(key: key);

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: Colors.grey, width: 0.2),
      )),
      child: RawMaterialButton(
        constraints: BoxConstraints.expand(),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        child: Row(
          children: <Widget>[
            widget.index != widget.currentSelect
                ? Container(
                    width: 24.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                  )
                : Center(
                    child: Image(
                      image: AssetImage("images/tick.png"),
                      width: 24.0,
                      height: 24.0,
                    ),
                  ),
            SizedBox(
              width: 16.0,
            ),
            Text(
              widget.title ?? "Once a day",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400),
            ),
            Expanded(
              child: SizedBox(),
            ),
            widget.showTime
                ? Center(
                    child: GestureDetector(
                      onTap: widget.onTimePress,
                      child: Image(
                        image: AssetImage("images/time.png"),
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  )
                : SizedBox(),
            SizedBox(
              width: widget.showDate ? 16.0 : 0.0,
            ),
            widget.showDate
                ? GestureDetector(
                    onTap: widget.index == widget.currentSelect
                        ? widget.onDatePress
                        : null,
                    child: Container(
                      height: 44.0,
                      width: 44.0,
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage("images/date.png"),
                        width: 24.0,
                        height: 24.0,
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
        onPressed: () => widget.onSelect(widget.index),
      ),
    );
  }
}
