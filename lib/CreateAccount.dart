import 'package:flutter/material.dart';
import 'ActivationCode.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class CreateAccount extends StatefulWidget {
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  TextEditingController varEmail, varPassword, varRepeatPassword, varName;
  var email;
  var password;
  var repeatPass;
  var name;

  //var url ='http://app.hedy.info/api/register';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    varEmail = new TextEditingController();
    varEmail.addListener(() {
      print(varEmail.text);
    });
    varPassword = new TextEditingController();
    varPassword.addListener(() {
      print(varPassword.text);
    });
    varRepeatPassword = new TextEditingController();
    varRepeatPassword.addListener(() {
      print(varRepeatPassword);
    });
    varName = new TextEditingController();
    varName.addListener(() {
      print(varName.text);
    });
    fetchPost(varName, varEmail, varPassword, varRepeatPassword);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    varEmail.dispose();
    varPassword.dispose();
    varRepeatPassword.dispose();
    fetchPost(varName, varEmail, varPassword, varRepeatPassword);

    super.dispose();
  }

  Future<String> fetchPost(name, email, password, repeatPass) async {
    final response =
        await http.post('http://app.hedy.info/api/register', body: {
      'name': varName.text,
      'email': varEmail.text,
      'password': varPassword.text,
      'password_confirmation': varPassword.text
    });

    print(response.body);
    //var decodedData = jsonDecode(response.body);
    //print(decodedData);
    //destination = decodedData['DestinationLocation'];
    //data =
    //decodedData['Response']['grouped']['category:AIR']['doclist']['docs'];
    //print(data);

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
              SizedBox(
                height: 50.0,
              ),
              Image(
                image: AssetImage('images/hedy-logo-black.png'),
                height: 50.0,
                width: 140.0,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Create account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "We don't give your details to",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "anyone else",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 5.0,),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        var emails = varEmail.text;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActivationCode(emails);
                        }));
                      },
                      child: Text(
                        "Name",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: varName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
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
                      height: 10.0,
                    ),
                    TextField(
                      controller: varPassword,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      " Repeat Password",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextField(
                      controller: varRepeatPassword,
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(),
                    ),
                  ],
                ),
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
                    color: Color(0xff753BBD),
                    child: Text(
                      "Save and log in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19.0,
                      ),
                    ),
                    onPressed: () {
                      if (varPassword.text == varRepeatPassword.text) {
                        fetchPost(
                            varName, varEmail, varPassword, varRepeatPassword);
                        var emailSend = varEmail.text;
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ActivationCode(emailSend);
                        }));
                      } else {
                        _showDialog();
                      }
                    }),
              ),
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
          content: new Text("password has not match"),
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
