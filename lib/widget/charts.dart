import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';

class ChartsDemo extends StatefulWidget {
  @override
  ChartsDemoState createState() => ChartsDemoState();
}

class ChartsDemoState extends State<ChartsDemo> {
  //

  List<charts.Series> seriesList;

  static List<charts.Series<Sales, String>> _createRandomData() {
    final random = Random();

    final desktopSalesData = [
      Sales('Mon', random.nextInt(100)),
      Sales('Tues', random.nextInt(100)),
      Sales('Wednes', random.nextInt(100)),
      Sales('Thurs', random.nextInt(100)),
      Sales('Fri', random.nextInt(100)),
      Sales('Satur', random.nextInt(100)),
      Sales('Sun', random.nextInt(100)),
    ];

    final tabletSalesData = [
      Sales('Mon', random.nextInt(100)),
      Sales('Tues', random.nextInt(100)),
      Sales('Wednes', random.nextInt(100)),
      Sales('Thurs', random.nextInt(100)),
      Sales('Fri', random.nextInt(100)),
      Sales('Satur', random.nextInt(100)),
      Sales('Sun', random.nextInt(100)),
    ];

    final mobileSalesData = [
      Sales('Mon', random.nextInt(100)),
      Sales('Tues', random.nextInt(100)),
      Sales('Wednes', random.nextInt(100)),
      Sales('Thurs', random.nextInt(100)),
      Sales('Fri', random.nextInt(100)),
      Sales('Satur', random.nextInt(100)),
      Sales('Sun', random.nextInt(100)),
    ];

    return [
      charts.Series<Sales, String>(
        id: 'BIN 1',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: desktopSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.green.shadeDefault;
        },
      ),
      charts.Series<Sales, String>(
        id: 'BIN 2',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: tabletSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.yellow.shadeDefault;
        },
      ),
      charts.Series<Sales, String>(
        id: 'BIN 3',
        domainFn: (Sales sales, _) => sales.year,
        measureFn: (Sales sales, _) => sales.sales,
        data: mobileSalesData,
        fillColorFn: (Sales sales, _) {
          return charts.MaterialPalette.blue.shadeDefault;
        },
      )
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

/*--------------------------------------------- Chart ------------------------------------------------ */

  @override
  void initState() {
    super.initState();
    seriesList = _createRandomData();

    dataMap.putIfAbsent("BIN 1", () => 5);
    dataMap.putIfAbsent("BIN 2", () => 3);
    dataMap.putIfAbsent("BIN 3", () => 2);
  }

  text() {
    return Container(
      child: Text(
        'Waste Per Week',
        style: TextStyle(
          color: Colors.lightBlue,
          fontFamily: 'FredokaOne',
          fontSize: 25.0,
        ),
      ),
    );
  }

  Widget iconchart() {
    return IconButton(
        icon: Icon(
          Icons.poll,
          size: 25.0,
          color: Colors.lightBlue,
        ),
        onPressed: () {});
  }

  Widget textweek() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[iconchart(), text()],
      ),
    );
  }

/*-----------------------------------------Pie Charts-----------------------------  */
  bool toggle = true;
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.green,
    Colors.yellow,
    Colors.blue,
  ];

  chartpie() {
    return PieChart(
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width / 2.7,
      showChartValuesInPercentage: true,
      showChartValues: true,
      showChartValuesOutside: false,
      chartValueBackgroundColor: Colors.grey[200],
      colorList: colorList,
      showLegends: true,
      legendPosition: LegendPosition.right,
      decimalPlaces: 1,
      showChartValueLabel: true,
      initialAngle: 0,
      chartValueStyle: defaultChartValueStyle.copyWith(
        color: Colors.blueGrey[900].withOpacity(0.9),
      ),
      chartType: ChartType.disc,
    );
  }

/*----------------------- end Pie Chart ----------------------------------------- */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 30.0),
                  child: textweek(),
                ),
                Container(
                  width: 500.0,
                  height: 320.0,
                  padding: EdgeInsets.all(40.0),
                  child: barChart(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: chartpie(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Sales {
  final String year;
  final int sales;

  Sales(this.year, this.sales);
}
