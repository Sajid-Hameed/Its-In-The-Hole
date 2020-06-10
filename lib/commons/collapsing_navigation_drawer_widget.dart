/*

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_in_the_hole/models/navigation_model.dart';
import 'package:its_in_the_hole/views/LoginScreen.dart';
import 'package:its_in_the_hole/views/ProfileScreen.dart';
import 'package:its_in_the_hole/views/SettingsScreen.dart';
import 'package:its_in_the_hole/views/SplashScreen.dart';
import 'package:its_in_the_hole/views/placedetail_screens.dart';
import 'package:its_in_the_hole/views/places_screens.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../theme.dart';
import 'collapsing_list_tile_widget.dart';


class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 200;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;
  static String name, name1;
  static String email;
  static String imageUrl;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
    signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<String> signInWithGoogle() async {
//    final AuthResult authResult = await _auth.signInWithCredential(credential);
//    final FirebaseUser user = authResult.user;






    final FirebaseUser currentUser = await _auth.currentUser();
    //final uid = user.uid;
    assert(currentUser.uid == currentUser.uid);
    assert( currentUser.email != null);
    assert( currentUser.displayName != null);
    assert( currentUser.photoUrl != null);
    name = currentUser.displayName;
    email = currentUser.email;
    imageUrl = currentUser.photoUrl;
//    IconData
    if (name.contains(" ")) {
      name1 = name.substring(0, name.indexOf(" "));
    }
    return ': $currentUser';


  }

  Widget getWidget(context, widget) {
    return Scaffold(

      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,

      body: Material(
     //   width: widthAnimation.value,
        color: drawerBackgroundColor,

        child: Column(


          children: <Widget>[

            new UserAccountsDrawerHeader(
              accountEmail: new Text(email),
              accountName: new Text(name),
              currentAccountPicture: new GestureDetector(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(imageUrl!=null?imageUrl:"https://isaca-gwdc.org/wp-content/uploads/2016/12/male-profile-image-placeholder.png"),
                ),
              ),

            ),
            Divider(color: Colors.grey, height: 50.0,),

            Expanded(
           //   flex: 200,
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(height: 12.0);
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                      onTap: () {
                        setState(() {                         currentSelectedIndex = counter;
                          if(navigationItems[counter].title=="Logout"){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) => SplashScreen()));
                          }
                          if(navigationItems[counter].title=="Profile"){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => ProfileScreen()));
                          }
                          if(navigationItems[counter].title=="Settings"){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => SettingsScreen()));
                          }
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                      title: navigationItems[counter].title,
                      icon: navigationItems[counter].icon,
                      image:null,
                      animationController: _animationController,
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
//            InkWell(
//              onTap: () {
//                setState(() {
//                  isCollapsed = !isCollapsed;
//                  isCollapsed
//                      ? _animationController.forward()
//                      : _animationController.reverse();
//                });
//              },
//              child: AnimatedIcon(
//                icon: AnimatedIcons.close_menu,
//                progress: _animationController,
//                color: selectedColor,
//                size: 50.0,
//              ),
//            ),
          ],
        ),
      ),
    );
  }

  void signOutGoogle() async{
    await googleSignIn.signOut();

    print("User Sign Out");
  }
}
*/
