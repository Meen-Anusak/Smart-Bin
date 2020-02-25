import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartbin/screens/content.dart';
import 'package:smartbin/screens/login.dart';
import 'register.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState(){
    super.initState();
    checklogin();
  }

  Future<void> checklogin() async{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    if (firebaseUser != null) {
      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) => Content());
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> roter) => false);
    }
  }

  Widget appname() {
    return Text(
      "CCE Smart Bin",
      style: TextStyle(
          fontSize: 30.0,
          color: Colors.green[700],
          // fontWeight: FontWeight.bold,
          fontFamily: 'FredokaOne'),
    );
  }

  Widget applogo() {
    return Container(
      width: 270.0,
      height: 270.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget logocce() {
    return Container(
      width: 60.0,
      height: 60.0,
      child: Image.asset('images/logo_cce.png'),
    );
  }

  Widget logoudru() {
    return Container(
      width: 65.0,
      height: 60.0,
      child: Image.asset('images/logo_udru.png'),
    );
  }

  Widget signIn() {
    return Container(
      width: 130.0,
      height: 40.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.lightGreen),
        ),
        color: Colors.lightGreen,
        
        child: Text(
          "Sign In",
          style: TextStyle(color: Colors.white, fontFamily: 'FredokaOne',fontSize:18.0 ),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context)=>Login());
          Navigator.of(context).push(materialPageRoute);
        }, 
      ),
    );
  }

  Widget signUp() {
    return Container(
      width: 120.0,
      height: 40.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.lightGreen),),
        color: Colors.lightGreen[50],
        child: Text(
          "Sign Up",
          style: TextStyle(fontFamily: 'FredokaOne', color: Colors.lightGreen,fontSize: 18.0),
        ),
        onPressed: () {
          MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context)=>Register());
          Navigator.of(context).push(materialPageRoute);
        },
      ),
    );
  }

  Widget logo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        logocce(),
        SizedBox(width: 50.0),
        logoudru(),
      ],
    );
  }

  Widget button() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signIn(),
        SizedBox(
          width: 25.0,
        ),
        signUp()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [Colors.white,Colors.green[100]])
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 100.0,
              ),
              applogo(),
              SizedBox(
                height: 30.0,
              ),
              appname(),
              SizedBox(
                height: 35.0,
              ),
              button(),
              SizedBox(height: 100.0),
              //  logo(),
            ],
          ),
        ),
      ),
    ));
  }
}
