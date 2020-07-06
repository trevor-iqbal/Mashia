import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mashia/utility/utility.dart';

class FarmPage extends StatefulWidget {
  @override
  _FarmPageState createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _dairyfarmId, _location, _jwtToken;
  bool _isSubmitting;
  
  Widget _showTitle() {
    return Text('Register Farm Profile', style: Theme.of(context).textTheme.headline5);
  }
  Widget _showNameWidget(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
            child: TextFormField(
              onSaved: (val)=> _dairyfarmId = val,
              validator: (val)=> val.length < 6 ? 'too short':null,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dairyfarm Name',
                hintText: 'Enter your Dairyfarm Name',
                icon: Icon(Icons.nature),
              ),
              keyboardType: TextInputType.text,
            )
          );
  }
  Widget _showLocationWidget(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
            child: TextFormField(
              onSaved: (val)=> _location = val,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Dairyfarm Location',
                hintText: 'Enter your Dairyfarm Location',
                icon: Icon(Icons.location_on),
              ),
              keyboardType: TextInputType.text
            )
          );
  }
  Widget _showFormActions(){
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(children: [
          _isSubmitting == true
              ? CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation(Theme.of(context).accentColor))
              : RaisedButton(
                  child: Text('Create Profile',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white)),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: Theme.of(context).accentColor,
                  onPressed: _submit)
        ]));
  }
  void _submit() async{
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      _registerFarm();
    }
  }
  void _registerFarm() async {
    setState(() => _isSubmitting = true);
    _jwtToken = await jwtOrEmpty();
    http.Response response = await http.put('$SERVER_IP/api/farmowners/addDairyFarm',
        body: json.encode({
          "dairyfarm_id":"$_dairyfarmId",
	        "location":"$_location",
	        "cows": []
        }),
         headers: <String,String>{
           'Content-Type': 'application/json',
           'x-auth-token': '$_jwtToken'
        });
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      _showSuccessSnack();
      _redirectUser();
    } else {
      setState(() => _isSubmitting = false);
      _showErrorSnack();
    }
  }
  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/farmprofile');
    });
  }
  void _showSuccessSnack() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text('Farm Profile Created!', style: TextStyle(color: Colors.green))));
    _formKey.currentState.reset();
  }

  void _showErrorSnack() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Unable to create Profile!', style: TextStyle(color: Colors.red))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Farm Profile'),
        centerTitle: true
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _showTitle(),
                  _showNameWidget(),
                  _showLocationWidget(),
                  _showFormActions()
              ]
            )
          )
        )
      )
    );
  }
}