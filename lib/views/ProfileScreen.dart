import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/sidebar/sidebar.dart';
import 'package:its_in_the_hole/sidebar/sidebar_layout.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:its_in_the_hole/views/SplashScreen.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../appstate.dart';

class ProfileScreen extends StatefulWidget with NavigationStates{
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _oldPasswordTextController =
  new TextEditingController();
  final TextEditingController _newPasswordTextController =
  new TextEditingController();
  final TextEditingController _confirmPasswordTextController =
  new TextEditingController();
  GlobalKey<FormState> _formKey1 = new GlobalKey<FormState>();
  GlobalKey<FormState> _formKey2 = new GlobalKey<FormState>();
  String version = "";
  String buildNumber = "";
  bool isResetPassword = false;
  bool _form1Autovalidate = false;
  bool _form2Autovalidate = false;
  bool _isFacebookUser = false;
  bool _isUploading = false;
  String _currentPassword;
  bool _isProfileEdited = false;
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  static String name, name1;
  static String email;
  final nameT = TextEditingController();
  final emailT = TextEditingController();
  ImageSource source;
  static String ID;
  static String imageUrl;
  Position position;
  FirebaseUser user;
  Future<File> imageFile;
  ProgressDialog pr;



  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }
  var image;

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          image = snapshot.data;
          return Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(
                  left: 115.0, bottom: 50.0),

              child: new CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: FileImage(snapshot.data),//new NetworkImage(imageUrl!=null?imageUrl:"https://isaca-gwdc.org/wp-content/uploads/2016/12/male-profile-image-placeholder.png"),
                radius: 70.0,
                child: IconButton(
                  padding: EdgeInsets.only(
                      left: 115.0, top: 50.0),
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 25.0,
                  color: Colors.blueGrey,

                  onPressed: () =>
                      pickImageFromGallery(ImageSource.gallery),

                ),
              ),
            ),
          );
        }
        else {
          return Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(
                  left: 145.0, bottom: 50.0),

              child: new CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: new NetworkImage(imageUrl!=null?imageUrl:"https://isaca-gwdc.org/wp-content/uploads/2016/12/male-profile-image-placeholder.png"),
                radius: 70.0,
                child: IconButton(
                  padding: EdgeInsets.only(
                      left: 115.0, top: 50.0),
                  icon: Icon(Icons.add_a_photo),
                  iconSize: 25.0,
                  color: Colors.blueGrey,

                  onPressed: () =>
                      pickImageFromGallery(ImageSource.gallery),

                ),
              ),
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
    progress();
  }


  final GoogleSignIn googleSignIn = GoogleSignIn();

  getData() async {
    user = await FirebaseAuth.instance.currentUser();

    var db = FirebaseDatabase.instance.reference().child("Users").child(user.uid);
    db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;
      email = values["Email"];
      ID = values["ID"];
      name = values['Name'];
      imageUrl = values['Picture'];
      if(mounted) {
        setState(() {

        });
      }
    });
  }

  progress(){
    pr = new ProgressDialog(context);
    pr = new ProgressDialog(context,type: ProgressDialogType.Download, isDismissible: false, showLogs: true);
    pr.style(
        message: 'Update profile...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
  }


  updateData() async{
    await pr.show();
    pr.update(
      progress: 50.0,
      message: "Please wait...",
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

    Map<String, Object> updateData = new HashMap();

    if(imageFile!= null) {
      final StorageReference storageReference = FirebaseStorage.instance.ref()
          .child(user.uid);
      StorageUploadTask uploadTask = storageReference.putFile(image);
      uploadTask.onComplete.then((s) {
        s.ref.getDownloadURL();
        storageReference.getDownloadURL().then((fileURL) {
          setState(() {
            print(fileURL.toString());
            updateData['Picture'] = fileURL.toString();

            updateData['ID'] = user.uid.toString();
            if(nameT.text != "") {
              updateData['Name'] = nameT.text.toString();
              SideBar.name1 = nameT.text.toString();
            }else{
              updateData['Name'] = name.toString();
              SideBar.name1 = name.toString();
            }
            updateData['Email'] = user.email.toString();

            FirebaseDatabase.instance
                .reference()
                .child("Users")
                .child(user.uid)
                .set(updateData);


            pr.hide().then((isHidden) {
              print(isHidden);
            });

            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => SideBarLayout()));

            //getData();
          });
        });
      });
    }
    else{
      updateData['Picture'] = imageUrl;
      updateData['ID'] = user.uid.toString();
      if(nameT.text != "") {
        updateData['Name'] = nameT.text.toString();
        SideBar.name1 = nameT.text.toString();
      }else{
        updateData['Name'] = name.toString();
        SideBar.name1 = name.toString();
      }
      updateData['Email'] = user.email.toString();

      FirebaseDatabase.instance
          .reference()
          .child("Users")
          .child(user.uid)
          .set(updateData);


      pr.hide().then((isHidden) {
        print(isHidden);
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => SideBarLayout()));
    }

  }


  Future<bool> _onBackPressed(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SideBarLayout()));
  }

  void signOutGoogle() async{
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    await googleSignIn.signOut();
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => SplashScreen()));
    print("User Sign Out");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
    child: Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: SafeArea(
            top: true,
            child: Center(
              child: Column(
                children: <Widget>[
                  ClipPath(
                    child: Container(color: Colors.black.withOpacity(0.8)),
                    clipper: getClipper(),
                  ),
                  new Container(
                    height: 250.0,
                    decoration: new BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [Colors.grey, Color(0xFFccd1d9)],
                          begin: const FractionalOffset(0.1, 0.0),
                          end: const FractionalOffset(0.6, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    child: Stack(
                      children: <Widget>[
                        ClipPath(
                          child: Container(color: Colors.black.withOpacity(0.8)),
                          clipper: getClipper(),
                        ),
                        showImage(),
                        Align(
                          alignment: Alignment.topRight,
                          child: FlatButton(
                              child: Text(
                                "Sign out",
                                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
                              ),
                              onPressed: () => signOutGoogle()),
                        ),
                        showImage(),
                      ],
                    ),
                  ),
                  new Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 5.0,
                    child: _profileItems(),
                  ),
                  _isFacebookUser
                      ? new Container()
                      : Container(
                    margin: EdgeInsets.only(right: kMarginPadding),
                    child: Align(
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  isResetPassword
                      ? new Card(
                    margin: EdgeInsets.all(10.0),
                    elevation: 5.0,
                    //color: Constants.lg_gray_light,
                    child: _passwordRestCard(),
                  )
                      : new Container(),
                  _bottomCard()
                ],
              ),
            )),
      ),
    ),
    );
  }

  Widget _profileItems() {
    return Form(

        key: _formKey1,
        autovalidate: _form1Autovalidate,
        child: Column(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            new Container(
              //width: 130.0,
              height: 105.0,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipPath(
                    child: Container(color: Colors.black.withOpacity(0.8)),
                    clipper: getClipper(),
                  ),
                  new Expanded(
                    child: LGTitleTextFormField(
                      padding: EdgeInsets.all(kMarginPadding),
                      title: 'Name',
                      hintText: name!=null?name:'Person',
                      emptyValidator: true,
                      emptyValidatorMsg: "Enter Name",
                      controller: nameT,
                      onEditingComplete: _onEditingComplete,
                    ),
                  ),
                ],
              ),
            ),
            LGTitleTextFormField(
              padding:
              EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
              title: "Email",
              hintText:email!=null?email:'Email',
              controller: emailT,
              onEditingComplete: _onEditingComplete,
              disable: true,
            ),
          ],
        ));
  }

  Widget _passwordRestCard() {
    return Form(
        key: _formKey2,
        autovalidate: _form2Autovalidate,
        child: Column(
          children: <Widget>[
            ClipPath(
              child: Container(color: Colors.black.withOpacity(0.8)),
              clipper: getClipper(),
            ),
            LGTitleTextFormField(
                padding: EdgeInsets.only(
                    top: kMarginPadding,
                    left: kMarginPadding,
                    right: kMarginPadding,
                    bottom: kMarginPadding),
                title: "Old Password",
                hintText: "Enter your old password",
                controller: _oldPasswordTextController,
                onEditingComplete: _onEditingComplete,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Old password should not be empty";
                  } else if (value != _currentPassword) {
                    return "Passwords is wrong";
                  } else {
                    return null;
                  }
                },
                obscureText: true),
            LGTitleTextFormField(
                padding: EdgeInsets.only(
                    left: kMarginPadding,
                    right: kMarginPadding,
                    bottom: kMarginPadding),
                title: "New Password",
                hintText: "Enter your new password",
                controller: _newPasswordTextController,
                onEditingComplete: _onEditingComplete,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "password should not be empty";
                  } else if (value == _currentPassword) {
                    return "Please use some other password.";
                  } else if (value.length < 6) {
                    return "Please enter atleast 6 characters";
                  } else {
                    return null;
                  }
                },
                obscureText: true),
            LGTitleTextFormField(
                padding: EdgeInsets.all(kMarginPadding),
                title: "Confirm New Password",
                hintText: "Confirm new Password",
                controller: _confirmPasswordTextController,
                onEditingComplete: _onEditingComplete,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "password should not be empty";
                  } else if (_newPasswordTextController.text != value) {
                    return "Passwords does not match";
                  } else {
                    return null;
                  }
                },
                obscureText: true),
          ],
        ));
  }

  Widget _bottomCard() {
    return Column(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: getClipper(),
        ),
        RaisedButton(
          color: selectedColor,
          child: new Text("Save",
        style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800,),
          ),

          onPressed:() {updateData();},
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }

  _onEditingComplete() {
    FocusScope.of(context).requestFocus(new FocusNode());
    setState(() {
      _isProfileEdited = true;
    });
  }

}


