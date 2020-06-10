import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:flutter/services.dart';
import 'package:its_in_the_hole/sidebar/sidebar.dart';
import 'package:its_in_the_hole/sidebar/sidebar_layout.dart';
import 'package:its_in_the_hole/views/scorecard.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:its_in_the_hole/classes/scoreclass.dart';
import '../currentloc.dart';


var firstColor = Color(0xFF000000), secondColor = Color(0xFF4fc1e9);
var thirdColor = Color(0xFFaab2bd), forthColor = Color(0xFFccd1d9);
var fifthColor = Color(0xFF6a50a7), sixthColor = Color(0xFF8067b7);
class Scoreback extends StatefulWidget  with NavigationStates{

  static var back = 0;
  static var total = 0;
  static var faback = 0;
  static var fatotal = 0;

  @override
  _ScorebackStates createState() => _ScorebackStates();
}


class _ScorebackStates extends State<Scoreback> {


  String name1 = SideBar.name1;

  getData(){
    setState(() {

    });
  }

  Future<bool> _onBackPressed(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SideBarLayout()));
  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: selectedColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text('Want To Save?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('NO', style: TextStyle(color: Colors.white),),
              onPressed: () {

                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('YES', style: TextStyle(color: Colors.white),),
              onPressed: () {
                saveScore();
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    );
  }

  saveScore() async{
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    DateTime now = DateTime.now();
    String formattedDatetosave = DateFormat('kk:mm:ss EEE d MMM').format(now);
    String formattedDate = DateFormat('EEE d MMM').format(now);

    Map<String, Object> createUser = new HashMap();
    createUser['date'] = formattedDate.toString();
    createUser['datedb'] = formattedDatetosave.toString();
    createUser['par1'] = score.par1.text;
    createUser['par2'] = score.par2.text;
    createUser['par3'] = score.par3.text;
    createUser['par4'] = score.par4.text;
    createUser['par5'] = score.par5.text;
    createUser['par6'] = score.par6.text;
    createUser['par7'] = score.par7.text;
    createUser['par8'] = score.par8.text;
    createUser['par9'] = score.par9.text;
    createUser['par10'] = score.par10.text;
    createUser['par11'] = score.par11.text;
    createUser['par12'] = score.par12.text;
    createUser['par13'] = score.par13.text;
    createUser['par14'] = score.par14.text;
    createUser['par15'] = score.par15.text;
    createUser['par16'] = score.par16.text;
    createUser['par17'] = score.par17.text;
    createUser['par18'] = score.par18.text;

    createUser['hcp1'] = score.hcp1.text;
    createUser['hcp2'] = score.hcp2.text;
    createUser['hcp3'] = score.hcp3.text;
    createUser['hcp4'] = score.hcp4.text;
    createUser['hcp5'] = score.hcp5.text;
    createUser['hcp6'] = score.hcp6.text;
    createUser['hcp7'] = score.hcp7.text;
    createUser['hcp8'] = score.hcp8.text;
    createUser['hcp9'] = score.hcp9.text;
    createUser['hcp10'] = score.hcp10.text;
    createUser['hcp11'] = score.hcp11.text;
    createUser['hcp12'] = score.hcp12.text;
    createUser['hcp13'] = score.hcp13.text;
    createUser['hcp14'] = score.hcp14.text;
    createUser['hcp15'] = score.hcp15.text;
    createUser['hcp16'] = score.hcp16.text;
    createUser['hcp17'] = score.hcp17.text;
    createUser['hcp18'] = score.hcp18.text;

    createUser['fa1'] = score.fa1.text;
    createUser['fa2'] = score.fa2.text;
    createUser['fa3'] = score.fa3.text;
    createUser['fa4'] = score.fa4.text;
    createUser['fa5'] = score.fa5.text;
    createUser['fa6'] = score.fa6.text;
    createUser['fa7'] = score.fa7.text;
    createUser['fa8'] = score.fa8.text;
    createUser['fa9'] = score.fa9.text;
    createUser['fa10'] = score.fa10.text;
    createUser['fa11'] = score.fa11.text;
    createUser['fa12'] = score.fa12.text;
    createUser['fa13'] = score.fa13.text;
    createUser['fa14'] = score.fa14.text;
    createUser['fa15'] = score.fa15.text;
    createUser['fa16'] = score.fa16.text;
    createUser['fa17'] = score.fa17.text;
    createUser['fa18'] = score.fa18.text;

    createUser['backpartotal'] = Scoreback.back.toString();
    createUser['fronparttotal'] = Scorecard.front.toString();
    createUser['backfatotal'] = Scoreback.faback.toString();
    createUser['frontfatotal'] = Scorecard.fafront.toString();
    createUser['fatotal'] = Scorecard.fatotal.toString();
    createUser['partotal'] = Scorecard.total.toString();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SideBarLayout()));

    return FirebaseDatabase.instance
        .reference()
        .child("Score")
        .child(user.uid)
        .child(formattedDatetosave.toString())
        .set(createUser);

  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: _onBackPressed,
        child: new Scaffold(
        appBar: AppBar(
          title: Text("Score Board"),
          backgroundColor: selectedColor,
        ),
       body: SingleChildScrollView(
            child:Container(
                color: Colors.white,
                padding: EdgeInsets.only(left:5.0 ,top:0.0 ,right:5.0 ,bottom: 0.0),
                child: Column(

                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left:10.0 ,top:0.0 ,right:0.0 ,bottom: 0.0),
                      child: Row(children: <Widget>[

                        NiceButton(
                          width: 65,
                          elevation: 8.0,
                          radius: 40,
                          padding: const EdgeInsets.all(7.0),
                          text: "Front",
                          fontSize: 10,
                          gradientColors: [firstColor, Colors.grey],
                          onPressed: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => Scorecard()));
                          },
                        ),


                        NiceButton(
                          width: 65,
                          elevation: 8.0,
                          radius: 40,
                          padding: const EdgeInsets.all(5.0),
                          text: "Save",
                          fontSize: 10,
                          gradientColors: [firstColor, Colors.grey],
                          onPressed: () {
                            _asyncConfirmDialog(context);
                          },
                        ),


                      ],),
                    ),

                    Container(
                      height: 30,
                      child: Row(

                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60, decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('Hole', textAlign: TextAlign.center, style: new TextStyle(color: Colors.white, fontSize: 15.2,fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('Par', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('HCP', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 170,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text(name1.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                    ),
                    Row(

                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('10',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par10,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp10,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa10,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('11',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par11,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp11,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa11,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('12',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par12,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp12,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa12,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('13',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par13,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp13,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa13,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('14',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par14,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp14,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa14,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('15',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par15,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp15,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa15,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('16',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par16,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp16,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa16,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('17',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par17,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp17,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa17,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(
                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(decoration: BoxDecoration(border: Border.all(),
                              color: Colors.grey),width: 60,  child: new Text('18',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.par18,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,height: 34,
                              child: new TextFormField(
                                  controller: score.hcp18,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,height: 34,
                              child: new TextFormField(
                                  controller: score.fa18,
                                  onChanged: (text) => {score.show(), getData()},
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                                  ),
                                  style: new TextStyle(color: Colors.black, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),

                    //  padding: EdgeInsets.only(left:0.0 ,top:5.0 ,right:0.0 ,bottom: 0.0),
                    Row(

                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60, decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text('Back',  style: new TextStyle(color: Colors.white, fontSize: 15.2,fontWeight: FontWeight.bold,))),
                          new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text(Scoreback.back.toString(), textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text('', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text(Scoreback.faback.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                    Row(

                        children: [
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60, decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text('Total',  style: new TextStyle(color: Colors.white, fontSize: 15.2,fontWeight: FontWeight.bold,))),
                          new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text(Scoreback.total.toString(), textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text('', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          new Container(width: 170,decoration: BoxDecoration(border: Border.all(),
                              color: Colors.black), child: new Text(Scoreback.fatotal.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                        ]
                    ),
                  ],
                )
            )
        )
        ),
    );
  }
}
