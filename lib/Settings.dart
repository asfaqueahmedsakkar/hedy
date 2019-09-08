import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int currentFrequencyOfToSay, currentFrequencyOfToDo, currentFrequencyOfToBuy;
  int currentWeekDayOfToSay, currentWeekDayOfToDo, currentWeekDayOfToBuy;
  int currentMonthDayOfToSay, currentMonthDayOfToDo, currentMonthDayOfToBuy;

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
      body: ListView(
        children: <Widget>[
          _settingsWithTitle(
            msg: "Things to say",
            currentSelected: currentFrequencyOfToSay,
            id: 1,
          ),
          _settingsWithTitle(
            msg: "Things to do",
            currentSelected: currentFrequencyOfToDo,
            id: 2,
          ),
          _settingsWithTitle(
            msg: "Things to buy",
            currentSelected: currentFrequencyOfToBuy,
            id: 3,
          ),
        ],
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
            _onSelect(id, index);
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
            _onSelect(id, index);
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
      if (id == 1)
        currentFrequencyOfToSay = index;
      else if (id == 2)
        currentFrequencyOfToDo = index;
      else if (id == 3) currentFrequencyOfToBuy = index;
      if (index != 4) {
        showTimePicker(
          context: context,
          builder: (BuildContext context, Widget child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: AppColor.magenta,
                accentColor: AppColor.magenta,
              ),
              child: child,
            );
          },
          initialTime: TimeOfDay.now(),
        );
      }
    });
  }

  int _getCurrentSelectedDayOfWeek(int id) {
    if (id == 1)
      return currentWeekDayOfToSay;
    else if (id == 2)
      return currentWeekDayOfToDo;
    else if (id == 3)
      return currentWeekDayOfToBuy;
    else
      return 0;
  }

  void _setWeekDay(int id, index) {
    Navigator.pop(context);
    setState(() {
      if (id == 1)
        currentWeekDayOfToSay = index;
      else if (id == 2)
        currentWeekDayOfToDo = index;
      else if (id == 3) currentWeekDayOfToBuy = index;
    });
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
      if (id == 1)
        currentMonthDayOfToSay = index;
      else if (id == 2)
        currentMonthDayOfToDo = index;
      else if (id == 3) currentMonthDayOfToBuy = index;
    });
  }

  int _getCurrentSelectedDayOfMonth(int id) {
    if (id == 1)
      return currentMonthDayOfToSay;
    else if (id == 2)
      return currentMonthDayOfToDo;
    else if (id == 3)
      return currentMonthDayOfToBuy;
    else
      return 0;
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
