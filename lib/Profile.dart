import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:hedy/Models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var statusCode;
  TextEditingController personNameController, userNameController;
  InfoBloc bloc;
  bool xRelation;
  int relation;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<InfoBloc>(context);
    personNameController =
        new TextEditingController(text: bloc.currentUser.personName ?? "");
    userNameController =
        new TextEditingController(text: bloc.currentUser.userName ?? "");

    xRelation = bloc.currentUser.xRated == "1" ? true : false;
    relation = bloc.currentUser.idRelation;
    print(relation);
  }

  @override
  void dispose() {
    personNameController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  void updateProfile() async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    final response = await http.post(
      'http://app.hedy.info/api/profile',
      body: {
        'id_user': bloc.currentUser.id.toString(),
        'name': userNameController.text.toString(),
        'person_name': personNameController.text,
        'id_relation': relation.toString(),
        'x_rated': xRelation.toString(),
      },
    );
    var decodedData = jsonDecode(response.body);

    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString("user", response.body);

    statusCode = decodedData['status'];
    bloc.currentUser = UserModel.fromJson(decodedData["user"]);
    Navigator.pop(context);
    Navigator.pop(context);
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
        title: Container(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 8.0,
              ),
              Text(
                "Details",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Your name",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: userNameController,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  hintText: "Your name",
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Text(
                "Your person's name",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              TextFormField(
                controller: personNameController,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                  hintText: "Person's name",
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              Text(
                "Your person's name",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              _relationButton(relation == 1, "Friend", () {
                setState(() {
                  relation = 1;
                });
              }),
              _relationButton(relation == 2, "Dating", () {
                setState(() {
                  relation = 2;
                });
              }),
              _relationButton(relation == 3, "Partners", () {
                setState(() {
                  relation = 3;
                });
              }),
              _relationButton(relation == 4, "Married", () {
                setState(() {
                  relation = 4;
                });
              }),
              Text(
                "We don't want to remind you to make a romantic dinner for your friend",
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w100,
                  fontStyle: FontStyle.italic,
                ),
              ),
              relation == 3 || relation == 4
                  ? _getExtraPart()
                  : SizedBox(
                      height: 32.0,
                    ),
              RawMaterialButton(
                fillColor: AppColor.magenta,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                padding: EdgeInsets.symmetric(horizontal: 48.0, vertical: 12.0),
                child: Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  updateProfile();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _relationButton(bool isSelected, String title, Function onPress) {
    return SizedBox(
      height: 36.0,
      child: RawMaterialButton(
        constraints: BoxConstraints.expand(),
        elevation: 0.0,
        onPressed: onPress ?? () {},
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 4.0,
            ),
            !isSelected
                ? Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 0.5),
                    ),
                  )
                : Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 0.5),
                      image: DecorationImage(
                        image: AssetImage("images/tick.png"),
                      ),
                    ),
                  ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              title ?? "Try",
              style: TextStyle(fontSize: 18.0),
            )
          ],
        ),
      ),
    );
  }

  Widget _getExtraPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 32.0,
        ),
        Text(
          "Extra Sauce",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        _relationButton(xRelation, "Include x-rated reminders", () {
          setState(() {
            xRelation = !xRelation;
          });
        }),
        SizedBox(
          height: 8.0,
        ),
        Text(
          "You've been warned",
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w100,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(
          height: 32.0,
        ),
      ],
    );
  }
}