class LGTitleTextFormField extends StatelessWidget {
  LGTitleTextFormField({
    this.title,
    this.hintText,
    this.controller,
    this.validator,
    this.emptyValidator = false,
    this.emptyValidatorMsg = "Should not be empty",
    this.textInputType,
    this.padding,
    this.disable = false,
    this.obscureText = false,
    this.onEditingComplete,
    this.inputFormatters
  });

  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function validator;
  final bool emptyValidator;
  final String emptyValidatorMsg;
  final TextInputType textInputType;
  final EdgeInsetsGeometry padding;
  final bool disable;
  final bool obscureText;
  final VoidCallback onEditingComplete;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: padding,
      child: new Column(
        children: <Widget>[

          new Container(
              alignment: Alignment.topLeft,
              child: new Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: selectedColor),
              )),
          new TextFormField(
              controller: controller,
              validator: emptyValidator ? _validateField : validator,
              keyboardType: textInputType,
              readOnly: disable,
              inputFormatters: inputFormatters,
              obscureText: obscureText,
              onEditingComplete: onEditingComplete != null ? onEditingComplete : _onEditingCompleted(context),
              style: new TextStyle(fontSize: 20.0),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: new TextStyle(
                  fontSize: 17.0,
                ),
              ))
        ],
      ),
    );
  }

  _onEditingCompleted(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  String _validateField(String text) {
    if (text.length == 0) {
      return emptyValidatorMsg;
    } else {
      null;
    }
  }
}
class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 0.98);
    path.lineTo(size.width + 40, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}