import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:hedy/ActivationCode.dart';
import 'package:hedy/AppColor.dart';
import 'package:hedy/BlocProvider.dart';
import 'package:hedy/CutomButton.dart';
import 'package:hedy/DetailsPage.dart';
import 'package:hedy/InfoBloc.dart';
import 'package:hedy/Models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'CreateAccount.dart';
import 'ResetPassword.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController varEmail, varPassword;
  var emailLogin, passwordLogin, statusCode;
  InputDecoration decoration;

  @override
  void initState() {
    super.initState();

    varEmail = new TextEditingController();
    varPassword = new TextEditingController();
    decoration = InputDecoration(
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
  }

  @override
  void dispose() {
    varEmail.dispose();
    varPassword.dispose();
    super.dispose();
  }

  Future<String> login(emailLogin, passwordLogin) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    final response = await http.post('http://app.hedy.info/api/login', body: {
      'email': varEmail.text,
      'password': varPassword.text
    }).catchError((e) {
      print(e);
    });

    var decodedData = jsonDecode(response.body);
    statusCode = decodedData['status'];
    dynamic user = decodedData['user'];

    Navigator.pop(context);
    if (statusCode == 1) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString("user", response.body);
      UserModel userModel = UserModel.fromJson(user);
      BlocProvider.of<InfoBloc>(context).currentUser = userModel;

      if (userModel.completionStatus == 1) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return DetailsPage();
        }));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return ActivationCode();
        }));
      }
    } else {
      _showDialog(msg: decodedData['error_messages'][0]);
    }

    return "success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 48.0,
              ),
              Logo(),
              SizedBox(
                height: 30.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                    style: TextStyle(fontSize: 18.0),
                    decoration: decoration,
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
                    style: TextStyle(fontSize: 18.0),
                    decoration: decoration,
                  ),
                ],
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ResetPassword();
                    }));
                  },
                  child: Text(
                    "Forget password ?",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                  ),
                ),
                alignment: Alignment.centerRight,
              ),
              SizedBox(
                height: 32.0,
              ),
              CustomButton(
                onPress: () {
                  login(varEmail.text, varPassword.text);
                },
                fillColor: AppColor.magenta,
                title: "Log in",
              ),
              SizedBox(
                height: 20.0,
              ),
              CustomButton(
                title: "Log in with Facebook",
                fillColor: AppColor.blue,
                onPress: () {
                  _facebookLogin();
                },
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 54.0,
                width: 340.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: AppColor.magenta,
                    width: 2.0,
                  ),
                ),
                alignment: Alignment.center,
                child: RawMaterialButton(
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  constraints: BoxConstraints.expand(),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateAccount();
                    }));
                  },
                  splashColor: Colors.white,
                  child: Text(
                    "Create account",
                    style: TextStyle(color: AppColor.magenta, fontSize: 18.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog({@required String msg}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          title: new Text(
            "Attention",
            style: TextStyle(fontSize: 20.0),
          ),
          content: new Text(msg, style: TextStyle(fontSize: 16.0)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("ok", style: TextStyle(fontSize: 16.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _facebookLogin() async {
    final facebookLogin = FacebookLogin();
    facebookLogin.loginBehavior = FacebookLoginBehavior.nativeOnly;
    final result = await facebookLogin.logIn(['email']);
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=$token');
        final profile = jsonDecode(graphResponse.body);
        _loginWithFacebookCredintial(profile);
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        _showDialog(msg: result.errorMessage);
        break;
    }
  }

  void _loginWithFacebookCredintial(dynamic json) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(),
            ));

    final response =
        await http.post('http://app.hedy.info/api/login/facebook', body: {
      'email': json["email"].toString(),
      'facebook_id': json["id"].toString(),
    }).catchError((e) {
      print(e);
    });

    var decodedData = jsonDecode(response.body);
    statusCode = decodedData['status'];
    dynamic user = decodedData['user'];
    if (statusCode == 1) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString("user", response.body);
      UserModel userModel = UserModel.fromJson(user);
      BlocProvider.of<InfoBloc>(context).currentUser = userModel;

      await http.post("http://app.hedy.info/api/subscribe", body: {
        "id_user": BlocProvider.of<InfoBloc>(context).currentUser.id.toString(),
        "id_device": BlocProvider.of<InfoBloc>(context).oneSignalUid.toString(),
        "action": "subscribe",
      });

      Navigator.pop(context);

      if (userModel.completionStatus == 1) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return DetailsPage();
        }));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ActivationCode();
        }));
      }
    } else {
      _showDialog(msg: decodedData['error_messages'][0]);
    }
  }
}
