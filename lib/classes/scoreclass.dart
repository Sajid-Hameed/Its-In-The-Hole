import 'package:flutter/material.dart';
import 'package:its_in_the_hole/views/scoreback.dart';
import 'package:its_in_the_hole/views/scorecard.dart';


class score extends StatefulWidget {


  static final par1 = TextEditingController(text: "0");
  static final par2 = TextEditingController(text: "0");
  static final par3 = TextEditingController(text: "0");
  static final par4 = TextEditingController(text: "0");
  static final par5 = TextEditingController(text: "0");
  static final par6 = TextEditingController(text: "0");
  static final par7 = TextEditingController(text: "0");
  static final par8 = TextEditingController(text: "0");
  static final par9 = TextEditingController(text: "0");
  static final par10 = TextEditingController(text: "0");
  static final par11 = TextEditingController(text: "0");
  static final par12 = TextEditingController(text: "0");
  static final par13 = TextEditingController(text: "0");
  static final par14 = TextEditingController(text: "0");
  static final par15 = TextEditingController(text: "0");
  static final par16 = TextEditingController(text: "0");
  static final par17 = TextEditingController(text: "0");
  static final par18 = TextEditingController(text: "0");

  static final hcp1 = TextEditingController(text: "0");
  static final hcp2 = TextEditingController(text: "0");
  static final hcp3 = TextEditingController(text: "0");
  static final hcp4 = TextEditingController(text: "0");
  static final hcp5 = TextEditingController(text: "0");
  static final hcp6 = TextEditingController(text: "0");
  static final hcp7 = TextEditingController(text: "0");
  static final hcp8 = TextEditingController(text: "0");
  static final hcp9 = TextEditingController(text: "0");
  static final hcp10 = TextEditingController(text: "0");
  static final hcp11 = TextEditingController(text: "0");
  static final hcp12 = TextEditingController(text: "0");
  static final hcp13 = TextEditingController(text: "0");
  static final hcp14 = TextEditingController(text: "0");
  static final hcp15 = TextEditingController(text: "0");
  static final hcp16 = TextEditingController(text: "0");
  static final hcp17 = TextEditingController(text: "0");
  static final hcp18 = TextEditingController(text: "0");

  static final fa1 = TextEditingController(text: "0");
  static final fa2 = TextEditingController(text: "0");
  static final fa3 = TextEditingController(text: "0");
  static final fa4 = TextEditingController(text: "0");
  static final fa5 = TextEditingController(text: "0");
  static final fa6 = TextEditingController(text: "0");
  static final fa7 = TextEditingController(text: "0");
  static final fa8 = TextEditingController(text: "0");
  static final fa9 = TextEditingController(text: "0");
  static final fa10 = TextEditingController(text: "0");
  static final fa11 = TextEditingController(text: "0");
  static final fa12 = TextEditingController(text: "0");
  static final fa13 = TextEditingController(text: "0");
  static final fa14 = TextEditingController(text: "0");
  static final fa15 = TextEditingController(text: "0");
  static final fa16 = TextEditingController(text: "0");
  static final fa17 = TextEditingController(text: "0");
  static final fa18 = TextEditingController(text: "0");

  static show(){

    Scorecard.front = int.parse(par1.text) + int.parse(par2.text) + int.parse(par3.text) + int.parse(par4.text) + int.parse(par5.text) + int.parse(par6.text) + int.parse(par7.text) + int.parse(par8.text) + int.parse(par9.text) ;
    Scoreback.back = int.parse(par10.text) + int.parse(par11.text) + int.parse(par12.text) + int.parse(par13.text) + int.parse(par14.text) + int.parse(par15.text) + int.parse(par16.text) + int.parse(par17.text) + int.parse(par18.text) ;
    Scorecard.total = Scorecard.front + Scoreback.back;
    Scoreback.total = Scorecard.front + Scoreback.back;
    Scorecard.fafront = int.parse(fa1.text) + int.parse(fa2.text) + int.parse(fa3.text) + int.parse(fa4.text) + int.parse(fa5.text) + int.parse(fa6.text) + int.parse(fa7.text) + int.parse(fa8.text) +  int.parse(fa9.text);
    Scoreback.faback = int.parse(fa10.text) + int.parse(fa11.text) + int.parse(fa12.text) + int.parse(fa13.text) + int.parse(fa14.text) + int.parse(fa15.text) + int.parse(fa16.text) + int.parse(fa17.text) +  int.parse(fa18.text);
    Scorecard.fatotal = Scorecard.fafront + Scoreback.faback;
    Scoreback.fatotal = Scorecard.fafront + Scoreback.faback;


    print(Scorecard.front);
  }
  @override
  _scoreState createState() => _scoreState();
}

