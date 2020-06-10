import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_in_the_hole/classes/showscoreclass.dart';
import 'package:its_in_the_hole/views/previouscorecard.dart';
import 'package:its_in_the_hole/views/scorecard.dart';

import '../appstate.dart';

class ShowScore extends StatefulWidget {
  @override
  _ShowScoreState createState() => _ShowScoreState();
}

class _ShowScoreState extends State<ShowScore> {
  static var scorecard = <show>[];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async{



      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      var db = FirebaseDatabase.instance.reference().child("Score").child(user.uid);
      db.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
        scorecard.clear();
        values.forEach((key,values) {

          setState(() {
            scorecard.add(new show(values["par1"].toString(), values["par2"].toString(), values["par3"].toString(), values["par4"].toString(),  values["par5"].toString(), values["par6"].toString(),
                values["par7"].toString(), values["par8"].toString(), values["par9"].toString(), values["par10"].toString(), values["par11"].toString(), values["par12"].toString(), values["par13"].toString(),
                values["par14"].toString(), values["par15"].toString(), values["par16"].toString(), values["par17"].toString(), values["par18"].toString(),
                values["hcp1"].toString(), values["hcp2"].toString(), values["hcp3"].toString(), values["hcp4"].toString(), values["hcp5"].toString(), values["hcp6"].toString(), values["hcp7"].toString(),
                values["hcp8"].toString(), values["hcp9"].toString(), values["hcp10"].toString(), values["hcp11"].toString(),
                values["hcp12"].toString(), values["hcp13"].toString(), values["hcp14"].toString(), values["hcp15"].toString(), values["hcp16"].toString(), values["hcp17"].toString(),
                values["hcp18"].toString(),
                values["fa1"].toString(), values["fa2"].toString(), values["fa3"].toString(), values["fa4"].toString(), values["fa5"].toString(), values["fa6"].toString(), values["fa7"].toString(),
                values["fa8"].toString(), values["fa9"].toString(), values["fa10"].toString(), values["fa11"].toString(), values["fa12"].toString(),
                values["fa13"].toString(), values["fa14"].toString(), values["fa15"].toString(), values["fa16"].toString(), values["fa17"].toString(), values["fa18"].toString(),
                values["backpartotal"].toString() , values["fronparttotal"].toString() , values["backfatotal"].toString() , values["frontfatotal"].toString() , values["partotal"].toString(),
                values["fatotal"].toString() , values["date"].toString() , values["datedb"].toString()));
          });
        });
      });
  }


  Future<bool> _onBackPressed(){

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => Scorecard()));

  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text("Previous"),
          backgroundColor: selectedColor,
        ),
      body: Container(

        child: Center(
          child: _createContent(),
        ),
      ),
      ),
    );
  }

  Widget _createContent() {
    if (scorecard.length == 0) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView(
        children: scorecard.map((f) {
//    Card(
//      child: TextField(
//
//      ),
//    );
          return new Card(
              child: ListTile(
                  title: new Text(f.datedb),
//                  trailing: new Column(
//                    children: <Widget>[
//                      new Icon(Icons.star_border, color: Colors.yellow,),
//                      new Text("sf")
//                    ],
//                  ),
                  onTap: () {
                    handleTap(f);
                  }
              )
          );
        }).toList(),
      );
    }
  }

  handleTap(show score) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => PScorecard(score)));
  }


}
