import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../models/country.dart';
import '../models/data_source.dart';
import 'package:intl/intl.dart';

class StatisticsScreen extends StatefulWidget {
  @override
  _StatisticsScreen createState() => _StatisticsScreen();
}

class _StatisticsScreen extends State<StatisticsScreen> {
  final String overallURL =
      'https://api.thevirustracker.com/free-api?global=stats';

  final String countriesURL = 'https://corona.lmao.ninja/v2/countries?now&sort';

  List overallStatistics;
  List countryStatisticsList;
  List<Country> countryStatistics = List<Country>();
  String countryStatisticsTest;

  @override
  void initState() {
    super.initState();
    this.getOverAllJsonData();
    this.geteachCountryJsonData();
  }

  Future<String> getOverAllJsonData() async {
    var response = await http.get(overallURL);
    //print(response.body);
    setState(() {
      var convertToJson = json.decode(response.body);
      overallStatistics = convertToJson['results'];
    });
    return 'Success';
  }

  Future<String> geteachCountryJsonData() async {
    var response = await http.get(countriesURL);
    setState(() {
      var convertToJson = json.decode(response.body);
      countryStatisticsList = convertToJson;

      for (int i = 0; i < convertToJson.length; i++) {
        var countryInfo = convertToJson[i]['countryInfo'];
        countryStatistics.add(
          Country(
            countryName: convertToJson[i]['country'].toString(),
            countryCases: convertToJson[i]['cases'].toString(),
            countryDeaths: convertToJson[i]['deaths'].toString(),
            countryRecovered: convertToJson[i]['recovered'].toString(),
            countryTodayCases: convertToJson[i]['todayCases'].toString(),
            countryTodayDeaths: convertToJson[i]['todayDeaths'].toString(),
            countryFlag: countryInfo['flag'].toString(),
          ),
        );
      }
    });
    print('countryStatistics : ${countryStatistics.length}');
    //print('countryStatistics0 : ${countryStatistics[0].countryFlag}');
    //print('Success');
    return 'Success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFefedf2),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.55,
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 10),
                    child: _buildAppBar(),
                  ),
                  _buildCovid19Containeer(context, overallStatistics),
                ],
              ),
            ),
            countryStatistics.length == 214
                ? Container(
                    height: 300,
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: PaginatedDataTable(
                        sortColumnIndex: 1,
                        sortAscending: false,
                        header: Text(
                          'Countries',
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        columns: [
                          DataColumn(label: Text('Country')),
                          DataColumn(
                              label: Text('Cases'),
                              //numeric: true,
                              onSort: (i, b) {
                                setState(() {
                                  countryStatistics.sort((a, b) =>
                                      int.parse(b.countryCases).compareTo(int.parse(a.countryCases)));
                                });
                              }),
                          DataColumn(label: Text('Deaths')),
                          DataColumn(label: Text('Recovered')),
                          DataColumn(label: Text('New Cases')),
                          DataColumn(label: Text('New Deaths')),
                        ],
                        source: DataSource(countryStatistics),
                      ),
                    ),
                  )
                : Container(child: Text("")),
          ],
        ),
      ),
    );
  }
}

/*class PostDataSource extends DataTableSource{
  final List<Country> _countryStatistics = countryStatistics;

}*/

Widget _buildCovid19Containeer(BuildContext context, List list) {
  String cases = '0';
  String death = '0';
  String recovered = '0';
  if (list != null) {
    cases = list[0]['total_cases'].toString();
    death = list[0]['total_deaths'].toString();
    recovered = list[0]['total_recovered'].toString();
  }
  return Positioned(
    top: MediaQuery.of(context).size.height * 0.2,
    left: MediaQuery.of(context).size.width * 0.1,
    right: MediaQuery.of(context).size.width * 0.1,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      padding: EdgeInsets.symmetric(vertical: 10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        children: <Widget>[
          _buildheadline(context, 'CASES'),
          _buildStatistics(context, cases /*'3,272,062'*/),
          SizedBox(height: 10),
          _buildheadline(context, 'DEATHES'),
          _buildStatistics(context, death /*'231,310'*/),
          SizedBox(height: 10),
          _buildheadline(context, 'RECOVERED'),
          _buildStatistics(context, recovered /*'1,031,489'*/),
        ],
      ),
    ),
  );
}

Widget _buildStatistics(BuildContext context, String number) {
  var f = new NumberFormat(",000", "en_US");
  String parsedNumber = (f.format(int.parse(number)));

  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        parsedNumber,
        style: TextStyle(
          color: Colors.red, //Theme.of(context).primaryColorDark,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildheadline(BuildContext context, String headline) {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text(
        headline,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildAppBar() {
  return Column(
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: null,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/stop.jpg'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ],
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'STATISTICS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  );
}
