import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'HomePage.dart';

class ActivationCode extends StatefulWidget{
  var email;
  ActivationCode(this.email);
  _ActivationCodeState createState()=> _ActivationCodeState(this.email);
}

class _ActivationCodeState extends State<ActivationCode>{
  var email;
  _ActivationCodeState(this.email);
  var emailActive,code,StatusCode;

  TextEditingController varCode;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    varCode = new TextEditingController();
    varCode.addListener((){
      print(varCode.text);

    });



    fetchPost(email,varCode);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    varCode.dispose();
    fetchPost(email,varCode);

    super.dispose();
  }



  Future<String> fetchPost(emailActive,code) async {
    final response = await http.post(
        'http://app.hedy.info/api/user/activateprofile',
        body: {'email': email,'code': varCode.text}

    );

    print(response.body);
    var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    //print(data);
    StatusCode= decodedData['status'];
    print("code is $StatusCode");




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
              SizedBox(height: 40.0,),
              Image(
                image: AssetImage('images/hedy-logo-black.png'),
                height: 50.0,
                width: 140.0,
              ),
              SizedBox(height: 30.0,),
              Text(
                "An activation code has been sent to your email $email, put the code in",
                style: TextStyle(
                  color: Colors.black,fontSize: 15.0,
                ),
              ),
              Text(
                "the box below",
                style: TextStyle(
                  color: Colors.black,fontSize: 15.0,
                ),
              ),
              SizedBox(height: 30.0,),
              TextField(
                controller: varCode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Activation code",
                  hintStyle: TextStyle(
                    color: Colors.grey,fontSize: 18.0,
                  )
                ),
              ),
              SizedBox(height: 20.0,),

              SizedBox(
                height: 50.0,
                width: 340.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  color:Color(0xff963CBD),
                    child: Text("Activation",
                    style: TextStyle(color: Colors.white,
                      fontSize: 17.0,
                    ),
                    ),
                    onPressed: (){
                    fetchPost(emailActive, code);
                    if(StatusCode==0){
                      _showDialog();
                    }
                    else if(StatusCode==1){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomePage();
                      }));

                    }







                }),
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