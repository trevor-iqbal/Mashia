import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mashia/utility/utility.dart';
import 'package:http/http.dart' as http;

class CompleteStats extends StatefulWidget {
  @override
  _CompleteStatsState createState() => _CompleteStatsState();
}

class _CompleteStatsState extends State<CompleteStats> {
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
        title: Text('Health Statistics'),
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
                          print('${cows[position]['reading'][position]}');
                          return Column(
                            children: <Widget>[
                              Divider(height: 6.5),
                              Card(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Tag Id '+'${cows[position]['tag_id']}'),
                                        Text('Category:'),
                                        Text('Breed:'),
                                        Text('Gender:'),
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(''),
                                        Text('${cows[position]['category']}'),
                                        Text('${cows[position]['breed']}'),
                                        Text('${cows[position]['gender']}')                                              
                                      ],
                                    ),
                                    SizedBox(
                                      child: Card(
                                        color: double.parse('${cows[position]['reading'][position]['pulserate']}') > 80? Colors.red: Colors.green,
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(double.parse('${cows[position]['reading'][position]['pulserate']}') > 80? 'assets/up.png': 'assets/down.png', color: Colors.black,fit: BoxFit.contain,),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text('${cows[position]['reading'][position]['pulserate']}'+'bpm'),
                                                Text('${cows[position]['reading'][position]['temperature']}'+'°C'),
                                                Text('${cows[position]['reading'][position]['rumination']}'+' min'),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
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