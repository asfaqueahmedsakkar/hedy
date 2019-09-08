import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:http/http.dart' as http;

import 'Profile.dart';
import 'Settings.dart';

class DetailsPage extends StatefulWidget {
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  InfoBloc bloc;
  StreamController _streamController;

  @override
  void initState() {
    bloc = BlocProvider.of<InfoBloc>(context);
    _streamController = new StreamController();
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff963CBD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ProfilePage();
            }));
          },
          child: Center(
            child: Image(
              image: AssetImage('images/profile.png'),
              width: 32,
              height: 32,
            ),
          ),
        ),
        title: Container(
          child: Center(
            child: Image(
              image: AssetImage('images/hedy-logo-black.png'),
              height: 32,
            ),
          ),
          alignment: Alignment.center,
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingsPage();
              }));
            },
            child: Center(
              child: Image(
                image: AssetImage('images/settings.png'),
                width: 32,
                height: 32,
              ),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: RadialGradient(
                stops: [0.0, 1.4],
                colors: [Colors.purpleAccent[400], Colors.deepPurple])),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapShot) {
              if (!snapShot.hasData || snapShot.data == null)
                return CircularProgressIndicator();
              else {
                dynamic json = jsonDecode(snapShot.data);

                if (json["status"] != 1) return _noNotificationUi();
              }
            }),
      ),
    );
  }

  Column _noNotificationUi() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Nice and empty",
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: SizedBox(
            width: 260.0,
            child: Text(
              "You don't have any reminders waiting but when you do they will be listed here",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          child: Image(
            image: AssetImage('images/drawn-heart.png'),
            width: 260.0,
          ),
        ),
      ],
    );
  }

  void getNotifications() async {
    var resp =
        await http.post("http://app.hedy.info/api/user/notifications", body: {
      "id_user": bloc.currentUser.id.toString(),
    });
    _streamController.add(resp.body);
  }
}
