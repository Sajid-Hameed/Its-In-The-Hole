import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  Image image;
  NavigationModel({this.title, this.icon,this.image});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.home),
  NavigationModel(title: "Profile", icon: Icons.person),
  NavigationModel(title: "Edit Profile", icon: Icons.edit),
  NavigationModel(title: "About Us", icon: Icons.details),
  NavigationModel(title: "Settings", icon: Icons.settings),
  NavigationModel(title: "Logout", icon: Icons.arrow_back),
];
