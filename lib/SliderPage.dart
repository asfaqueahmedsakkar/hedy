import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import 'DetailsPage.dart';

class SliderPage extends StatefulWidget{
  int id;
  var name;
  SliderPage(this.id,this.name);
  _SliderPageState createState()=> _SliderPageState(this.id,this.name);
}
class  _SliderPageState extends State<SliderPage>{


  PageController controller;
  int id;
  var name;
  _SliderPageState(this.id,this.name);

  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int count=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: new Container(
        //color: Colors.pink,
        child: Container(
          //height: 120.0,
          child: PageIndicatorContainer(
           child: PageView(
              children: <Widget>[
                Container(
                  color: Color(0xff963CBD),
                  child: Column(
                    children: <Widget>[
                       Container(
                          //height: 350.0,
                          //color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(top:96.0),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 15.0,),
                                  Text(
                                    "Hi new friend!",
                                    style: TextStyle(
                                      color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(height: 25.0,),
                                  Text("Life is busy and we sometimes",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),

                                  Text("forget to say and do the simple",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  Text("Life is busy and we sometimes",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  Text("Life is busy and we sometimes",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),

                                  Text("forgte to say and do simple",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  Text("things that let others know we",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  Text("care about them. Or you might",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  Text("just like some inspiration for nice",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),


                                  Text("things to say and do for your",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),

                                  Text("special person",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  SizedBox(height: 5.0,),
                                  Text("We're here to help",style: TextStyle(color: Colors.white,fontSize: 18.0,
                                      fontWeight: FontWeight.bold),),
                                  SizedBox(height: 25.0,),
                                  Text("Let's go through some basic steps",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),
                                  Text("to get you set up",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                      fontWeight: FontWeight.w300),),

                                ],
                              ),
                            ),
                          ),
                        ),

                      //height: 70.0,



                    ],
                  ),
                ),
                Container(
                  color: Color(0xff963CBD),
                  child: Column(
                    children: <Widget>[
                      Container(
                        //height: 350.0,
                        //color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top:96.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 30.0,),
                                Text(
                                  "Your details",
                                  style: TextStyle(
                                      color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 25.0,),
                                Text("First of all we need some details",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),

                                Text("about you and your special",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("person, Simples stuff like your",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("names and level of relationship",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                SizedBox(height: 20.0,),
                                Text("Once you've finished this guide",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("you can click on the profile icon to",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),

                                Text("get started",style: TextStyle(color: Colors.white,fontSize: 18.0,
                                    fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //height: 70.0,



                    ],
                  ),
                ),
                Container(
                  color: Color(0xff963CBD),
                  child: Column(
                    children: <Widget>[
                      Container(
                        //height: 350.0,
                        //color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top:96.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 30.0,),
                                Text(
                                  "Scheduling",
                                  style: TextStyle(
                                      color: Colors.white,fontSize: 28.0,fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 25.0,),
                                Text("Hedy can schedule reminders of",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),

                                Text("nice things to say, do or buy for",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("your person. These can be set to",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("occur once a day, once a week or",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("once a month",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                SizedBox(height: 20.0,),
                                Text("You can access the scheduling",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("settings by clicking the calender/",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("time icon in the top right corner.",style: TextStyle(color: Colors.white,fontSize: 18.0,
                                    fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //height: 70.0,



                    ],
                  ),
                ),
                Container(
                  color: Color(0xff963CBD),
                  child: Column(
                    children: <Widget>[
                      Container(
                        //height: 350.0,
                        //color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.only(top:96.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 20.0,),
                                Text(
                                  "Remind list",
                                  style: TextStyle(
                                      color: Colors.white,fontSize: 30.0,fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 25.0,),
                                Text("Once we've sent you some",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),

                                Text("reminders, you will see them all",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("listed on the homescreen",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                SizedBox(height: 20.0,),

                                Text("You can swipe right if you have",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("done the things and we won't",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("remind you of that again for a",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("while. Swipe left if it's something",style: TextStyle(color: Colors.white,fontSize: 17.0,
                                    fontWeight: FontWeight.w300),),
                                Text("you do't feel is quite right for",style: TextStyle(color: Colors.white,fontSize: 18.0,
                                    fontWeight: FontWeight.w300),),
                                Text("you or your person and you won't",style: TextStyle(color: Colors.white,fontSize: 18.0,
                                    fontWeight: FontWeight.w300),),
                                Text("recive that reminder again",style: TextStyle(color: Colors.white,fontSize: 18.0,
                                    fontWeight: FontWeight.w300),),
                                Padding(
                                  padding: const EdgeInsets.only(top:30.0,bottom: 20.0),
                                  child: SizedBox(
                                    height: 50.0,
                                    width: 210.0,
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        color: Colors.white,
                                        child: Text("Get started",style: TextStyle(
                                          color: Color(0xff963CBD),
                                        ),),
                                        onPressed: (){
                                          int userId=id;
                                          var userName=name;
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return DetailsPage(userId,userName);
                                          }));
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //height: 70.0,



                    ],
                  ),
                ),

              ],
              controller: controller,
            ),
            align: IndicatorAlign.bottom,
            length: 4,
            indicatorSpace: 10.0,
            //indicatorColor: Colors.lightBlueAccent,
            indicatorSelectorColor: Colors.lightBlueAccent,
          ),
        ),
      ),

    );
  }

}