import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:its_in_the_hole/Animations/FadeAnimation.dart';
import 'package:its_in_the_hole/classes/savecurrentloc.dart';
import 'package:its_in_the_hole/sidebar/sidebar_layout.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../appstate.dart';
import 'LoginScreen.dart';
import 'package:apple_sign_in/apple_sign_in.dart';


class SplashScreen extends StatefulWidget
{
  static Position position;
  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin
{

  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;
  bool hideIcon = false;
  FirebaseUser user;

  @override
  void initState() {
    getuser();
    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0, end: 0.8
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _widthController.forward();
      }
    });

    _widthController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600)
    );

    _widthAnimation = Tween<double>(
        begin: 80.0,
        end: 300.0
    ).animate(_widthController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _positionController.forward();
      }
    });

    _positionController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );

    _positionAnimation = Tween<double>(
        begin: 0.0,
        end: 215.0
    ).animate(_positionController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
           hideIcon = true;
        });
        _scale2Controller.forward();
      }
    });

    _scale2Controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    );

    _scale2Animation = Tween<double>(
        begin: 1.0,
        end: 32.0
    ).animate(_scale2Controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {

        if(user != null){
          // wrong call in wrong place!
          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: SideBarLayout()));
        }
        else if(user == null){
          Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LoginScreen()));
        }
      }
    });
  }

  getuser() async{

    SplashScreen.position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Savecurrent save = new Savecurrent();
    save.current = new LatLng(SplashScreen.position.latitude, SplashScreen.position.longitude);
    save.center = new LatLng(SplashScreen.position.latitude, SplashScreen.position.longitude);
    save.center1 = new LatLng(SplashScreen.position.latitude +0.0006, SplashScreen.position.longitude);
    save.currentr = new LatLng(SplashScreen.position.latitude, SplashScreen.position.longitude);
    save.centerr= new LatLng(SplashScreen.position.latitude, SplashScreen.position.longitude);
    save.center1r = new LatLng(SplashScreen.position.latitude +0.0006, SplashScreen.position.longitude);
    save.bool1 = false;
    save.text = "Go To The First Hole!";

    final FirebaseAuth _auth = FirebaseAuth.instance;

    //final AuthResult authResult = await _auth.signInWithCredential(credential);
    //user = authResult.user;
    user = await _auth.currentUser();
  }

  Future<bool> _onBack(){
    exit(0);
  }

  @override
  Widget build(BuildContext context)
  {
    return WillPopScope(
      onWillPop: _onBack,
    child: Scaffold(
      backgroundColor: selectedColor,
    body: Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage("assets/gold.png"),
          colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstATop),
          fit: BoxFit.cover,

        ),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(1, Text("Welcome",
                  style: TextStyle(color: Colors.white, fontSize: 50),)),
                SizedBox(height: 15,),
                FadeAnimation(1.3, Text("Its In The Hole.",
                  style: TextStyle(color: Colors.white.withOpacity(.80), height: 1.4, fontSize: 25),)),
                SizedBox(height: 180,),
                FadeAnimation(1.6, AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) => Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _widthController,
                          builder: (context, child) => Container(
                            width: _widthAnimation.value,
                            height: 80,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: selectedColor1.withOpacity(.4)
                            ),
                            child: InkWell(
                              onTap: () {
                                _scaleController.forward();
                              },
                              child: Stack(
                                  children: <Widget> [
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) => Transform.scale(
                                              scale: _scale2Animation.value,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: selectedColor
                                                ),
                                                child:  hideIcon == false ? Icon(Icons.golf_course, color: Colors.white,) : Container(),
                                              )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      )),
                )),
                SizedBox(height: 60,),
              ],
            ),
          )
        ],
      ),
    ),
    ),
  );
  }

}












