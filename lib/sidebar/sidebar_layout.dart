import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/classes/savecurrentloc.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/views/SplashScreen.dart';
import 'sidebar.dart';


class SideBarLayout extends StatefulWidget {
  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {

  Future<bool> _onBackPressed(){
    Savecurrent save = new Savecurrent();
    if(save.bool1){
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: selectedColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text("You Are In Game Mode! \n Want To Exit"),
            actions: <Widget>[
              FlatButton(
                child: const Text('NO', style: TextStyle(color: Colors.white),),
                onPressed: () {

                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: const Text('YES', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  exit(0);
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        },
      ) ?? false;
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => SplashScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(

        body: BlocProvider<NavigationBloc>(
          create: (context) => NavigationBloc(),
          child: Stack(
            children: <Widget>[
              BlocBuilder<NavigationBloc, NavigationStates>(
                builder: (context, navigationState) {
                  return navigationState as Widget;
                },
              ),
              SideBar(),
            ],
          ),
        ),
      ),
    );
  }
}

