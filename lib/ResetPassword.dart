import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PasswordTyped.dart';

class ResetPassword extends StatefulWidget {
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  var emailReset, StatusCodeEmail, StatusCodeC, codeCheck;
  TextEditingController varEmail, varCode;
  List<Widget> list = new List();
  bool _canShowButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    varEmail = new TextEditingController();
    varEmail.addListener(() {
      print(varEmail);
    });
    varCode = new TextEditingController();
    varCode.addListener(() {});
    fetchPost(varEmail);
    fetchCode(varEmail, varCode);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    varEmail.dispose();
    super.dispose();
    fetchPost(varEmail);
    fetchCode(varEmail, varCode);
  }

  Future<String> fetchPost(emailReset) async {
    final response = await http.post(
        'http://app.hedy.info/api/passwordreset/requestcode',
        body: {'email': varEmail.text});

    print(response.body);
    var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    //print(data);
    StatusCodeEmail = decodedData['status'];

    return "success";
  }

  Future<String> fetchCode(emailReset, codeCheck) async {
    final response = await http.post(
        'http://app.hedy.info/api/passwordreset/checkcode',
        body: {'email': varEmail.text, 'code': varCode.text});

    print(response.body);
    var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    //print(data);
    StatusCodeC = decodedData['status'];

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 45.0,
              ),
              Image(
                image: AssetImage('images/hedy-logo-black.png'),
                height: 50.0,
                width: 140.0,
              ),
              SizedBox(
                height: 25.0,
              ),
              Text(
                "Forgot your password? Can't Log in?We'll",
                style: TextStyle(color: Colors.black),
              ),
              Text(
                "send a recovery code to your email",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: varEmail,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                height: 50.0,
                width: 340.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Color(0xff963CBD),
                    child: Text(
                      "Send recovery code",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    onPressed: () {
                      fetchPost(varEmail.text);
                      if (varEmail.text == '' || StatusCodeEmail == 0) {
                        _showDialog();
                      } else {
                        setState(() => _canShowButton = !_canShowButton);
                      }
                      //Is==true;
                    }),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: _canShowButton ? _recoveryCode() : SizedBox(),
              )
            ],
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
          SizedBox(
            height: 20.0,
          ),
          Text("Put the recovery code in the box"),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            controller: varCode,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Recovery Code",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 19.0,
                )),
          ),
          SizedBox(
            height: 15.0,
          ),
          SizedBox(
            height: 50.0,
            width: 340.0,
            child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Color(0xff963CBD),
                child: Text(
                  "Send",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onPressed: () {
                  fetchCode(varEmail.text, varCode.text);
                  if (varCode.text == '' || StatusCodeC == 0) {
                    _showCodeWrong();
                  } else {
                    var emailSend = varEmail.text;
                    var codeSend = varCode.text;
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PasswordTyped(emailSend, codeSend);
                    }));
                  }
                }),
          )
        ],
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
          content: new Text("Please put your email address"),
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
