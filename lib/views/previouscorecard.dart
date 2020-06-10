
import 'package:flutter/material.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/sidebar/sidebar.dart';
import 'package:its_in_the_hole/views/previousbackscorecard.dart';
import 'package:its_in_the_hole/views/showscore.dart';
import 'package:nice_button/NiceButton.dart';
import 'dart:async';
import 'package:its_in_the_hole/classes/showscoreclass.dart';

import '../rotation.dart';
var firstColor = Color(0xFF000000), secondColor = Color(0xFF4fc1e9);
var thirdColor = Color(0xFFaab2bd), forthColor = Color(0xFFccd1d9);
var fifthColor = Color(0xFF6a50a7), sixthColor = Color(0xFF8067b7);
class PScorecard extends StatefulWidget  with NavigationStates{

  show _show;

  PScorecard(show _show){
    this._show = _show;
  }

  @override
  _PScorecardState createState() => _PScorecardState(_show);
}


class _PScorecardState extends State<PScorecard> with PortraitStatefulModeMixin<PScorecard>{

  show _show;
  _PScorecardState(show _show){
    this._show = _show;
  }
  String name1 = SideBar.name1;

  getData(){
    setState(() {

    });
  }

  Future<bool> _onBackPressed(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => ShowScore()));
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(

          appBar: AppBar(
            title: Text("Score Board"),
            backgroundColor: selectedColor,
          ),
          body: Center(
              child:Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left:30.0 ,top:20.0 ,right:0.0 ,bottom: 0.0),
                  child: Column(

                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left:220.0 ,top:0.0 ,right:0.0 ,bottom: 0.0),
                        child: Row(children: <Widget>[

                          NiceButton(
                            width: 65,
                            elevation: 8.0,
                            radius: 40,
                            padding: const EdgeInsets.all(7.0),
                            text: "Back",
                            fontSize: 10,
                            gradientColors: [firstColor, Colors.grey],
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => PScoreback(_show)));
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
                                color: Colors.grey),width: 60,  child: new Text('1',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par1.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp1.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa1.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]

                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('3',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par2.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp2.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa2.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('3',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par3.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp3.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa3.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('4',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par4.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp4.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa4.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('5',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par5.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp5.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa5.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('6',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par6.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp6.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa6.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('7',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par7.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp7.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa7.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('8',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par8.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp8.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa8.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('9',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par9.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp9.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa9.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),

                      //  padding: EdgeInsets.only(left:0.0 ,top:5.0 ,right:0.0 ,bottom: 0.0),
                      Row(

                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60, decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('Front',  style: new TextStyle(color: Colors.white, fontSize: 15.2,fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text(_show.frontpar.toString(), textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 170,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text(_show.frontfa.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(

                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60, decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('Total',  style: new TextStyle(color: Colors.white, fontSize: 15.2,fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text(_show.partotal.toString(), textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 170,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text(_show.fatotal.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
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
