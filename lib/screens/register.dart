
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartbin/screens/content.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //
  final formkey = GlobalKey<FormState>();
  String nameString, emailString, passwordString;

  //

  void myAlert(String title, String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: ListTile(
              leading: Icon(
                Icons.add_alert,
                color: Colors.red,
                size: 40.0,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.red),
              ),
            ),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  Widget registerText() {
    return Text(
      "Register",
      style: TextStyle(
          color: Colors.green, fontFamily: 'FredokaOne', fontSize: 35.0),
    );
  }

  Widget nameText() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.person,
          color: Colors.green.shade500,
          size: 35.0,
        ),
        labelText: 'Username :',
        labelStyle: TextStyle(color: Colors.green, fontFamily: 'FredokaOne'),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Please Fill Your Name';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        nameString = value.trim();
      },
    );
  }

  Widget icon() {
    return IconButton(
      icon: Icon(
        Icons.person_add,
        size: 40.0,
        color: Colors.green,
      ),
      onPressed: null,
    );
  }

  Widget name() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon(),
          SizedBox(
            width: 10.0,
          ),
          registerText(),
        ],
      ),
    );
  }

  Widget emailText() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        icon: Icon(
          Icons.email,
          color: Colors.green.shade500,
          size: 35.0,
        ),
        labelText: 'Email :',
        labelStyle: TextStyle(color: Colors.green, fontFamily: 'FredokaOne'),
      ),
      validator: (String value) {
        if (!((value.contains("@")) && (value.contains(".")))) {
          return 'Please Type Email In Email Format';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        emailString = value.trim();
      },
    );
  }

  Widget password() {
    return TextFormField(
      decoration: InputDecoration(
        icon: Icon(
          Icons.lock,
          color: Colors.green.shade500,
          size: 35.0,
        ),
        labelText: 'Password :',
        labelStyle: TextStyle(color: Colors.green, fontFamily: 'FredokaOne'),
        helperText: 'Type password more 6 Charactor',
      ),
      validator: (String value) {
        if (value.length < 6) {
          return 'Please more 6 Charactor';
        } else {
          return null;
        }
      },
      onSaved: (String value) {
        passwordString = value.trim();
      },
    );
  }

  Widget resgisterbutton() {
    return Container(
      width: 200.0,
      height: 40.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          side: BorderSide(color: Colors.lightGreen),
        ),
        color: Colors.lightGreen[500],
        child: Text(
          "register",
          style: TextStyle(
              fontFamily: 'FredokaOne',
              color: Colors.white,
              fontSize: 18.0),
        ),
        onPressed: () {
          print('register');
          if (formkey.currentState.validate()) {
            formkey.currentState.save();
            print(
                'name = $nameString,email = $emailString,password = $passwordString');
            registerThread();
          }
        },
      ),
    );
  }

  Future<void> registerThread() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailString, password: passwordString)
        .then((respones) {
      print("resgister success!");
      setupDisplayname();
    }).catchError((respones) {
      String title = respones.code;
      String message = respones.message;
      print('title = $title, message = $message');
      myAlert(title, message);
    });
  }

  Future<void> setupDisplayname() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.currentUser().then((res){
      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = nameString;
      res.updateProfile(userUpdateInfo);

      MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context ) => Content(),);
      Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route) => false );
    });
  }

  Widget button() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[resgisterbutton()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: TextStyle(fontFamily: 'FredokaOne'),
        ),
        backgroundColor: Colors.green.shade500,
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: EdgeInsets.all(40.0),
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            name(),
            SizedBox(
              height: 50.0,
            ),
            nameText(),
            SizedBox(
              height: 20.0,
            ),
            emailText(),
            SizedBox(
              height: 20.0,
            ),
            password(),
            SizedBox(
              height: 40.0,
            ),
            button(),
          ],
        ),
      ),
    );
  }
}
