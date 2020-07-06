import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mashia/utility/utility.dart';

// email:"ahmed.iqbal@gmail.com"
// password:"$2b$10$Y8/AeLJsv3Ayx5li3mq4u.G81DHrq0OHzEH7EaMXCRbhFUA9ftDEG"
// cnic:"129234873211"
// phone:"19413213319"

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting, _obscureText = true;
  String  _email, _password, _phone, _cnic;

  Widget _showTitle() {
    return Text('Register', style: Theme.of(context).textTheme.headline5);
  }
  Widget _showPhoneInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _phone = val,
        validator: (val) => val.length < 11? 'Incomplete Phone number': null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter Phone Number here',
          hintText: 'Enter a valid phone number',
          icon: Icon(Icons.phone, color: Colors.grey)   
        ),
          keyboardType: TextInputType.phone
      )  
    );
  }
  Widget _showCNICInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _phone = val,
        validator: (val) => val.length < 11? 'Incomplete CNIC': null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter CNIC here',
          hintText: 'Enter a valid cnic',
          icon: Icon(Icons.phone, color: Colors.grey)   
        ),
          keyboardType: TextInputType.phone
      )  
    );
  }
  Widget _showEmailInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _email = val,
          validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'Enter a valid email',
              icon: Icon(Icons.mail, color: Colors.grey)),
              keyboardType: TextInputType.emailAddress));
  }

  Widget _showPasswordInput() {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: TextFormField(
          onSaved: (val) => _password = val,
          validator: (val) => val.length < 6 ? 'Username too short' : null,
          obscureText: _obscureText,
          decoration: InputDecoration(
              suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                  child: Icon(_obscureText
                      ? Icons.visibility
                      : Icons.visibility_off)),
              border: OutlineInputBorder(),
              labelText: 'Password',
              hintText: 'Enter password, min length 6',
              icon: Icon(Icons.lock, color: Colors.grey))));
  }

  Widget _showFormActions() {
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
              child: Text('Existing user? Login'),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, '/login'))
        ]));
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    }
  }

  void _registerUser() async {
    setState(() => _isSubmitting = true);
    http.Response response = await http.post(
        '$SERVER_IP/api/farmowners',
        body: json.encode({'email': '$_email', 'password': '$_password', 'cnic': '$_cnic', 'phone':'$_phone'}),
        headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
        });
    //final responseData = json.decode(response.body);
    Map<String,  String> header = response.headers;
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      saveToken(header['x-auth-token']);
      _showSuccessSnack();
      _redirectUser();
    } else {
      setState(() => _isSubmitting = false);
      _showErrorSnack('Some error occured, try again.');
    }
  }
  
  void _showSuccessSnack() {
    final snackbar = SnackBar(
        content: Text('User $_email successfully created!',
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    //throw Exception('Error registering: $errorMsg');
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/homepage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text('Register')),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
                child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(children: [
                          _showTitle(),
                          _showEmailInput(),
                          _showPasswordInput(),
                          _showPhoneInput(),
                          _showCNICInput(),
                          _showFormActions()
                        ]))))));
  }
}