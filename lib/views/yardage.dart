import 'package:flutter/material.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/sidebar/sidebar_layout.dart';
import 'package:its_in_the_hole/views/placedetail_screens.dart';
import 'package:nice_button/NiceButton.dart';
import '../appstate.dart';

var firstColor = Color(0xFF3bafda), secondColor = Color(0xFF4fc1e9);
var thirdColor = Color(0xFFaab2bd), forthColor = Color(0xFFccd1d9);
var fifthColor = Color(0xFF6a50a7), sixthColor = Color(0xFF8067b7);
class Yardage extends StatefulWidget {
  @override
  _YardageState createState() => _YardageState();
}

class _YardageState extends State<Yardage> with NavigationStates{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: selectedColor,
      ),
      body: new Material(
        color: selectedColor,
        child: new Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(

              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                NiceButton(
                  width: 205,
                  elevation: 8.0,
                  radius: 40,
                  padding: const EdgeInsets.all(8.0),
                  text: "Metre",
                  icon: Icons.edit,
                  gradientColors: [sixthColor, firstColor],
                  onPressed: () {
                    PlaceDetailScreen.unit = "metre";
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> new SideBarLayout()));
                  },
                ),
                NiceButton(
                  width: 205,
                  elevation: 8.0,
                  radius: 40,
                  padding: const EdgeInsets.all(8.0),
                  text: "Yard",
                  icon: Icons.ac_unit,
                  gradientColors: [sixthColor, firstColor],
                  onPressed: () {
                    PlaceDetailScreen.unit = "yard";
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> new SideBarLayout()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
