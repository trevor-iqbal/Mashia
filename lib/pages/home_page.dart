import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    void _redirectFarmProfile() async{
      Navigator.pushReplacementNamed(context, '/farm');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Farm Profile'),
        centerTitle: true
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.white,
        child: 
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Farm Profile', style: Theme.of(context).textTheme.headline5),
                Image.asset('assets/launch_image.png'),
                Text('Click below to register your farm on Mashia'),
                IconButton(
                  icon: Icon(Icons.add), 
                  color: Theme.of(context).accentColor,
                  //focusColor: Colors.,
                  iconSize: 66.0, onPressed: ()async=>_redirectFarmProfile())
              ]
            )
          )
      )
    );
  }
}