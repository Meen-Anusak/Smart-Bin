import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:firebase_database/firebase_database.dart';

class Bin2 extends StatefulWidget {
  @override
  _Bin2State createState() => _Bin2State();
}

class _Bin2State extends State<Bin2> {
    int dataBin;
  //////// firebase ////////////
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;

  void readData() async {
    print('readData work!');

    DatabaseReference databaseReference =
        firebaseDatabase.reference().child("BIN2");
    await databaseReference.once().then(
      (DataSnapshot dataSnapshot) {
        // print("Data = ${dataSnapshot.value}");
        // dataBin = dataSnapshot.value;
        Map<dynamic,dynamic> values = dataSnapshot.value;
        values.forEach((key,value){
          print(value['value']);
          setState(() {
            dataBin = value['value'];
          });
        });
        
      },
    );
  }


  //////////// chast ////////////
  List<charts.Series> seriesList;
  static List<charts.Series<Trash, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Trash('Mon', random.nextInt(100)),
      Trash('Tues', random.nextInt(100)),
      Trash('Wednes', random.nextInt(100)),
      Trash('Thurs', random.nextInt(100)),
      Trash('Fri', random.nextInt(100)),
      Trash('Satur', random.nextInt(100)),
      Trash('Sun', random.nextInt(100)),
    ];

    return [
      charts.Series<Trash, String>(
        id: 'BIN 1',
        domainFn: (Trash trash, _) => trash.day,
        measureFn: (Trash trash, _) => trash.garbage,
        data: desktopSalesData,
        fillColorFn: (Trash sales, _) {
          return charts.MaterialPalette.deepOrange.shadeDefault;
        },
      ),
    ];
  }

  barChart() {
    return charts.BarChart(seriesList,
        animate: true,
        vertical: true,
        barGroupingType: charts.BarGroupingType.grouped,
        defaultRenderer: charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped,
          strokeWidthPx: 1.0,
        ),
        behaviors: []);
  }

  //////////////////////////////////
  Widget textbin2() {
    return Text(
      'BIN 2',
      style: TextStyle(
        color: Colors.yellow[700],
        fontFamily: 'FredokaOne',
        fontSize: 40.0,
      ),
    );
  }

  Widget imgBin() {
    return Container(
      width: 200,
      height: 200,
      child: Image.asset(
        'images/bin_oreng.png',
      ),
    );
  }

  Widget valueBin() {
    return Text(
      '$dataBin %',
      style: TextStyle(
          fontFamily: 'FredokaOne', fontSize: 35.0, color: Colors.yellow[700]),
    );
  }

  @override
  void initState() {
    super.initState();
    readData();
    seriesList = _createRandomData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin:  EdgeInsets.only(top: 30.0),
                    child: textbin2(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 35.0),
                    child: imgBin(),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: valueBin(),
                  ),
                  Container(
                    width: 500.0,
                    height: 320.0,
                    padding: EdgeInsets.all(40.0),
                    child: barChart(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Trash {
  final String day;
  final int garbage;

  Trash(this.day, this.garbage);
}
