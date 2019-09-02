import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {



  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    animationController = AnimationController(
        duration: (Duration(seconds: 3)),
        vsync: this);
    animation=Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: animationController, curve: Curves.fastOutSlowIn
        ),


    );
    animationController.forward();

  }


  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child){
          return Scaffold(
            body: Transform(transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
              child: Center(
                child: Container(child: Text("Login")),
              ),

            ),
          );

        }
    );
  }
}
