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
  List<Notification> notifications;

  @override
  void initState() {
    bloc = BlocProvider.of<InfoBloc>(context);
    _streamController = new StreamController();
    notifications = new List();
    getNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Image(
          image: AssetImage(
            'images/hedy-logo-black.png',
          ),
          height: 32,
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SettingsPage();
                }));
              },
              child: Center(
                child: Image(
                  image: AssetImage('images/settings.png'),
                  width: 30,
                  height: 30,
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/slideback.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
            stream: _streamController.stream,
            builder: (context, snapShot) {
              if (!snapShot.hasData || snapShot.data == null)
                return CircularProgressIndicator();
              else {
                dynamic json = jsonDecode(snapShot.data);

                if (json["status"] != 1)
                  return _noNotificationUi();
                else {
                  notifications.clear();
                  for (dynamic d in json["notifications"]) {
                    notifications.add(Notification.fromJson(d));
                    for (dynamic dd in d["data"])
                      notifications.add(Notification.fromJson(dd));
                  }
                  return Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        if (notifications[index].title != null)
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                            ),
                            child: Text(
                              notifications[index].title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontFamily: "Calibre"),
                            ),
                          );
                        return Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Dismissible(
                            key: GlobalKey(),
                            child: Container(
                              padding: EdgeInsets.all(16.0),
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Text(
                                notifications[index].message,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18.0,
                                    fontFamily: "Calibre"),
                              ),
                            ),
                            background: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(4.0)),
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 32.0,
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4.0)),
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 32.0,
                                ),
                              ),
                            ),
                            dismissThresholds: {
                              DismissDirection.endToStart: 0.6,
                              DismissDirection.startToEnd: 0.6,
                            },
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                onComplete(
                                  status: "hide",
                                  id: notifications[index].id,
                                );
                              } else {
                                onComplete(
                                  status: "done",
                                  id: notifications[index].id,
                                );
                              }
                            },
                          ),
                        );
                      },
                      itemCount: notifications.length,
                    ),
                  );
                }
              }
            }),
      ),
    );
  }

  void onComplete({String status, int id}) async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));

    await http.post("http://app.hedy.info/api/user/notifyactions", body: {
      "id_user": bloc.currentUser.id.toString(),
      "id_thing": id.toString(),
      "action": status.toString(),
    });
    Navigator.pop(context);
    getNotifications();
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

class Notification {
  int id;
  String message;
  String title;

  Notification.fromJson(json) {
    id = json["id"];
    message = json["message"];
    title = json["title"];
  }
}
