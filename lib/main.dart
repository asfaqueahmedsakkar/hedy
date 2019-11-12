import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hedy/ActivationCode.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/DetailsPage.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:hedy/Models/UserModel.dart';
import 'package:onesignal/onesignal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

void main() {
  runApp(
    BlocProvider(
      child: MaterialApp(
        title: "Hedy",
        theme: ThemeData(
          fontFamily: "Calibre",
        ),
        home: MyApp(),
      ),
      bloc: InfoBloc(),
    ),
  );
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initOneSignal();

    Future.delayed(Duration(seconds: 3), () {
      SharedPreferences.getInstance().then((sp) {
        String user = sp.getString("user");
        if (user != null && user.isNotEmpty) {
          UserModel userModel = UserModel.fromJson(jsonDecode(user)["user"]);
          BlocProvider.of<InfoBloc>(context).currentUser = userModel;

          if (userModel.completionStatus == 1) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return DetailsPage();
              //return SliderPage();
            }));
          } else {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ActivationCode();
            }));
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage();
              },
              settings: RouteSettings(name: "/signin"),
            ),
          );
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Loading.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "images/Hedy_logo_hozontal_white.png",
                width: 180.0,
                color: Colors.white,
                colorBlendMode: BlendMode.srcIn,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                "nice reminders",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontFamily: "Calibre",
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.4,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _initOneSignal() async {
    OneSignal.shared.setRequiresUserPrivacyConsent(false);

    var settings = {
      OSiOSSettings.autoPrompt: false,
      OSiOSSettings.promptBeforeOpeningPushUrl: true
    };

    await OneSignal.shared.init(
      "1a4c657f-1d15-459f-87d6-ecd92666466f",
      iOSSettings: settings,
    );

    final OSPermissionSubscriptionState status =
        await OneSignal.shared.getPermissionSubscriptionState();
    BlocProvider.of<InfoBloc>(context).oneSignalUid =
        status.subscriptionStatus.userId;

    OneSignal.shared.setInFocusDisplayType(
      OSNotificationDisplayType.notification,
    );
  }
}
