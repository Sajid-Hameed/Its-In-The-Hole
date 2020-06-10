
import 'package:flutter/material.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/sidebar/sidebar.dart';
import 'package:its_in_the_hole/views/previouscorecard.dart';
import 'package:its_in_the_hole/views/showscore.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:its_in_the_hole/classes/showscoreclass.dart';

var firstColor = Color(0xFF000000), secondColor = Color(0xFF4fc1e9);
var thirdColor = Color(0xFFaab2bd), forthColor = Color(0xFFccd1d9);
var fifthColor = Color(0xFF6a50a7), sixthColor = Color(0xFF8067b7);
class PScoreback extends StatefulWidget  with NavigationStates{

  show _show;

  PScoreback(show _show){
    this._show = _show;
  }

  static var back = 0;
  static var total = 0;
  static var faback = 0;
  static var fatotal = 0;

  @override
  _PScorebackStates createState() => _PScorebackStates(_show);
}


class _PScorebackStates extends State<PScoreback> {

  show _show;

  _PScorebackStates(show _show){
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
                            text: "Front",
                            fontSize: 10,
                            gradientColors: [firstColor, Colors.grey],
                            onPressed: () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext context) => PScorecard(_show)));
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
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par10.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp10.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa10.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('11',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par11.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp11.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa11.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('12',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par12.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp12.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa12.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('13',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par13.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp13.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa13.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('14',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par14.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp14.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa14.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('15',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par15.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp15.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa15.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('16',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par16.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp16.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa16.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('17',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par17.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp17.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa17.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                          ]
                      ),
                      Row(
                          children: [
                            // new Expanded(child: new Text('', style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all(),
                                color: Colors.grey),width: 60,  child: new Text('18',textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.par18.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 60,  child: new Text(_show.hcp18.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

                            new Container(decoration: BoxDecoration(border: Border.all() , borderRadius: BorderRadius.circular(10.0),
                                color: Colors.white),width: 170, height: 34,  child: new Text(_show.fa18.toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.black,height: 2.0, fontSize: 15.2, fontWeight: FontWeight.bold,))),

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
                                color: Colors.black), child: new Text(_show.backpar.toString(), textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 60,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text('', textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
                            new Container(width: 170,decoration: BoxDecoration(border: Border.all(),
                                color: Colors.black), child: new Text(_show.backfa.toString().toString(),textAlign: TextAlign.center,style: new TextStyle(color: Colors.white, fontSize: 15.2, fontWeight: FontWeight.bold,))),
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
