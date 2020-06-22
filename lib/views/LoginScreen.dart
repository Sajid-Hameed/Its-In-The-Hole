import 'dart:collection';
import 'dart:io';
import 'package:apple_sign_in/apple_sign_in_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/sidebar/sidebar_layout.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:apple_sign_in/apple_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var divWidth;
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  BitmapDescriptor google;

  @override
  void initState() {
    super.initState();
    setSourceAndDestinationIcons();
    if(Platform.isIOS){                                                      //check for ios if developing for both android & ios
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }
  void setSourceAndDestinationIcons() async {
    google = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/google.png');
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(

        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/gold.png"),
                colorFilter: new ColorFilter.mode(selectedColor.withOpacity(0.9), BlendMode.dstATop),
                fit: BoxFit.cover,

              ),
            ),
          ),
          Column (
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:EdgeInsets.only(top:90.0),
                    ),
                    CircleAvatar(
                      backgroundColor: selectedColor,
                      radius: 150.0,
                      backgroundImage: AssetImage('assets/log.jpeg'),
                    ),
                    Padding(
                      padding:EdgeInsets.only(top:10.0),
                    ),
                    Text(
                      "Its In The Hole",style:TextStyle(color : Colors.white,fontSize: 24.0,fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding:EdgeInsets.only(bottom:60.0),
                    ),
                  ] ,
                ),
              ),
              NiceButton(
                background: selectedColor,
                width: 245,
                elevation: 8.0,
                radius: 40,
                padding: const EdgeInsets.all(8.0),
                text: "Google",
                icon: Icons.email,
                gradientColors: [selectedColor, selectedColor],
                  onPressed: () {
                    signInWithGoogle().whenComplete(() {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return SideBarLayout();
                          },
                        ),
                      );
                    });
                  }
              ),
              Padding(
                padding:EdgeInsets.only(bottom: 60.0),
              ),
              AppleSignInButton(
                onPressed: () async {
                  await appleLogIn();
                },
                style: ButtonStyle.black,
              )
            ],
          )
        ],
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  appleLogIn() async{
    if(await AppleSignIn.isAvailable()) {
      final AuthorizationResult result = await
      AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      switch (result.status) {
        case AuthorizationStatus.authorized:
          try {
            print("successfull sign in");
            final AppleIdCredential appleIdCredential = result.credential;

            OAuthProvider oAuthProvider =
            new OAuthProvider(providerId: "apple.com");
            final AuthCredential credential = oAuthProvider.getCredential(
              idToken:
              String.fromCharCodes(appleIdCredential.identityToken),
              accessToken:
              String.fromCharCodes(appleIdCredential.authorizationCode),
            );

            final AuthResult _res = await FirebaseAuth.instance
                .signInWithCredential(credential);

            firebaseQueryapple(appleIdCredential);

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => SideBarLayout()));


            FirebaseAuth.instance.currentUser().then((val) async {
              UserUpdateInfo updateUser = UserUpdateInfo();
              updateUser.displayName =
              "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
              updateUser.photoUrl =
              "define an url";
              await val.updateProfile(updateUser);
            });

          } catch (e) {
            print(e.toString());
          }
          break;
        case AuthorizationStatus.error:
          print("Sign in failed: ${result.error.localizedDescription}");
          break;
        case AuthorizationStatus.cancelled:
          print('User cancelled');
          break;
      }
    }else{
    print('Apple SignIn is not available for your device');
    }

  }

  firebaseQueryapple(AppleIdCredential appleIdCredential) async{

    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Map<String, Object> createUser = new HashMap();
    createUser['ID'] = user.uid.toString();
    createUser['Name'] = "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
    createUser['Email'] = user.email.toString();
    createUser['Picture'] = user.photoUrl.toString();

    return FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid)
        .set(createUser);

  }

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,

    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();

    assert(user.uid == currentUser.uid);
    if(currentUser != null)
      {
        _loginButtonTapped();
      }

    firebaseQuery();

    return 'signInWithGoogle succeeded: $user';


  }
  firebaseQuery() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    Map<String, Object> createUser = new HashMap();
    createUser['ID'] = user.uid.toString();
    createUser['Name'] = user.displayName.toString();
    createUser['Email'] = user.email.toString();
    createUser['Picture'] = user.photoUrl.toString();

    return FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid)
        .set(createUser);
  }

  _loginButtonTapped() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SideBarLayout()));
  }


}
