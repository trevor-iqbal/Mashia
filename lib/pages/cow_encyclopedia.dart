import 'dart:convert';

import 'package:flutter/material.dart';

class Encyclopedia extends StatefulWidget {
  @override
  _EncyclopediaState createState() => _EncyclopediaState();
}

class _EncyclopediaState extends State<Encyclopedia> {
  //final List<int> numbers = [1, 2, 3, 5, 8, 13, 21, 34, 55];
  Future<Map> getInfo() async{
    String data = await DefaultAssetBundle.of(context).loadString("assets/info.json");
    return json.decode(data);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encyclopedia'),
        leading: IconButton(
                    icon: Icon(Icons.arrow_back), 
                    onPressed: (){Navigator.pushReplacementNamed(context, '/farmprofile');}
                ),
        centerTitle: true
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        height: MediaQuery.of(context).size.height * 0.95,
        child: FutureBuilder<Map>(
          future: getInfo(),
          builder: (context, snapshot){
            var info = snapshot.data['info'];
            if(snapshot.hasData){
            return Center(
              child: ListView.builder(
                itemCount: info.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int position){
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Card(
                      elevation: 7.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset('assets/${info[position]['image']}'),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12,0,0,0),
                            child: Text('''Breed: ${info[position]['breed']}\nType: ${info[position]['type']}\nAreas of Concentration: ${info[position]['areas']}\nWeight: ${info[position]['weight']}\nMilk Yeild: ${info[position]['milk yeild']} days\nLactation: ${info[position]['lactation']} days''', style: TextStyle(fontSize:18)),
                          ),
                         // Text('Type: ${info[position]['type']}'),
                         // Text('Areas of Concentration: ${info[position]['areas']}'),
                          //Text('Weight: ${info[position]['weight']}'),
                         // Text('Milk Yeild: ${info[position]['breed']} days'),
                          // Text('Lactation: ${info[position]['lactation']} days')
                        ]
                      ) 
                    )
                  );
                }),
            );}
            else{
              return Text('Loading..');
            }
          })
        // child: ListView.builder(
        //   scrollDirection: Axis.horizontal,
        //     itemCount: numbers.length,
        //     itemBuilder: (context, index) {
        //       return Container(
        //         width: MediaQuery.of(context).size.width * 0.8,
        //         child: Card(
        //           elevation: 7.0,
        //           color: Theme.of(context).cardColor,
        //           child: Container(
        //             child: Center(
        //               child: Text(
        //                 numbers[index].toString(), 
        //                 style: TextStyle(color: Colors.white, fontSize: 36.0)
        //               )
        //             )
        //             )
        //           )
        //         );
        //       })
      ),
    );
  }
}