class _scoreState extends State<score> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//abstract class score{
//
//
//  static var front = 0;
//  static var back = 0;
//  static var total = 0;
//  static var fafront = 0;
//  static var faback = 0;
//  static var fatotal = 0;
//
//  static final par1 = TextEditingController(text: "0");
//  static final par2 = TextEditingController(text: "0");
//  static final par3 = TextEditingController(text: "0");
//  static final par4 = TextEditingController(text: "0");
//  static final par5 = TextEditingController(text: "0");
//  static final par6 = TextEditingController(text: "0");
//  static final par7 = TextEditingController(text: "0");
//  static final par8 = TextEditingController(text: "0");
//  static final par9 = TextEditingController(text: "0");
//  static final par10 = TextEditingController(text: "0");
//  static final par11 = TextEditingController(text: "0");
//  static final par12 = TextEditingController(text: "0");
//  static final par13 = TextEditingController(text: "0");
//  static final par14 = TextEditingController(text: "0");
//  static final par15 = TextEditingController(text: "0");
//  static final par16 = TextEditingController(text: "0");
//  static final par17 = TextEditingController(text: "0");
//  static final par18 = TextEditingController(text: "0");
//
//  static final hcp1 = TextEditingController(text: "0");
//  static final hcp2 = TextEditingController(text: "0");
//  static final hcp3 = TextEditingController(text: "0");
//  static final hcp4 = TextEditingController(text: "0");
//  static final hcp5 = TextEditingController(text: "0");
//  static final hcp6 = TextEditingController(text: "0");
//  static final hcp7 = TextEditingController(text: "0");
//  static final hcp8 = TextEditingController(text: "0");
//  static final hcp9 = TextEditingController(text: "0");
//  static final hcp10 = TextEditingController(text: "0");
//  static final hcp11 = TextEditingController(text: "0");
//  static final hcp12 = TextEditingController(text: "0");
//  static final hcp13 = TextEditingController(text: "0");
//  static final hcp14 = TextEditingController(text: "0");
//  static final hcp15 = TextEditingController(text: "0");
//  static final hcp16 = TextEditingController(text: "0");
//  static final hcp17 = TextEditingController(text: "0");
//  static final hcp18 = TextEditingController(text: "0");
//
//  static final fa1 = TextEditingController(text: "0");
//  static final fa2 = TextEditingController(text: "0");
//  static final fa3 = TextEditingController(text: "0");
//  static final fa4 = TextEditingController(text: "0");
//  static final fa5 = TextEditingController(text: "0");
//  static final fa6 = TextEditingController(text: "0");
//  static final fa7 = TextEditingController(text: "0");
//  static final fa8 = TextEditingController(text: "0");
//  static final fa9 = TextEditingController(text: "0");
//  static final fa10 = TextEditingController(text: "0");
//  static final fa11 = TextEditingController(text: "0");
//  static final fa12 = TextEditingController(text: "0");
//  static final fa13 = TextEditingController(text: "0");
//  static final fa14 = TextEditingController(text: "0");
//  static final fa15 = TextEditingController(text: "0");
//  static final fa16 = TextEditingController(text: "0");
//  static final fa17 = TextEditingController(text: "0");
//  static final fa18 = TextEditingController(text: "0");
//
//  static show(){
//
//    front = int.parse(par1.text) + int.parse(par2.text) + int.parse(par3.text) + int.parse(par4.text) + int.parse(par5.text) + int.parse(par6.text) + int.parse(par7.text) + int.parse(par8.text) + int.parse(par9.text) ;
//    back = int.parse(par10.text) + int.parse(par11.text) + int.parse(par12.text) + int.parse(par13.text) + int.parse(par14.text) + int.parse(par15.text) + int.parse(par16.text) + int.parse(par17.text) + int.parse(par18.text) ;
//    total = front + back;
//    fafront = int.parse(fa1.text) + int.parse(fa2.text) + int.parse(fa3.text) + int.parse(fa4.text) + int.parse(fa5.text) + int.parse(fa6.text) + int.parse(fa7.text) + int.parse(fa8.text) +  int.parse(fa9.text);
//    faback = int.parse(fa10.text) + int.parse(fa11.text) + int.parse(fa12.text) + int.parse(fa13.text) + int.parse(fa14.text) + int.parse(fa15.text) + int.parse(fa16.text) + int.parse(fa17.text) +  int.parse(fa18.text);
//    fatotal = fafront + faback;
//
//    print(front);
//  }
//
//}