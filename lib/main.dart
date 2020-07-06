import 'package:flutter/material.dart';
import 'package:mashia/pages/complete_stats.dart';
import 'package:mashia/pages/cow_encyclopedia.dart';
import 'pages/cow_create.dart';
import 'pages/critical.dart';
import 'pages/farm_info.dart';
import 'pages/farm_page.dart';
import 'pages/indiviual.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/register_page.dart';
import 'pages/suspect.dart';
import 'utility/utility.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String logger = await jwtOrEmpty(); 
  runApp( 
    MaterialApp(
        title: 'Mashia',
        routes: {
          '/homepage': (BuildContext context)=> HomePage(),
          '/farm': (BuildContext context)=> FarmPage(),
          '/farmprofile': (BuildContext context)=> FarmProfile(),
          '/login': (BuildContext context)=> LoginPage(),
          '/register': (BuildContext context)=> RegisterPage(),  
          '/cowregister': (BuildContext context)=> CowPage(),
          '/completeStats': (BuildContext context)=> CompleteStats(),
          '/encyclopedia': (BuildContext context)=> Encyclopedia(),
          '/critical': (BuildContext context)=> Critical(),
          '/suspect': (BuildContext context)=> Suspect(),
          '/individual': (BuildContext context)=> Individual()            
        },
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          brightness: Brightness.light,
          textTheme: TextTheme(
            headline5: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
            bodyText2: TextStyle(fontSize: 18.0),
            bodyText1: TextStyle(fontSize: 58.0, fontWeight: FontWeight.bold),
            headline4: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
          )
        ),
        home: logger == "" ? LoginPage():FarmProfile(),
        debugShowCheckedModeBanner: false
    )
  );
}
