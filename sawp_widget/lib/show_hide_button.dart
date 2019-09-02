import 'package:flutter/material.dart';

class ShowHideButton extends StatefulWidget {
  @override
  ShowHideButtonState createState() {
    return new ShowHideButtonState();
  }
}

class ShowHideButtonState extends State<ShowHideButton> {
  //boolean value to determine whether toshow or hide button. `true` by default
  bool _canShowButton = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show & Hide Button Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Center(
                child: _canShowButton
                    ? RaisedButton(
                  color: Colors.red,
                  child: Text('A Button'),
                  onPressed: () {},
                )
                    : SizedBox(),
              ),
            ),
            FlatButton(
              child: Text(_canShowButton ? 'Hide Button' : 'Show Button'),
              onPressed: () {
                setState(() => _canShowButton = !_canShowButton);
              },
            )
          ],
        ),
      ),
    );
  }
}