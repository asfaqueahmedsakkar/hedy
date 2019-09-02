import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'package:onesignal/onesignal.dart';

void main(){
  runApp(
      MaterialApp(
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget{
_MyAppState createState()=> _MyAppState();

}
class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 3),(){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return HomePage();
        }));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/Loading.png'),
            fit: BoxFit.cover,

          )
        ),
        //child: Image(image: AssetImage('images/Loading.png')),
      )
    );
  }

}