import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:url_launcher/url_launcher.dart';

import 'commons/navigation_bloc.dart';

class About extends StatefulWidget with NavigationStates{
  @override
  _AboutState createState() => _AboutState();
}



class _AboutState extends State<About> {

  // ignore: missing_return
  Future<bool> _onBackPressed(){
    Navigator.pop(context , true);
  }
  _launchURL() async {
    const url = 'https://itsinthehole.golf/user_manual.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor: selectedColor,
        ),
        body: SingleChildScrollView(
          child: Container(
            //  color: Colors.black.withOpacity(0.8),
            padding: EdgeInsets.all(16.0),
            decoration: new BoxDecoration(

              gradient: new LinearGradient(
                  colors: [Colors.grey, Color(0xFFccd1d9)],
                  begin: const FractionalOffset(0.1, 0.0),
                  end: const FractionalOffset(0.6, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: new Padding(
                padding: const EdgeInsets.only(left: 30.0,top:30.0,right:30.0,bottom: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: _launchURL,
                      child: new RichText(
                        text: TextSpan(
                          text:"Its In The Hole is the complete game improvement app with users worldwide."
                              "Dedicated to offering golfers the most advanced shot accuracy,"
                              " GPS solutions, and score tracking at an affordable price, "
                              "Its In The Hole helps improve your performance on the golf course "
                              "Its In The Hole provides state of the art replacement for the hand held laser range finders, "
                              "now you don't have to carry the range finders with you on the golf course to check your yardage, "
                              "Its In The Hole provides a user friendly interface through which you can easily keep track of these things during the round. "
                              "We have introduced the handheld GPS to the golf industry and holds a U.S. patent for its unique GPS and club tracking application. "
                              "Its In The Hole is an easy-to-use application that provides precise GPS distances. In addition, Its In The Hole has stat tracking, "
                              "scorekeeping and much more."
                          ,style: TextStyle(fontSize: 25.0,color: Colors.black),
//                        children: <TextSpan>[
//
//                          TextSpan(
//                              text:"https://itsinthehole.golf/user_manual.html",
//                              style: TextStyle(
//                                  color: Colors.blueAccent, fontSize: 18),
//                              recognizer: TapGestureRecognizer()
////                           ..onTap = () {
////                             _launchURL;
////                           }
//                          )
//                        ]

                        ),
//                   "Its In The Hole is the complete game improvement app with users worldwide."
//                   "Dedicated to offering golfers the most advanced shot accuracy,"
//                  " GPS solutions, and score tracking at an affordable price, "
//                  "Its In The Hole helps improve your performance on the golf course "
//                  "Its In The Hole provides state of the art replacement for the hand held laser range finders, "
//                  "now you don't have to carry the range finders with you on the golf course to check your yardage, "
//                  "Its In The Hole provides a user friendly interface through which you can easily keep track of these things during the round. "
//                  "We have introduced the handheld GPS to the golf industry and holds a U.S. patent for its unique GPS and club tracking application. "
//                  "Its In The Hole is an easy-to-use application that provides precise GPS distances. In addition, Its In The Hole has stat tracking, "
//                  "scorekeeping and much more."
//                  "https://itsinthehole.golf/user_manual.html",
//                   style: TextStyle(fontSize: 25.0,color: Colors.black)
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        textColor: Colors.black,
                        child: Text('User Manual', style: TextStyle(fontSize: 15)),
                        onPressed:()=> _launchURL(),
                        color: selectedColor,
                      ),
                    )
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
}