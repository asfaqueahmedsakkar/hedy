import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/CutomButton.dart';
import 'package:hedy/ResetPassword.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class PasswordTyped extends StatefulWidget {
  final dynamic email, code;

  PasswordTyped(this.email, this.code);

  _PasswordTypedState createState() =>
      _PasswordTypedState(this.email, this.code);
}

class _PasswordTypedState extends State<PasswordTyped> {
  var email, code, password, confirmPassword, statusCode;
  TextEditingController varPassword, varConfirmPassword;

  _PasswordTypedState(this.email, this.code);

  @override
  void initState() {
    varPassword = new TextEditingController();
    varConfirmPassword = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    varPassword.dispose();
    varConfirmPassword.dispose();

    super.dispose();
  }

  Future<String> fetchPost(email, code, password, confirmPassword) async {
    final response = await http
        .post('http://app.hedy.info/api/passwordreset/changepass', body: {
      'email': email,
      'code': code,
      'password': varPassword.text,
      'password_confirmation': varConfirmPassword.text
    });

    print(response.body);
    var decodedData = jsonDecode(response.body);
    statusCode = decodedData['status'];

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 64.0,
              ),
              Logo(),
              SizedBox(
                height: 32.0,
              ),
              Text(
                "You can reset your password now",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              TextField(
                controller: varPassword,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.0)),
                    hintText: "New password",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    )),
              ),
              SizedBox(
                height: 32.0,
              ),
              TextField(
                controller: varConfirmPassword,
                style: TextStyle(fontSize: 18.0),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0)),
                  hintText: "Re-type password",
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
                title: "Change passward",
                fillColor: AppColor.magenta,
                onPress: () {
                  fetchPost(
                      email, code, varPassword.text, varConfirmPassword.text);
                  if (varPassword.text == varConfirmPassword.text &&
                      statusCode == 1) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomePage();
                    }));
                    print(email);
                    print(code);
                  } else {
                    _showDialog();
                  }
                },
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
          content: new Text("Password doesn't match"),
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
