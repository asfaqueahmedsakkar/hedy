import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';

class SettingsPage extends StatefulWidget {
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _value = '';
  String _time = '';

  TimeOfDay selectedTime;
  TimeOfDay selectTime;
  bool _sayDay = false,
      _sayWeek = false,
      _sayMonth = false,
      _sayNever = false;
  bool _doDay = false,
      _doWeek = false,
      _doMonth = false,
      _doNever = false;
  bool _buyDay = false,
      _buyWeek = false,
      _buyMonth = false,
      _buyNever = false;
  bool pressed = false;
  bool DaySay=false;
  bool WeekSay=false;
  bool MonthSay=false;
  bool NeverSay=false;
  bool DayDo=false;
  bool WeekDo=false;
  bool MonthDO=false;
  bool NeverDo=false;
  bool DayBuy=false;
  bool WeekBuy=false;
  bool MonthBuy=false;
  bool NeverBuy=false;
  bool _valu = false;
  DateTime sayDayTimeSelect;

  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime(2019, 8),
        firstDate: new DateTime(2019, 8),
        lastDate: new DateTime(2040));
    if (picked != null) setState(() => _value = picked.toString());
  }

  Future _selectTime(BuildContext context) async {
    final now = DateTime.now();

    await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
    );
    if (now != null) {
      setState(() {
        sayDayTimeSelect = now;
      });
    }
    print(sayDayTimeSelect);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        /*leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),*/
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image(
              image: AssetImage('images/back-arrow.png'),
            )
        ),
        title: Container(
          child: Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
            ),
          ),
          alignment: Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 24.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Things to say",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            //SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      WeekSay=false;
                      MonthSay=false;
                      NeverSay=false;
                      _selectTime(context);
                      setState(() => DaySay = ! DaySay);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: DaySay
                                  ? _DaySayTick()
                                  : SizedBox(),
                            ),

                          ),

                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                              "Once a day",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0,
                              ),
                            ),

                        ],
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage('images/time.png'),
                    height: 25.0,
                    width: 25.0,
                  ),
                  //_tickImage(context),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DaySay=false;
                      MonthSay=false;
                      NeverSay=false;
                      _selectTime(context);
                      setState(() => WeekSay = ! WeekSay);
                    },

                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: WeekSay
                                  ? _WeekSayTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a week",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/time.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      GestureDetector(
                        onTap: () {
                          showWeek(context);
                        },
                        child: Image(image: AssetImage('images/date.png'),
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DaySay=false;
                      WeekSay=false;
                      NeverSay=false;
                      _selectTime(context);
                      setState(() => MonthSay = ! MonthSay);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: MonthSay
                                  ? _MonthSayTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/time.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      GestureDetector(
                        onTap: (){
                       showMonth(context);
                        },
                        child: Image(image: AssetImage('images/date.png'),
                          height: 25.0,
                          width: 25.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DaySay=false;
                      WeekSay=false;
                      MonthSay=false;
                      _selectTime(context);
                      setState(() => NeverSay = ! NeverSay);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: NeverSay
                                  ? _NeverSayTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Never",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Icon(Icons.access_alarms),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 24.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Things to do",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
            ),

            //add herer
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            //SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      WeekDo=false;
                      MonthDO=false;
                      NeverDo=false;
                      _selectTime(context);
                      setState(() => DayDo = ! DayDo);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: DayDo
                                  ? _DayDoTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a day",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage('images/time.png'),
                    height: 25.0,
                    width: 25.0,
                  ),

                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DayDo=false;
                      MonthDO=false;
                      NeverDo=false;
                      setState(()=>
                          WeekDo = ! WeekDo
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: WeekDo
                                  ? _WeekDoTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a week",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/time.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      Image(image: AssetImage('images/date.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DayDo=false;
                      WeekDo=false;
                      NeverDo=false;
                      setState(()=>
                      MonthDO=!MonthDO
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: MonthDO
                                  ? _MonthDoTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/time.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      Image(image: AssetImage('images/date.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DayDo=false;
                      WeekDo=false;
                      MonthDO=false;
                      setState(()=>NeverDo = ! NeverDo );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: NeverDo
                                  ? _NeverDoTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Never",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Icon(Icons.access_alarms),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 24.0, top: 24.0),
              child: Row(
                children: <Widget>[
                  Text(
                    "Things to buy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                    ),
                  )
                ],
              ),
            ),
            //add here
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            //SizedBox(height: 5.0,),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      WeekBuy=false;
                      MonthBuy=false;
                      NeverBuy=false;
                      setState(() => DayBuy = ! DayBuy);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: DayBuy
                                  ? _DayBuyTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a day",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Image(
                    image: AssetImage('images/time.png'),
                    height: 25.0,
                    width: 25.0,
                  ),

                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DayBuy=false;
                      MonthBuy=false;
                      NeverBuy=false;
                      setState(()=> WeekBuy = !WeekBuy );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: WeekBuy
                                  ? _WeekBuyTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a week",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/time.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      Image(image: AssetImage('images/date.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DayBuy=false;
                      WeekBuy=false;
                      NeverBuy=false;
                      setState(()=>MonthBuy = ! MonthBuy );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: MonthBuy
                                  ? _MonthBuyTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Once a month",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/time.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                      SizedBox(width: 5.0,),
                      Image(image: AssetImage('images/date.png'),
                        height: 25.0,
                        width: 25.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      DayBuy=false;
                      WeekBuy=false;
                      MonthBuy=false;
                      setState(()=> NeverBuy = ! NeverBuy );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 25.0,
                            width: 25.0,

                            decoration: BoxDecoration(

                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.grey)

                            ),
                            child: Container(
                              child: NeverBuy
                                  ? _NeverBuyTick()
                                  : SizedBox(),
                            ),

                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Never",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  //Icon(Icons.access_alarms),
                ],
              ),
            ),
            SizedBox(height: 5.0,),
            Container(
              color: Colors.black,
              height: 0.5,
              child: Row(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50.0,
                  width: 140.0,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Color(0xff963CBD),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                      onPressed: () {}),
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tickImage(BuildContext context) {
    return Image(image: AssetImage('images/tick.png'),
    );
  }

  Future<bool> showWeek(context) {
    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  height: 406.0,
                  width: 300.0,
                  decoration:
                  BoxDecoration(),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          //Container(height: 150.0),
                          Container(
                            height: 63.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.0),
                                  topRight: Radius.circular(10.0),
                                ),
                              color: Color(0xff813BBD),),
                            child: Text(
                              "Day of the week",
                              style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      //SizedBox(height: 20.0),
                      Padding(
                          padding: EdgeInsets.all(15.0),
                            child:  Container(
                                child: Text(
                                  'Monday',
                                  style: TextStyle(
                                    fontFamily: 'Quicksand',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff813BBD),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child:  Container(
                          child: Text(
                            'Tuesday',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff813BBD),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child:  Container(
                          child: Text(
                            'Wednesday',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff813BBD),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child:  Container(
                          child: Text(
                            'Thursday',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff813BBD),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child:  Container(
                          child: Text(
                            'Friday',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff813BBD),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child:  Container(
                          child: Text(
                            'Saturday',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff813BBD),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child:  Container(
                          child: Text(
                            'Sunday',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w300,
                              color: Color(0xff963CBD),
                            ),
                          ),
                          alignment: Alignment.center,
                        ),
                      ),



                    ],
                  )));
        });
  }

  Future<bool> showMonth(context) {
    return showDialog(

        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0)),
              child: Container(
                  height: 406.0,
                  width: 300.0,
                  decoration:
                  BoxDecoration(

                  ),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          //Container(height: 150.0),
                          Container(
                            height: 63.0,
                            width: 400.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0.0),
                                topRight: Radius.circular(0.0),
                              ),
                              color: Color(0xff813BBD),
                              ),
                            child: Text(
                              "Day of the Month",
                              style: TextStyle(color: Colors.white,fontSize: 25.0,fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      //SizedBox(height: 20.0),
                     Row(
                       children: <Widget>[
                         Container(
                           height: 48.5,
                           width: 69.5,
                           //color: Colors.blue,
                           child: Text(
                             "1"
                           ),
                           alignment: Alignment.center,
                         ),
                         Container(
                           color: Colors.grey,
                           height: 48.5,
                           width: 0.5,
                           child: Container(

                           ),
                         ),
                         Container(
                           height: 48.5,
                           width: 69.5,
                           //color: Colors.blue,
                           child: Text(
                               "2"
                           ),
                           alignment: Alignment.center,
                         ),
                         Container(
                           color: Colors.grey,
                           height: 48.5,
                           width: 0.5,
                           child: Container(

                           ),
                         ),
                         Container(
                           height: 48.5,
                           width: 69.5,
                           //color: Colors.blue,
                           child: Text(
                               "3"
                           ),
                           alignment: Alignment.center,
                         ),
                         Container(
                           color: Colors.grey,
                           height: 48.5,
                           width: 0.5,
                           child: Container(

                           ),
                         ),
                         Container(
                           height: 48.5,
                           width: 69.5,
                           //color: Colors.blue,
                           child: Text(
                               "4"
                           ),
                           alignment: Alignment.center,
                         ),

                       ],
                     ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "5"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "6"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "7"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 50.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 50.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "8"
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "9"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "10"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "11"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "12"
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "13"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "14"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "15"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "16"
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "17"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "18"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "19"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "20"
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "21"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "22"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "23"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "24"
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "25"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "26"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "27"
                            ),
                            alignment: Alignment.center,
                          ),
                          Container(
                            color: Colors.grey,
                            height: 48.5,
                            width: 0.5,
                            child: Container(

                            ),
                          ),
                          Container(
                            height: 48.5,
                            width: 69.5,
                            //color: Colors.blue,
                            child: Text(
                                "28"
                            ),
                            alignment: Alignment.center,
                          ),

                        ],
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.grey,
                        child: Row(

                        ),
                      )




                    ],
                  )));
        });
  }

  Widget _DaySayTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _WeekSayTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _MonthSayTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _NeverSayTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _DayDoTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _WeekDoTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _MonthDoTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _NeverDoTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _DayBuyTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _WeekBuyTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _MonthBuyTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _NeverBuyTick(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }

}
