import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/CutomButton.dart';
import 'package:http/http.dart' as http;

import 'PasswordTyped.dart';

class ResetPassword extends StatefulWidget {
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var emailReset, statusCodeEmail, statusCodeC, codeCheck, msg;
  TextEditingController emailController, codeController;
  List<Widget> list = new List();
  bool _canShowButton = false;

  @override
  void initState() {
    emailController = new TextEditingController();
    codeController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    super.dispose();
  }

  Future<String> requestRecoveryCode(emailReset) async {
    final response = await http.post(
        'http://app.hedy.info/api/passwordreset/requestcode',
        body: {'email': emailController.text});

    print(response.body);
    var decodedData = jsonDecode(response.body);
    statusCodeEmail = decodedData['status'];
    if (statusCodeEmail == 0)
      msg = decodedData['message'];
    else
      msg = null;

    return "success";
  }

  Future<String> submitRecoveryCode(emailReset, codeCheck) async {
    final response = await http.post(
        'http://app.hedy.info/api/passwordreset/checkcode',
        body: {'email': emailController.text, 'code': codeController.text});

    print(response.body);
    var decodedData = jsonDecode(response.body);
    statusCodeC = decodedData['status'];

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
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
                  "Forgot your password? Can't Log in?We'll send a recovery code to your email",
                  style: TextStyle(color: Colors.black, fontSize: 14.0),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 32.0,
                ),
                TextField(
                  controller: emailController,
                  style: TextStyle(fontSize: 18.0),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.0)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.0)),
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  height: 32.0,
                ),
                CustomButton(
                  title: "Send recovery code",
                  fillColor: AppColor.magenta,
                  onPress: () {
                    requestRecoveryCode(emailController.text);
                    if (emailController.text == '' || statusCodeEmail == 0) {
                      _showDialog(msg: msg);
                    } else {
                      setState(() => _canShowButton = !_canShowButton);
                    }
                    //Is==true;
                  },
                ),
                SizedBox(
                  height: 32.0,
                ),
                Container(
                  child: _canShowButton
                      ? _recoveryCode()
                      : SizedBox(
                          height: 32.0,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _recoveryCode() {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          Text(
            "Put the recovery code in the box",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 32.0,
          ),
          TextField(
            controller: codeController,
            keyboardType: TextInputType.number,
            style: TextStyle(
              fontSize: 18.0,
            ),
            decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0)),
              hintText: "Recovery Code",
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
            fillColor: AppColor.magenta,
            title: "Send",
            onPress: () {
              submitRecoveryCode(emailController.text, codeController.text);
              if (codeController.text == '' || statusCodeC == 0) {
                _showCodeWrong();
              } else {
                var emailSend = emailController.text;
                var codeSend = codeController.text;
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PasswordTyped(emailSend, codeSend);
                }));
              }
            },
          ),
          SizedBox(
            height: 64.0,
          )
        ],
      ),
    );
  }

  void _showDialog({String msg}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          title: new Text("Attention"),
          content: new Text(msg ?? "Please put your email address"),
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

  void _showCodeWrong() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Attention"),
          content: new Text("Your code is invalid"),
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

class Logo extends StatelessWidget {
  const Logo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('images/hedy-logo-black.png'),
      height: 50.0,
      width: 140.0,
    );
  }
}
