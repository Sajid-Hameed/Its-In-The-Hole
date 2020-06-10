import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/views/yardage.dart';
import 'package:nice_button/nice_button.dart';
import 'SplashScreen.dart';


class SettingsScreen extends StatefulWidget with NavigationStates{
  @override
  TaskPage createState() => TaskPage();
}

class TaskPage  extends State<SettingsScreen> {

  var firstColor = Color(0xFF3bafda), secondColor = Color(0xFF4fc1e9);
  var thirdColor = Color(0xFFaab2bd), forthColor = Color(0xFFccd1d9);
  var fifthColor = Color(0xFF6a50a7), sixthColor = Color(0xFF8067b7);

  Future<bool> _onBackPressed(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
    child: Scaffold(
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
                  width: 145,
                  elevation: 8.0,
                  radius: 40,
                  padding: const EdgeInsets.all(8.0),
                  text: "Aqua",
                  icon: Icons.format_color_fill,
                  gradientColors: [firstColor, forthColor],
                  onPressed: () {
                    setState(() {
                      selectedColor = firstColor;
                      selectedColor1 = secondColor;
                    });

                  },
                ),

                NiceButton(
                  width: 145,
                  elevation: 8.0,
                  radius: 40,
                  padding: const EdgeInsets.all(8.0),
                  text: "Grey",
                  icon: Icons.format_color_fill,
                  gradientColors: [thirdColor, forthColor],
                  onPressed: () {
                    setState(() {
                      selectedColor = thirdColor;
                      selectedColor1 = forthColor;
                    });

                  },
                ),

                NiceButton(
                  width: 145,
                  elevation: 8.0,
                  radius: 40,
                  padding: const EdgeInsets.all(8.0),
                  text: "Plum",
                  icon: Icons.format_color_fill,
                  gradientColors: [sixthColor, forthColor],
                  onPressed: () {
                    setState(() {
                      selectedColor = fifthColor;
                      selectedColor1 = sixthColor;
                    });

                  },
                ),

                NiceButton(
                  width: 205,
                  elevation: 8.0,
                  radius: 40,
                  padding: const EdgeInsets.all(8.0),
                  text: "Yardage Page",
                  icon: Icons.arrow_forward,
                  gradientColors: [sixthColor, firstColor],
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context)=> new Yardage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    );
  }
}
