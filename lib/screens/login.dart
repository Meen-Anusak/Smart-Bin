import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartbin/screens/content.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();
  String emailString, passwordString;

  Widget backbutton() {
    return IconButton(
      icon: Icon(
        Icons.chevron_left,
        color: Colors.white,
        size: 40.0,
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget logoApp() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset("images/logo.png"),
    );
  }

  Widget appNameText() {
    return Text(
      "CCE Smart Bin",
      style: TextStyle(
        color: Colors.green,
        fontFamily: 'FredokaOne',
        fontSize: 30.0,
      ),
    );
  }

  Widget appName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        logoApp(),
        SizedBox(
          width: 5.0,
        ),
        appNameText(),
      ],
    );
  }

  Widget emailText() {
    return Container(
      width: 300.0,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(
            Icons.email,
            size: 25.0,
            color: Colors.green,
          ),
          labelText: 'Email :',
          labelStyle: TextStyle(color: Colors.green),
        ),
        onSaved: (String value) {
          emailString = value.trim();
        },
      ),
    );
  }

  Widget passWord() {
    return Container(
      width: 300,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          icon: Icon(
            Icons.lock,
            size: 25.0,
            color: Colors.green,
          ),
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.green),
        ),
        onSaved: (String value) {
          passwordString = value.trim();
        },
      ),
    );
  }

  Widget content() {
    return Center(
      child: Form(
          key: formkey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              appName(),
              SizedBox(
                height: 40.0,
              ),
              emailText(),
              SizedBox(
                height: 20.0,
              ),
              passWord(),
              SizedBox(
                height: 60.0,
              ),
              buttonsubmit(),
            ],
          )),
    );
  }

  Widget buttonsubmit() {
    return Container(
      width: 250.0,
      height: 40.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.lightGreen),
        ),
        color: Colors.green,
        child: Text(
          "Login",
          style: TextStyle(
              fontFamily: 'FredokaOne', color: Colors.white, fontSize: 18.0),
        ),
        onPressed: () {
          formkey.currentState.save();
          print("email = $emailString, password = $passwordString");
          checkAuthen();
        },
      ),
    );
  }

  Future<void> checkAuthen() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then(
      (res) {
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext context) => Content());
        Navigator.of(context).pushAndRemoveUntil(
            materialPageRoute, (Route<dynamic> route) => false);
      },
    ).catchError(
      (res) {
        String title = res.code;
        String message = res.message;
        alert(title, message);
      },
    );
  }

  Widget showtitle(String title) {
    return ListTile(
      leading: Icon(
        Icons.add_alert,
        size: 45.0,
        color: Colors.red,
      ),
      title: Text(
        title,
        style: TextStyle(
            color: Colors.red, fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget okbutton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("OK"),
    );
  }

  void alert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: showtitle(title),
            content: Text(message),
            actions: <Widget>[
              okbutton()
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient:
                  RadialGradient(colors: [Colors.white, Colors.green[100]])),
          child: Stack(
            children: <Widget>[
              backbutton(),
              content(),
            ],
          ),
        ),
      ),
    );
  }
}
