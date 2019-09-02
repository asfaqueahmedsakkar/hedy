import 'package:flutter/material.dart';
import 'Profile.dart';
import 'Settings.dart';

class DetailsPage extends StatefulWidget{
  int id;
  var name;
  DetailsPage(this.id,this.name);
  _DetailsPageState createState()=> _DetailsPageState(this.id,this.name);
}

class _DetailsPageState extends State<DetailsPage>{
  int id;
  var name;
  _DetailsPageState(this.id,this.name);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor:   Color(0xff963CBD),
      appBar: AppBar(
        backgroundColor: Colors.white,
        /*leading: IconButton(
            icon: Icon(Icons.person_outline,color: Colors.black,size: 50.0,),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ProfilePage();
              }));

            }
        ),
        */
        leading: GestureDetector(
          onTap: (){
            int userId=id;
            var userName=name;
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return ProfilePage(userId,userName);
            }));
          },
          child: Image(
              image: AssetImage('images/profile.png'),
            height: 2.0,
            width: 2.0,

          ),
        ),
        title: Container(
          child: Image(image: AssetImage('images/hedy-logo-black.png'),
          height: 40.0,
            width: 80.0,
          ),
          alignment: Alignment.center,
        ),
        actions: <Widget>[
          /*IconButton(icon: Icon(Icons.calendar_today,color: Colors.black,size: 40.0,),
              onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return SettingsPage();
            }));

          }

          )
          */
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return SettingsPage();
              }));

            },
            child: Image(
              image: AssetImage('images/settings.png'),
            ),
          )
        ],

      ),
      body:SingleChildScrollView(
        child: Container(
          child: Image(image: AssetImage('images/drawn-heart.png')),
        ),


             ),
    );
  }

}