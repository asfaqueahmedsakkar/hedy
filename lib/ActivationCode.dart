import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/CutomButton.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:hedy/ResetPassword.dart';
import 'package:hedy/SliderPage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ActivationCode extends StatefulWidget {
  ActivationCode();

  _ActivationCodeState createState() => _ActivationCodeState();
}

class _ActivationCodeState extends State<ActivationCode> {
  var emailActive, code, statusCode;
  TextEditingController varCode;
  InfoBloc _info;

  @override
  void initState() {
    super.initState();
    varCode = new TextEditingController();
    _info = BlocProvider.of<InfoBloc>(context);
  }

  @override
  void dispose() {
    varCode.dispose();

    super.dispose();
  }

  void checkActivationCode(emailActive, code) async {
    showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()));
    final response = await http.post(
        'http://app.hedy.info/api/user/activateprofile',
        body: {'email': _info.currentUser.email, 'code': varCode.text});
    Navigator.pop(context);

    var decodedData = jsonDecode(response.body);
    statusCode = decodedData['status'];
    SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString("user", response.body);

    if (statusCode == 0) {
      _showDialog();
    } else if (statusCode == 1) {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return SliderPage();
      }), ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 64.0,
              ),
              Logo(),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "An activation code has been sent to your email ${_info.currentUser.email}, put the code in the box below",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40.0,
              ),
              TextField(
                controller: varCode,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontSize: 18.0,
                ),
                decoration: InputDecoration(
                  hintText: "Activation code",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              CustomButton(
                onPress: () {
                  checkActivationCode(emailActive, code);
                },
                title: "Activate",
                fillColor: AppColor.magenta,
              ),
              SizedBox(
                height: 64.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Attention"),
          content: new Text("The code you provided is wrong!"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
