import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mashia/utility/utility.dart';

import 'cow_page.dart';

class Individual extends StatefulWidget {
  @override
  _IndividualState createState() => _IndividualState();
}

class _IndividualState extends State<Individual> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _jwtToken;
  void _showSuccessSnack() {
      final snackbar = SnackBar(
          content: Text('Stats successfully loaded!',
              style: TextStyle(color: Colors.green)));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }

    void _showErrorSnack(String errorMsg) {
      final snackbar =
          SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  Future<Map> getDetails() async{
    _jwtToken = await jwtOrEmpty();
    http.Response response = await http.get(
        '$SERVER_IP/api/farmowners/me',
         headers: <String,String>{
           'Content-Type': 'application/json',
           'x-auth-token': '$_jwtToken'
        });
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _showSuccessSnack();
        return data;
      } 
      else {
          _showErrorSnack('Some error occupurpleAccent, try again.');
          return null;
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Individual Statistics'),
        centerTitle: true,
        leading:
          IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pushReplacementNamed(context, '/farmprofile');})
      ),
      body: FutureBuilder<Map>(
              future: getDetails(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  var cows = snapshot.data['dairyfarmInfo']['cows'];
                  if(cows.toString() != '[]'){
                  return Center(
                      child: ListView.builder(
                        itemCount: cows.length,
                        itemBuilder: (BuildContext context, int position){
                          //print('${cows[position]['reading'][position]}');
                          return Column(
                            children: <Widget>[
                              Divider(height: 6.5),
                              Card(
                                child:
                                  ListTile(
                                    title: Text('Tag Id '+'${cows[position]['tag_id']}', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w200, color: Colors.indigo)),
                                    subtitle: Text('${cows[position]['category']}', style: TextStyle(fontSize: 18, color: Colors.indigoAccent)),
                                    onTap: (){ 
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CowInfo( cowObject: cows[position]),
                                        )
                                      );
                                    }
                                 )
                              )
                          ]
                        );
                      })
                  );}
                  else{
                    return Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      child:
                        ListTile(title: Text('No cow profile has been added.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),)
                    );
                  }
                }
                else{
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Theme.of(context).accentColor)) 
                  );
                }
              }
          )
    );
  }
}