import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mashia/utility/utility.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password;
  bool _isSubmitting, _obscureText = true;
  
  Widget _showTitle() {
    return Text('Login', style: Theme.of(context).textTheme.headline5);
  }
  Widget _showEmailWidget(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
            child: TextFormField(
              onSaved: (val)=> _email = val,
              validator: (val)=> val.contains('@')? null: 'Invalid email address',
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter email',
                icon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          );
  }
  Widget _showPasswordWidget(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
          child: TextFormField(
            onSaved: (val)=> _password = val,
            validator: (val)=> val.length < 4? 'Password too short': null,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                child: IconButton(
                  icon: Icon(_obscureText? Icons.visibility: Icons.visibility_off), 
                  onPressed: ()=> setState(() {
                    _obscureText = !_obscureText;
                  })
                ),
              ),
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter password, upto 6 characters',
              icon: Icon(Icons.lock)
            ),
            obscureText: _obscureText,
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
                  child: Text('Submit',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(color: Colors.white)),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  color: Theme.of(context).accentColor,
                  onPressed: _submit),
          FlatButton(
              child: Text('New user? Register'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/register'))
        ]));
  }
  void _submit() async{
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      _registerUser();
    }
  }
  void _registerUser() async {
    setState(() => _isSubmitting = true);
    http.Response response = await http.post('$SERVER_IP/api/auth',
        body: json.encode({'email': '$_email', 'password': '$_password'}),
         headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
        });
    //final responseData = json.decode(response.body);
    print(response.body.toString());
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      saveToken(response.body.toString());
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
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('User successfully logged in!')));
    _formKey.currentState.reset();
  }

  void _showErrorSnack() {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Invalid email or password.', style: TextStyle(color: Colors.red))));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _showTitle(),
                  _showEmailWidget(),
                  _showPasswordWidget(),
                  _showFormActions()
                ]
              )
            )
          )
        )
      )
    );
  }
}