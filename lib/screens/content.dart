
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartbin/widget/bin_1.dart';
import 'package:smartbin/widget/bin_2.dart';
import 'package:smartbin/widget/bin_3.dart';
import 'package:smartbin/widget/charts.dart';
import 'home.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}
class _ContentState extends State<Content> {


  Widget currenWidget = ChartsDemo();
  Widget currenHome = ChartsDemo();


   Widget logo() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: Image.asset("images/logo.png"),
    );
  }

  Widget nameApp() {
    return Text(
      "CCE Smart Bin",
      style: TextStyle(
          fontFamily: 'FredokaOne', color: Colors.green[700], fontSize: 20.0),
    );
  }


  Widget showHead() {
    return DrawerHeader(
      child: Column(
        children: <Widget>[
          logo(),
          nameApp(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: Container(
        child: ListView(
          children: <Widget>[
            showHead(),
            SizedBox(
              height: 25.0,
            ),
            chart(),
            SizedBox(height: 25.0,),
            menuBin1(),
            SizedBox(
              height: 25.0,
            ),
            menuBin2(),
            SizedBox(
              height: 25.0,
            ),
            menuBin3(),
          ],
        ),
      ),
    ) ;
  }

     Widget chart() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.home,size: 40.0,color: Colors.blue,),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 35.0,
        ),
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.lightGreen,
            fontFamily: 'FredokaOne',
            fontSize: 20.0,
          ),
        ),
        onTap: () {
          setState(() {
            currenWidget = currenHome;
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

   Widget menuBin1() {
    return Container(
      
      child: ListTile(
        leading: Icon(Icons.delete ,size: 35 , color: Colors.lightGreen,),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 35.0,
        ),
        title: Text(
          "BIN 1",
          style: TextStyle(
            color: Colors.lightGreen,
            fontFamily: 'FredokaOne',
            fontSize: 20.0,
          ),
        ),
        onTap: () {
          setState(() {
            currenWidget = Bin1();
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget menuBin2() {
    return Container(
      child: ListTile(
        leading: Icon(Icons.delete ,size: 35 , color: Colors.yellow[700],),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 35.0,
        ),
        title: Text(
          "BIN 2",
          style: TextStyle(
            color: Colors.yellow[700],
            fontFamily: 'FredokaOne',
            fontSize: 20.0,
          ),
        ),
        onTap: () {
          setState(() {
            currenWidget = Bin2();
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget menuBin3() {
    return Container(
      child: ListTile(
         leading: Icon(Icons.delete ,size: 35 , color: Colors.lightBlue,),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 35.0,
        ),
        title: Text(
          "BIN 3",
          style: TextStyle(
            color: Colors.lightBlue,
            fontFamily: 'FredokaOne',
            fontSize: 20.0,
          ),
        ),
        onTap: () {
          setState(() {
            currenWidget = Bin3();
          });
          Navigator.of(context).pop();
        },
      ),
    );
  }
  void alertsignOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are You Sure ?"),
          content: Text("Do You Want Sign Out"),
          actions: <Widget>[
            cancelButton(),
            okButton(),
          ],
        );
      },
    );
  }

  Widget cancelButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: Text("Cancel"),
    );
  }

  Widget okButton() {
    return FlatButton(
      onPressed: () {
        Navigator.of(context).pop();
        signOut();
      },
      child: Text("OK"),
    );
  }

  Widget signOutbutton() {
    return IconButton(
      icon: Icon(Icons.exit_to_app),
      tooltip: 'Sign Out',
      onPressed: () {
        alertsignOut();
      },
    );
  }
   Future<void> signOut() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    await firebaseAuth.signOut().then((res) {
      MaterialPageRoute materialPageRoute =
          MaterialPageRoute(builder: (BuildContext context) => Home());
      Navigator.of(context).pushAndRemoveUntil(
          materialPageRoute, (Route<dynamic> route) => false);
    });
  }

  ////
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[700],
        title: Text(
          "CCE Smart Bin",
          style: TextStyle(fontFamily: 'FredokaOne'),
        ),
        actions: <Widget>[
          signOutbutton(),
        ],
      ),
      drawer:  showDrawer(),
      body: currenWidget,
    );
  }
}