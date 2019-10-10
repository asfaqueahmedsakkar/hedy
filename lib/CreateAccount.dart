import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/ActivationCode.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/CutomButton.dart';
import 'package:hedy/HomePage.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:hedy/Models/UserModel.dart';
import 'package:hedy/ResetPassword.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount extends StatefulWidget {
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController varEmail, varPassword, varRepeatPassword, varName;

  @override
  void initState() {
    super.initState();
    varEmail = new TextEditingController();
    varPassword = new TextEditingController();
    varRepeatPassword = new TextEditingController();
    varName = new TextEditingController();
  }

  @override
  void dispose() {
    varEmail.dispose();
    varPassword.dispose();
    varRepeatPassword.dispose();
    super.dispose();
  }

  Future<String> registerUser(name, email, password, repeatPass) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));
    final response =
        await http.post('http://app.hedy.info/api/register', body: {
      'email': varEmail.text,
      'password': varPassword.text,
      'password_confirmation': varPassword.text
    });

    dynamic resp = jsonDecode(response.body);
    if (resp["status"] == 1) {
      dynamic user = resp["user"];
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString("user", response.body);

      UserModel cu = UserModel.fromJson(user);
      BlocProvider.of<InfoBloc>(context).currentUser = cu;

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return ActivationCode();
      }));
    } else {
      Navigator.pop(context);
      _showDialog(msg: resp["message"]);
    }

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration decoration = InputDecoration(
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0)),
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1.0),
      ),
      disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0)),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0)),
    );
    TextStyle editTextStyle = TextStyle(fontSize: 18.0);
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: _backPressed,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: <Widget>[
                Logo(),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Create account",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "We don't give your details to",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Text(
                  "anyone else",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      TextField(
                        controller: varEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: decoration,
                        style: editTextStyle,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      TextField(
                        controller: varPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: decoration,
                        style: editTextStyle,
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Text(
                        "Repeat Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      TextField(
                        controller: varRepeatPassword,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: decoration,
                        style: editTextStyle,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                CustomButton(
                  onPress: () {
                    if (varPassword.text == varRepeatPassword.text) {
                      registerUser(
                          varName, varEmail, varPassword, varRepeatPassword);
                    } else {
                      _showDialog();
                    }
                  },
                  fillColor: AppColor.magenta,
                  title: "Save and log in",
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: ()=>_backPressed(),
    );
  }

  Future _backPressed() async {
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

  void _showDialog({msg}) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Attention"),
          content: new Text(msg ?? "password has not match"),
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
