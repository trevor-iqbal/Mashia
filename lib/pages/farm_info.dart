import 'package:flutter/material.dart';
import 'package:mashia/utility/utility.dart';
import 'package:place_picker/place_picker.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'cow_page.dart';
//https://mashia.herokuapp.com/api/farmowners/me
class FarmProfile extends StatefulWidget {
  @override
  _FarmProfileState createState() => _FarmProfileState();
}

class _FarmProfileState extends State<FarmProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    void _logout() async {
      deleteToken();
      Navigator.pushReplacementNamed(context, '/login');
    }

    void _purpleAccentirectCowCreate() async {
      Navigator.pushReplacementNamed(context, '/cowregister');
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('FARM STATISTICS'), actions: <Widget>[
        IconButton(
            icon: Icon(Icons.exit_to_app), onPressed: () async => _logout())
      ]),
      body: OrientationBuilder(builder: (context, orientation) {
        int count = 2;
        if (orientation == Orientation.landscape) {
          count = 3;
        }
        return Padding(
            padding: const EdgeInsets.all(5.0),
            child: GridView.count(crossAxisCount: count, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/critical');
                  },
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black, width: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/thermometer.png',
                            height: 55.0, color: Colors.white),
                        Text('HEAT',
                            style: TextStyle(fontSize: 25, color: Colors.white))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/suspect');
                  },
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black, width: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.add_alert, color: Colors.white, size: 60),
                        Text('SUSPECT',
                            style: TextStyle(fontSize: 25, color: Colors.white))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/completeStats');
                  },
                  color: Colors.indigo,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black, width: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Icon(Icons.show_chart, color: Colors.white, size: 60),
                        Image.asset('assets/stats.png',
                            color: Colors.white, height: 55),
                        Text('OVERALL\n  STATS',
                            style: TextStyle(fontSize: 25, color: Colors.white))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/individual');
                  },
                  color: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black, width: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/cow.png',
                            color: Colors.white,
                            height:
                                55.0), //Icon(Icons., color: Colors.white, size: 60),
                        Text('INDIVIDUAL',
                            style: TextStyle(fontSize: 25, color: Colors.white))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: FlatButton(
                  onPressed: () async {
                    LocationResult result = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PlacePicker(
                                "AIzaSyCvOHofZaFlNMJhCoEM2dqwATbBaC3J_oU")));
                    print(result);
                  },
                  color: Colors.teal,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.0),
                      side: BorderSide(color: Colors.black, width: 0.1)),
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.my_location, color: Colors.white, size: 52),
                        Text('LOCATION',
                            style: TextStyle(fontSize: 25, color: Colors.white))
                      ]),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/encyclopedia');
                      },
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1.0),
                          side: BorderSide(color: Colors.black, width: 0.1)),
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('assets/enc.png', color: Colors.white),
                            Text('ENCYCLOPEDIA',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors
                                        .white)) //TextStyle(fontSize: 18.0, color: Colors.white))
                          ])))
            ]));
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async => _purpleAccentirectCowCreate(),
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.add)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
