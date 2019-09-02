import 'package:flutter/material.dart';
import 'show_hide_button.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShowHideButton(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final bool swap;

  MyHomePage({Key key, this.swap}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool swap = false;

  @override
  void initState() {
    swap = widget.swap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buttonTile = new ListTile(
      title: new RaisedButton(
          child: new Text("Swap Widget"),
          onPressed: (){
            setState((){
              swap = !swap;
            });
          }
      ),
    );

    Widget swapWidget;
    if (swap) {
      swapWidget = new Text("Brandon");
    } else {
      swapWidget = new Icon(Icons.cake);
    }

    var swapTile = new ListTile(
      title: swapWidget,
    );


    return new Scaffold(
      appBar: new AppBar(
        title: new Text("App Bar Title"),
      ),
      body: new ListView(
        children: <Widget>[
          buttonTile,
          swapTile,
        ],
      ),
    );
  }

}