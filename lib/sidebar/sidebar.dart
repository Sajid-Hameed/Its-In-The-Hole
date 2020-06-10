import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/views/SplashScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import '../appstate.dart';
import '../sidebar/menu_item.dart';

class SideBar extends StatefulWidget {

  static String name1;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  static String name;
  static String email;
  static String imageUrl;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    getData();
  }

  getData() async {
    user = await FirebaseAuth.instance.currentUser();

    var db = FirebaseDatabase.instance.reference().child("Users").child(user.uid);
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      email = values["Email"];
      SideBar.name1 = values['Name'];
      imageUrl = values['Picture'];
      if(mounted) {
        setState(() {

        });
      }
    });
  }
  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {

    final FirebaseUser currentUser = await _auth.currentUser();
    //final uid = user.uid;
    assert(currentUser.uid == currentUser.uid);
    assert( currentUser.email != null);
    assert( currentUser.displayName != null);
    assert( currentUser.photoUrl != null);
    name = currentUser.displayName;
    email = currentUser.email;
    user = await FirebaseAuth.instance.currentUser();

    var db = FirebaseDatabase.instance.reference().child("Users").child(user.uid);
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      imageUrl = values['Picture'];
    });

    if (name.contains(" ")) {
      SideBar.name1 = name.substring(0, name.indexOf(" "));
    }
    return ': $currentUser';


  }
  void signOutGoogle() async{

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 35,
          child: Row(

            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: selectedColor,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 150,

                        ),
                        ListTile(
                          title: Text(
                            SideBar.name1!=null?SideBar.name1:'Person',
                            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w800),
                          ),
                          subtitle: Text(
                            email!=null?email:'Email',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          leading: CircleAvatar(
//
                            radius: 30.0,
                            backgroundImage:new NetworkImage(imageUrl!=null?imageUrl:"https://isaca-gwdc.org/wp-content/uploads/2016/12/male-profile-image-placeholder.png"),
                          ),
                        ),
                        Divider(
                          height: 100,
                          thickness: 2,
                          color: Colors.white.withOpacity(0.5),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.home,
                          title: "Dashboard",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.HomePageClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.golf_course,
                          title: "Nearby Golf Courses",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.Nearby);
                          },
                        ),
                        MenuItem(
                          icon: Icons.person,
                          title: "Profile",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyProfileClickEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.shopping_basket,
                          title: "About",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MyAboutClickedEvent);
                          },
                        ),
                        Divider(
                          height:84,
                          thickness: 2,
                          color: Colors.white.withOpacity(0.5),
                          indent: 32,
                          endIndent: 32,
                        ),
                        MenuItem(
                          icon: Icons.settings,
                          title: "Settings",
                          onTap: () {
                            onIconPressed();
                            BlocProvider.of<NavigationBloc>(context).add(NavigationEvents.MySettingClickedEvent);
                          },
                        ),
                        MenuItem(
                          icon: Icons.exit_to_app,
                          title: "Logout",
                          onTap: () {
                            onIconPressed();
                            signOutGoogle();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => SplashScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.4),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: selectedColor1,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: selectedColor,
                        //  color: Color(0xFFaab2b),
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}