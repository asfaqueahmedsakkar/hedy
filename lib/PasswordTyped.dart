import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class PasswordTyped extends StatefulWidget{
  var email,code;
  PasswordTyped(this.email,this.code);
  _PasswordTypedState createState()=> _PasswordTypedState(this.email,this.code);
}
class  _PasswordTypedState extends State<PasswordTyped>{
  var email,code,password,confirmPassword,StatusCode;
  TextEditingController varPassword,varConfirmPassword;
  _PasswordTypedState(this.email,this.code);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    varPassword = new TextEditingController();
    varPassword.addListener(() {

    });
    varConfirmPassword=new TextEditingController();
    varConfirmPassword.addListener((){

    });
    fetchPost(email,code,varPassword,varConfirmPassword);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    varPassword.dispose();
    varConfirmPassword.dispose();

    super.dispose();
    fetchPost(email,code,varPassword,varConfirmPassword);


  }


  Future<String> fetchPost(email,code,Password,ConfirmPassword) async {
    final response = await http
        .post('http://app.hedy.info/api/passwordreset/changepass',
        body: {'email':email,'code':code,'password':varPassword.text,'password_confirmation':varConfirmPassword.text});

    print(response.body);
    var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    //print(data);
    StatusCode = decodedData['status'];

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
              SizedBox(height: 60.0,),
              Image(
                image: AssetImage('images/hedy-logo-black.png'),
                height: 50.0,
                width: 150.0,
              ),
              SizedBox(height: 30.0,),
              Text(
                "You can reset your password now",
                style: TextStyle(
                  color: Colors.black,fontSize: 13.0,
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: varPassword,
                decoration: InputDecoration(
                  hintText: "New password",
                  hintStyle: TextStyle(
                    color: Colors.grey,fontSize: 18.0,
                  )
                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                controller: varConfirmPassword,
                decoration: InputDecoration(
                    hintText: "Re-type password",
                    hintStyle: TextStyle(
                      color: Colors.grey,fontSize: 18.0,
                    )
                ),
              ),
              SizedBox(height: 25.0,),
              SizedBox(
                height: 50.0,
                width: 340.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                    color: Color(0xff813BBD),
                    child: Text(
                      "Change password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    onPressed: (){
                    fetchPost(email, code, varPassword.text, varConfirmPassword.text);
                    if(varPassword.text==varConfirmPassword.text && StatusCode==1){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomePage();
                      }));
                      print(email);
                      print(code);

                    }
                    else{
                     _showDialog();
                    }

                }
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