import 'package:flutter/material.dart';
import './statistics_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFefedf2),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              children: <Widget>[
                Container(
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
                _buildCovid19Containeer(context),
                _buildWuhanImage(context),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: "Symptoms Of ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: 'COVID-19',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      _buildSymptomItem(
                          context, 'assets/images/fever.png', 'Fever'),
                      _buildSymptomItem(
                          context, 'assets/images/drycough.png', 'Dry Cough'),
                      _buildSymptomItem(
                          context, 'assets/images/headache.png', 'Headache'),
                      _buildSymptomItem(context,
                          'assets/images/breatheless.png', 'Breatheless'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Confirmed Cases Of ",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: 'COVID-19',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StatisticsScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87,
                          offset: Offset(1, 1),
                          spreadRadius: 1,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/map.png'),
                        // Fill The remaining space in Row or Column
                        Expanded(child: SizedBox()),
                        RichText(
                          text: TextSpan(
                            text: "Start Of ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                            children: [
                              TextSpan(
                                text: 'COVID-19\n',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                              TextSpan(
                                text:
                                    'The disease was first identified\n in December 2019 in Wuhan,\n'
                                    ' and has since spread globally,\n'
                                    ' resulting in the ongoing\n 2019–20 coronavirus pandemic.\n As of 30 April 2020\n',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios),
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomItem(BuildContext context, String path, String symptom) {
    return Column(
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.8),
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                offset: Offset(1, 1),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
          ),
          child: Image.asset(path),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          symptom,
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildWuhanImage(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.33,
      right: MediaQuery.of(context).size.width * 0.12,
      child: Container(
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
            image: AssetImage('assets/images/wuhan.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildCovid19Containeer(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.13,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Covid-19',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'In the public mind, the origin story of coronavirus seems well fixed: in '
                  'late 2019 someone at the now world-famous Huanan seafood market in Wuhan was infected'
                  'with a virus from an animal. The rest is part of an awful history still in the making, with Covid-19'
                  'spreading from that first cluster in the capital of China’s Hubei province to a pandemic',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Row _buildAppBar() {
    return Row(
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
    );
  }
}
