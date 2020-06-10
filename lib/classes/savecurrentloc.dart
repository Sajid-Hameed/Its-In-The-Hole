import 'package:google_maps_flutter/google_maps_flutter.dart';

class Savecurrent{
  static LatLng _currentr;
  static LatLng _centerr;
  static LatLng _center1r;
  static LatLng _current;
  static LatLng _center;
  static LatLng _center1;
  static bool _bool1;
  static String _text;


  LatLng get currentr => _currentr;

  set currentr(LatLng value) {
    _currentr = value;
  }


   String get text => _text;

  set text(String value) {
    _text = value;
  }

  LatLng get current => _current;

  set current(LatLng value) {
    _current = value;
  }

  LatLng get center => _center;

  set center(LatLng value) {
    _center = value;
  }

  LatLng get center1 => _center1;

  set center1(LatLng value) {
    _center1 = value;
  }

  bool get bool1 => _bool1;

  set bool1(bool value){
    _bool1 = value;
  }

  LatLng get centerr => _centerr;

  set centerr(LatLng value) {
    _centerr = value;
  }

  LatLng get center1r => _center1r;

  set center1r(LatLng value) {
    _center1r = value;
  }


}