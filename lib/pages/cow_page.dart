import 'package:flutter/material.dart';

class CowInfo extends StatefulWidget {
  final  cowObject;
  const CowInfo({ Key key, @required this.cowObject }): super(key: key);

  @override
  _CowInfoState createState() => _CowInfoState();
}

class _CowInfoState extends State<CowInfo> { 
  @override
  Widget build(BuildContext context) {
    print(widget.cowObject.toString());
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children:<Widget> [
                  Container(
                    height: MediaQuery.of(context).size.height*0.3,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                        image: AssetImage('assets/${widget.cowObject['breed']}.png'),
                        fit: BoxFit.contain 
                      )
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.5,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                         Row(
                           children: <Widget>[
                             Padding(
                               padding: const EdgeInsets.fromLTRB(18,15,0,0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text('Tag Id:', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('Category:', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('Breed:', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('Gender:', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('Color:', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('Age:', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                 ]
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.fromLTRB(18,15,0,0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Text('${widget.cowObject['tag_id']}', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('${widget.cowObject['category']}', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('${widget.cowObject['breed']}', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('${widget.cowObject['gender']}', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('${widget.cowObject['color']}', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                   Text('${widget.cowObject['age']}', style: TextStyle(color: Colors.white, fontSize:22, fontWeight: FontWeight.w300)),
                                 ]
                               ),
                             )
                           ]
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(18,18,0,0),
                           child: Text('Previous Reading: ${widget.cowObject['reading'][1]['timestamp'].toString().substring(11,19)}', style: TextStyle(color: Colors.white, fontSize:24, fontWeight: FontWeight.w300)),
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(18,0,0,0),
                           child: Text('Rumination Time: ${widget.cowObject['reading'][1]['rumination']} minutes', style: TextStyle(color: Colors.white, fontSize:24, fontWeight: FontWeight.w300)),
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(18,0,0,0),
                           child: Text('Pulse Rate: ${widget.cowObject['reading'][1]['pulserate']} minutes', style: TextStyle(color: Colors.white, fontSize:24, fontWeight: FontWeight.w300)),
                         ),
                         Padding(
                           padding: const EdgeInsets.fromLTRB(18,0,0,0),
                           child: Text('Temperature: ${widget.cowObject['reading'][1]['temperature']} minutes', style: TextStyle(color: Colors.white, fontSize:24, fontWeight: FontWeight.w300)),
                         )
                      ],
                    ),
                  )
                ]
              )
            ),
          ),
        ),
    );
  }
}