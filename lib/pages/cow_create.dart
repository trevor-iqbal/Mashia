import 'dart:convert';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mashia/utility/utility.dart';

class CowPage extends StatefulWidget {
  @override
  _CowPageState createState() => _CowPageState();
}

class _CowPageState extends State<CowPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting;
  String  _tagId = '', _category = '', _breed = '', _gender = '', _color = '', _age = '', _jwtToken;

  Widget _showTagIdInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _tagId = val,
        validator: (val) => int.parse(val) > 999 || int.parse(val) < 0 ? 'Range must be between 0 and 999': null,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter Cow Tag here',
          hintText: 'Enter tag number',
          icon: Icon(Icons.bookmark, color: Colors.grey)   
        ),
          keyboardType: TextInputType.phone
      )  
    );
  }
  Widget _showcategoryInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: DropDownFormField(
        titleText: 'Category',
        hintText: 'Please choose one',
        value: _category,
        onSaved: (val){
          setState(() {
            _category = val;
          });
        },
        onChanged: (val){
          setState(() {
            _category = val;
          });
        },
        required: true,
        errorText: 'Select an option',
        dataSource: [
          {
            "display": "Calf",
            "value": "Calf"
          },
          {
            "display": "Pregnant",
            "value": "Pregnant"
          },
          {
            "display": "Inseminated",
            "value": "Inseminated"
          },
          {
            "display": "Adult",
            "value": "Adult"
          },
        ],
        textField: 'display',
        valueField: 'value'
      ) 
    );
  }
  Widget _showbreedInput(){
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: 
        DropDownFormField(
        titleText: 'Breed',
        hintText: 'Please choose one',
        value: _breed,
        onSaved: (val){
          setState(() {
            _breed = val;
          });
        },
        onChanged: (val){
          setState(() {
            _breed = val;
          });
        },
        required: true,
        errorText: 'Select an option',
        dataSource: [
          {
            "display": "Cholistani",
            "value": "Cholistani"
          },
          {
            "display": "Tharparker",
            "value": "Tharparker"
          },
          {
            "display": "Lohani",
            "value": "Lohani"
          },
          {
            "display": "Rojhan",
            "value": "Rojhan"
          },
          {
            "display": "Australian",
            "value": "Australian"
          },
          {
            "display": "Red Sindhi",
            "value": "Red Sindhi"
          }
        ],
        textField: 'display',
        valueField: 'value'
      )
    );
  }
  Widget _showGenderInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: DropDownFormField(
        titleText: 'Gender',
        hintText: 'Please choose one',
        value: _gender,
        onSaved: (val){
          setState(() {
            _gender = val;
          });
        },
        onChanged: (val){
          setState(() {
            _gender = val;
          });
        },
        required: true,
        errorText: 'Select an option',
        dataSource: [
          {
            "display": "male",
            "value": "male"
          },
          {
            "display": "female",
            "value": "female"
          }
        ],
        textField: 'display',
        valueField: 'value'
      )
    );
  }
  Widget _showColorInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _color = val,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Color',
            hintText: 'Enter cow color',
            icon: Icon(Icons.invert_colors, color: Colors.grey)),
            keyboardType: TextInputType.text));
  }
  Widget _showAgeInput() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        onSaved: (val) => _age = val,
        validator: (val) => int.parse(val) > 8 || int.parse(val) < 0 ? 'Range must be between 0.1 and 8.0': null,
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Age',
            hintText: 'Enter cow age',
            icon: Icon(Icons.invert_colors, color: Colors.grey)),
            keyboardType: TextInputType.phone));
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
    if (form.validate()) {
      form.save();
      _registerCow();
    }
  }

  void _registerCow() async {
    setState(() => _isSubmitting = true);
    _jwtToken = await jwtOrEmpty();
    print(_jwtToken);
    http.Response response = await http.put(
        '$SERVER_IP/api/farmowners/addDairyFarmCow',
        body: json.encode({
          "tag_id": "$_tagId",
          "reading": [],
          "category": "$_category",
          "breed": "$_breed",
          "gender": "$_gender",
          "color": "$_color",
          "age": "$_age"
        }),
        headers: <String,String>{
           'Content-Type': 'application/json',
           'x-auth-token': '$_jwtToken'
        });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      setState(() => _isSubmitting = false);
      _showSuccessSnack();
      _redirectUser();
    } else {
      setState(() => _isSubmitting = false);
      _showErrorSnack('Some error occured, try again.');
    }
  }
  
  void _showSuccessSnack() {
    final snackbar = SnackBar(
        content: Text('Cow $_tagId successfully created!',
            style: TextStyle(color: Colors.green)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
    _formKey.currentState.reset();
  }

  void _showErrorSnack(String errorMsg) {
    final snackbar =
        SnackBar(content: Text(errorMsg, style: TextStyle(color: Colors.red)));
    _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _redirectUser() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/farmprofile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Cow'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.close), onPressed: () async=>  Navigator.pushReplacementNamed(context, '/farmprofile'))
        ],
        ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(children: [
                      //_showTitle(),
                      _showcategoryInput(),
                      _showbreedInput(),
                      _showGenderInput(),
                      _showTagIdInput(),
                      _showAgeInput(),
                      _showColorInput(),
                      _showFormActions()
                    ]))))));
  }
}