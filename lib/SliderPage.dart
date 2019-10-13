import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/CutomButton.dart';
import 'package:page_indicator/page_indicator.dart';

import 'DetailsPage.dart';

class SliderPage extends StatefulWidget {
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/slideback.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: PageIndicatorContainer(
          child: PageView(
            children: <Widget>[
              Center(
                child: Container(
                  width: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Hi new friend!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Life is busy and we sometimes forget to say and do the simple things that let others know we care about them. Or you might just like some inspiration for nice things to say and do for your special person.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        "We’re here to help!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Let’s go through some basic steps to get you set up.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 280.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Your details",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "First of all we need are some details about you and your special person. Simple stuff like your names and level of relationship.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Once you’ve finished this guide you can click on the profile icon to get started.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 280.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Scheduling",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Hedy can schedule reminders of nice things to say, do or buy for your person. These can be set to occur once a day, once a week or once a month.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "You can access the scheduling settings by clicking the calendar/time icon in the top right corner.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 280.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Remind list",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      Text(
                        "Once we’ve sent you some reminders, you will see them all listed on the homescreen.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "You can swipe right if you have done the thing and we won’t remind you of that again for a while. Swipe left if it’s something you don’t feel is quite right for you or your person and you won’t receive that reminder again.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      CustomButton(
                        fillColor: Colors.white,
                        borderColor: AppColor.magenta,
                        title: "Let's get started",
                        textColor: AppColor.magenta,
                        onPress: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailsPage();
                          }));
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
            controller: controller,
          ),
          padding: EdgeInsets.only(bottom: 40.0),
          shape: IndicatorShape.circle(size: 16.0),
          align: IndicatorAlign.bottom,
          length: 4,
          indicatorSpace: 32.0,
          indicatorSelectorColor: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}
