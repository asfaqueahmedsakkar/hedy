import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:http/http.dart' as http;


class ProfilePage extends StatefulWidget{
  int id;
  var name;
  ProfilePage(this.id,this.name);
  _ProfilePageState createState()=> _ProfilePageState(this.id,this.name);
}
class _ProfilePageState extends State<ProfilePage>{
  int id;
  var name;
  var StatusCode,person;
  _ProfilePageState(this.id,this.name);
  TextEditingController varPersonName;

  bool _canShowButton = false;
  bool _canShowButtonM = false;
  bool _tickF=false;
  bool _tickD=false;
  bool _tickP=false;
  bool _tickM=false;
  bool _tickXP=false;
  bool _tickXM=false;
  String relation='0';
  String xRelation='0';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    varPersonName=new TextEditingController();
    varPersonName.addListener((){

    });
  fetchPost(id.toString(), name, varPersonName, relation, xRelation);
  getData();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    varPersonName.dispose();
    super.dispose();
    fetchPost(id.toString(), name, varPersonName, relation, xRelation);
    getData();

  }

  Future<String> fetchPost(id,name,personName,idRelation,xRated) async {
    final response = await http
        .post('http://app.hedy.info/api/profile',
        body: {'id_user':id.toString(),'name':name,'person_name':varPersonName.text,'id_relation':relation,'x_rated':xRelation});

    print(response.body);
    var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    print(relation);
    StatusCode = decodedData['status'];


    return "success";
  }
  Future<String>getData()async{
    final res=await http.get('http://app.hedy.info/api/profile');
    var decode= jsonDecode(res.body);
    person=decode['user']['person_name'];
    print(person);

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.keyboard_backspace,color: Colors.black,size: 30.0,
            ),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
        title: Container(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Colors.black,fontSize: 22.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Details",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17.0,
                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                "Your first name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 15.0,),
              TextField(
                decoration: InputDecoration(
                  hintText: "$name",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                  )
                ),

              ),
              SizedBox(height: 15.0,),
              Text(
                "Your persons first name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 10.0,),
              TextField(
                controller: varPersonName,
                decoration: InputDecoration(
                  hintText: "$person",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 17.0,
                  )
                ),

              ),
              SizedBox(height: 20.0,),
              Text(
                "Your relationship",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: (){
                  relation='0';
                  //print(relation);
                  _tickD=false;
                  _tickP=false;
                  _tickM=false;
                  _canShowButton=false;
                  _canShowButtonM=false;
                  //_canShowButton= ! _canShowButton;
                  setState(() => _tickF = !_tickF);
                },
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.check_circle), onPressed: null),

                    Container(
                        height: 25.0,
                        width: 25.0,

                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: Colors.grey)

                        ),
                        child: Container(
                          child: _tickF
                              ? _tickFriends()
                              : SizedBox(),
                        ),

                      ),

                    SizedBox(width: 8.0,),
                    Text(
                      "Friends",
                      style: TextStyle(
                        color: Colors.black,fontSize: 17.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: (){
                  relation='1';
                  //print(relation);
                  _tickF=false;
                  _tickP=false;
                  _tickM=false;
                  _canShowButton=false;
                  _canShowButtonM=false;
                  //_canShowButton= ! _canShowButton;
                  setState(() => _tickD = !_tickD);
                },
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.check_circle), onPressed: null),
                    Container(
                        height: 25.0,
                        width: 25.0,

                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey)

                        ),
                        child: Container(
                          child: _tickD
                              ? _tickDating()
                              : SizedBox(),
                        ),

                ),



                    SizedBox(width: 8.0,),
                    Text(
                      "Dating",
                      style: TextStyle(
                        color: Colors.black,fontSize: 17.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: (){
                  relation='2';
                  _tickF=false;
                  _tickD=false;
                  _tickM=false;

                  _canShowButtonM=false;
                  _tickP = !_tickP;
                  setState(() => _canShowButton = !_canShowButton);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 25.0,
                      width: 25.0,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey)

                      ),
                      child: Container(
                        child: _tickP
                            ? _tickPartners()
                            : SizedBox(),
                      ),

                    ),

                    SizedBox(width: 8.0,),
                    Text(
                        "Partners",
                        style: TextStyle(
                          color: Colors.black,fontSize: 17.0,
                        ),
                      ),

                  ],
                ),
              ),
              SizedBox(height: 15.0,),
              GestureDetector(
                onTap: (){
                  relation='3';
                  _tickP=false;
                  _tickF=false;
                  _tickD=false;
                  _canShowButton=false;
                  _tickM = !_tickM;
                  setState(() => _canShowButtonM = !_canShowButtonM);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 25.0,
                      width: 25.0,

                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.grey)

                      ),
                      child: Container(
                        child: _tickM
                            ? _tickMarried()
                            : SizedBox(),
                      ),

                    ),

                    SizedBox(width: 8.0,),
                    Text(
                      "Married",
                      style: TextStyle(
                        color: Colors.black,fontSize: 17.0,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.0,),
              Text(
                "We don't want to remind you make a romantic",
                style: TextStyle(
                  color: Colors.black,fontSize: 15.0,
                ),
              ),
              Text(
                "dinner for your friend",
                style: TextStyle(
                  color: Colors.black,fontSize: 15.0,
                ),
              ),
              SizedBox(height: 20.0,),
              Container(
                child: _canShowButton
                    ? _showPartners()
                    : SizedBox(),
              ),
              Container(
                child: _canShowButtonM
                    ? _showmarried()
                    : SizedBox(),
              ),
              SizedBox(height: 30.0,),
              SizedBox(
                height: 50.0,
                width: 120.0,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: (){
                    fetchPost(id.toString(), name, varPersonName.text, relation, xRelation);
                    print(relation);
                    if(StatusCode==1){
                      _showDialog();
                    }

                }),
              ),
              SizedBox(height: 30.0,),
              Text(
                "Sign out from your account on this device ?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                height: 45.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.deepPurpleAccent),

                ),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                alignment: Alignment.center,
              )





            ],
          ),

        ),

      ),

    );

  }
  Widget _showPartners(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Extra sauce",
          style: TextStyle(
            color: Colors.black,fontSize: 16.0,
          ),
        ),
        SizedBox(height: 10.0,),
        GestureDetector(
          onTap: (){
            xRelation='1';
            setState(() => _tickXP = !_tickXP);
          },
          child: Row(
            children: <Widget>[
              Container(
                height: 25.0,
                width: 25.0,

                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey)

                ),
                child: Container(
                  child: _tickXP
                      ? _tickXratedP()
                      : SizedBox(),
                ),

              ),

              SizedBox(width: 10.0,),
              Text(
                "Include x-rated reminders",
                style: TextStyle(
                  color: Colors.black,fontSize: 19.0,
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 20.0,),
        Text(
          "you've been warned",
          style: TextStyle(
            color: Colors.grey,fontSize: 16.0,
          ),
        ),

      ],
    );

  }
  Widget _showmarried(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Extra sauce",
          style: TextStyle(
            color: Colors.black,fontSize: 16.0,
          ),
        ),
        SizedBox(height: 10.0,),
        GestureDetector(
          onTap: (){
            xRelation='1';
            setState(() => _tickXM = !_tickXM);
          },
          child: Row(
            children: <Widget>[
              Container(
                height: 25.0,
                width: 25.0,

                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.grey)

                ),
                child: Container(
                  child: _tickXM
                      ? _tickXratedM()
                      : SizedBox(),
                ),

              ),
              SizedBox(width: 10.0,),
              Text(
                "Include x-rated reminders",
                style: TextStyle(
                  color: Colors.black,fontSize: 19.0,
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 20.0,),
        Text(
          "you've been warned",
          style: TextStyle(
            color: Colors.grey,fontSize: 16.0,
          ),
        ),

      ],
    );

  }
  Widget _tickFriends(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }

  Widget _tickDating(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _tickPartners(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _tickMarried(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _tickXratedP(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }
  Widget _tickXratedM(){
    return Container(
      child: Image(image: AssetImage('images/tick.png')),
    );
  }


  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Success!"),
          content: new Text("Your information is saved"),
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

