import 'dart:convert';

import 'package:flutter/material.dart';
import 'CreateAccount.dart';
import 'SliderPage.dart';
import 'package:onesignal/onesignal.dart';
import 'package:http/http.dart' as http;
import 'ResetPassword.dart';




class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //OneSignal.shared.init("343c7750-2f38-4244-a09c-be77fb655a8c", iOSSettings: settings);
  TextEditingController varEmail,varPassword;
  var emailLogin,paaswordLogin,StatusCode,name;
  int id;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OneSignal.shared.init(
        "d7809362-d385-4fee-932a-30daff16ecc7",
        iOSSettings: {
          OSiOSSettings.autoPrompt: false,
          OSiOSSettings.inAppLaunchUrl: true
        }
    );
    OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);

    varEmail = new TextEditingController();
    varEmail.addListener((){
      print(varEmail.text);

    });
    varPassword = new TextEditingController();
    varPassword.addListener((){
      print(varPassword.text);

    });



    fetchPost(varEmail,varPassword);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    varEmail.dispose();
    varPassword.dispose();
    fetchPost(varEmail,varPassword);
    super.dispose();
  }

  Future<String> fetchPost(emailLogin,passwordLogin) async {
    final response = await http.post(
        'http://app.hedy.info/api/login',
        body: {'email': varEmail.text,'password': varPassword.text}

    );

    print(response.body);
    var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    //print(data);
    StatusCode=decodedData['status'];
    id=decodedData['user']['id'];
    name=decodedData['user']['name'];
    print("id is $id");
    print(name);


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
            // mainAxisAlignment: MainAxisAlignment.start,
            //crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 30.0,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: varEmail,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    TextField(
                      controller: varPassword,
                      obscureText: true,
                      decoration: InputDecoration(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                child:
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ResetPassword();
                        }));
                      },
                      child: Text(
                        "Forget password ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.0,
                        ),


                ),
                    ),
                alignment: Alignment.centerRight,

              ),

              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 50.0,
                width: 340.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color:Color(0xff963CBD),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      fetchPost(varEmail.text, varPassword.text);
                      if(StatusCode==0){
                        _showDialog();
                      }
                      else if(StatusCode==1){
                        int userId=id;
                        var userName=name;
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SliderPage(userId,userName);
                        }));
                      }

                    }),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 50.0,
                width: 340.0,
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Color(0xff407EC9),
                    child: Text(
                      "Log in with Facebook",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {


                    }),
              ),
              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return CreateAccount();
                  }));
                },
                child: Container(
                  height: 50.0,
                  width: 340.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color:Color(0xff963CBD)),
                  ),
                  child: Text(
                    "Create account",
                    style: TextStyle(
                      color:Color(0xff963CBD),
                    ),
                  ),
                  alignment: Alignment.center,
                ),
              )
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
          content: new Text("Email or Password is not correct."),
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
