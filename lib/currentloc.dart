import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:its_in_the_hole/Lats.dart';
import 'package:its_in_the_hole/classes/savecurrentloc.dart';
import 'package:its_in_the_hole/views/placedetail_screens.dart';
import 'package:its_in_the_hole/views/scorecard.dart';
import 'package:location/location.dart';
import 'appstate.dart';
import 'commons/navigation_bloc.dart';
import 'dart:ui' as ui;


class CurrentLocation extends StatefulWidget with NavigationStates{
  @override
  _CurrentLocationState createState() => _CurrentLocationState();

}
enum ConfirmAction { CANCEL, ACCEPT }
class _CurrentLocationState extends State<CurrentLocation> {
GoogleMapController _controller;


Savecurrent save = new Savecurrent();
  static double a,b,rotation_up;
  int count =0;
Map<PolylineId, Polyline> _mapPolylines = {};
final PolylineId polylineId = PolylineId("poly");
  static  LatLng _center;
  static  LatLng _current;
  static  LatLng _currentp;
  static  LatLng _center1;
  var cover = "",remaining = "",total = "";
  var bool1 ;
  String text = "Start A Round!";
  Uint8List markerIcon;
  Uint8List markerIcon1;
  Uint8List goalmarker;
  int reset = 0;
  int rotation_index=0;



final Set<Marker> _markers = {};
  String point;
Polyline polyline;
  //final Set<Polyline> polyline = {}; // sajid
  List<LatLng> routecord;//sajid
  GoogleMapPolyline googleMapPolylines=new GoogleMapPolyline(apiKey:"AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA");//sajid

//AIzaSyAGKFNn0Gk9EFj35JTLG5G77RQ3XHD8hH8
List<LatLng> routescoord;
//  PolylinePoints polylinePoints = PolylinePoints();
//  String googleAPIKey = "AIzaSyDS3pJ_x_WJn5MF8a3CYKaWeURdEqy24nE";
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.hybrid;
  Position position;
  GoogleMap googleMap;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    setState(() {
      final location = new Location();

      location.onLocationChanged().listen((LocationData cLoc){
        if(save.bool1) {
          print("vhange " + cLoc.latitude.toString());
          _current = LatLng(cLoc.latitude, cLoc.longitude);
          if (mounted) {
            setState(() {
              Savecurrent save = new Savecurrent();
              save.current = _current;
              save.center1  =_center1;
              _markers.remove(
                  _markers.firstWhere((Marker marker) => marker.markerId
                      .value == "current"));
              _markers.add(Marker(
                markerId: MarkerId("current"),
                position: _current,
                icon: BitmapDescriptor.fromBytes(markerIcon1),
              ));
              _currentp = _current;
            });
            getRouteCoordinates(save.center, save.current, save.center1);
            save.center1 = _center1;
          }
        }

      });

      if(count<2) {
        getUserLocation();
      }
    });

//    rotation_update();

  }

  Future<ConfirmAction> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      //barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: selectedColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text(save.text.toString()),
          actions: <Widget>[
            FlatButton(
              child: const Text('NO', style: TextStyle(color: Colors.white),),
              onPressed: () {

                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('YES', style: TextStyle(color: Colors.white),),
              onPressed: () {
                if(save.bool1 && save.text == "Exit"){
                  save.text = "Go To The First Hole!";
                  save.bool1 = false;
                  //bool1 = false;
                }
                else if(save.text == "Go To The First Hole!"){
                  save.text = "Exit";
                  save.bool1 = true;
                  //bool1 = true;
                }
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    ) ?? false;
  }

  Future<ConfirmAction> _asyncConfirmDialogrefresh(BuildContext context) async {
    return showDialog<ConfirmAction>(
      context: context,
      //barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: selectedColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text("Reset The Markers!"),
          actions: <Widget>[
            FlatButton(
              child: const Text('NO', style: TextStyle(color: Colors.white),),
              onPressed: () {

                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('YES', style: TextStyle(color: Colors.white),),
              onPressed: () {
                reset = 2;
                getUserLocation();
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    ) ?? false;
  }


  int distance(double lat1, double lon1, double lat2, double lon2)
  {
    var R = 6371; // Radius of the earth in km
    var dLat = deg2rad(lat2 - lat1); // deg2rad below
    var dLon = deg2rad(lon2 - lon1);
    var a =
        sin(dLat / 2) * sin(dLat / 2) +
            cos(deg2rad(lat1)) *
                cos(deg2rad(lat2)) *
                sin(dLon / 2) *
                sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    //d=( d * 1000);
    if(PlaceDetailScreen.unit == "yard") {
      d = d * 1093.61;
    }else{
      d = d * 1000;
    }
    return d.ceil();
  }

  double deg2rad(double deg)
  {
    return deg * (pi / 180);
  }

  double rad2deg(double rad)
  {
    return (rad * 180) / pi;
  }


  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;

    });
  }

  _change(LatLng latLng){
    setState(() {
      getRouteCoordinates(save.center, save.current, save.center1);
    });
  }

  getUserLocation() async{

    //position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    }
    markerIcon = await getBytesFromAsset('assets/goalfballrem.png', 100);
    markerIcon1 = await getBytesFromAsset('assets/marker.png', 70);
    goalmarker = await getBytesFromAsset('assets/goalrem.png', 100);

    setState(() {
      if(reset == 0) {
        save = new Savecurrent();
        _center = save.center;
        _center1 = save.center1;
        _current = save.current;
        bool1 = save.bool1;
        _currentp = _current;
      }
      else if (reset == 1){
        _markers.remove(
            _markers.firstWhere((Marker marker) => marker.markerId
                .value == "current"));
        save = new Savecurrent();
        save.current = save.currentr;
        save.center1 = save.center1r;
        save.center = save.centerr;
        _center = save.center;
        _center1 = save.center1;
        _current = save.current;
        bool1 = save.bool1;
        _currentp = _current;
      }
      else{


        save = new Savecurrent();
        save.currentr = save.current;
        save.center1 = new LatLng(save.current.latitude +0.0006, save.current.longitude);
        save.center1r = save.center1;
        save.center = save.current;
        save.centerr = save.center;

        _center = save.center;
        _center1 = save.center1;
        _current = save.current;
        bool1 = save.bool1;
        _currentp = _current;
      }
    });

    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("center"),
        position: _center,
        draggable: true,
        onDragEnd: (_centerr){
          save.center = LatLng(_centerr.latitude , _centerr.longitude);
          _center = save.center;
          _change(save.center);
        },
        icon: BitmapDescriptor.fromBytes(markerIcon),
      ));
    });

    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("center1"),
        position: _center1,
        draggable: true,
        onDragEnd: (_centerr1){
          save.center1 = LatLng(_centerr1.latitude , _centerr1.longitude);
          _center1 = save.center1;
          _change(save.center1);
        },
        icon: BitmapDescriptor.fromBytes(goalmarker),
      ));
    });

    setState(() {
      _markers.add(Marker(
        // This marker id can be anything that uniquely identifies each marker.
        markerId: MarkerId("current"),
        position: _current,
        icon: BitmapDescriptor.fromBytes(markerIcon1),
      ));
    });

    setState(() {
      getRouteCoordinates(save.center, save.current, save.center1);
      reset = 0;
    });
    
  }

   getRouteCoordinates(LatLng l1, LatLng l2 , LatLng l3) async {
    final List<LatLng> points = <LatLng>[];
    points.add(LatLng(l1.latitude, l1.longitude));
    points.add(LatLng(l2.latitude, l2.longitude));
    points.add(LatLng(l3.latitude, l3.longitude));

    remaining = distance(
        save.current.latitude, save.current.longitude, save.center1.latitude,
        save.center1.longitude).toString();
    cover = distance(
        save.center.latitude, save.center.longitude, save.current.latitude,
        save.current.longitude).toString();
    total = distance(
        save.center.latitude, save.center.longitude, save.center1.latitude,
        save.center1.longitude).toString();

    if (int.parse(remaining) <= 2 && reset == 0) {
      showAlertDialog(context);
    }

    if (PlaceDetailScreen.unit == "yard") {
      cover = "Cover "+cover + " y";
      remaining = "Remaining "+remaining + " y";
      total = "Total "+total.toString() + " y";
    }
    else {
      cover = "Cover "+cover + " m";
      remaining = "Remaining "+remaining + " m";
      total = "Total "+total.toString() + " m";
    }

    polyline = Polyline(
      polylineId: PolylineId("poly"),
      consumeTapEvents: true,
      color: Colors.white,
      width: 2,
      points: points,
    );

    _mapPolylines[polylineId] = polyline;
  }


//
//    String url =
//        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=AIzaSyAGKFNn0Gk9EFj35JTLG5G77RQ3XHD8hH8";
//    http.Response response = await http.get(url);
//    Map values = jsonDecode(response.body);
//    print(values["routes"][0]["overview_polyline"]["points"]);
//    point = values["routes"][0]["overview_polyline"]["points"];
//    setState(() {
//      polyline.add(Polyline(
//          polylineId: PolylineId('route1'),
//          visible: true,
//          points: convertToLatLng(decodePoly(point)),
//          width: 4,
//          color: Colors.deepPurpleAccent,
//          startCap: Cap.roundCap,
//          endCap: Cap.buttCap
//
//      ));
//    });
//    return values["routes"][0]["overview_polyline"]["points"];


  showAlertDialog(BuildContext context) {

    return showDialog<ConfirmAction>(
      context: context,
      //barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: selectedColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)),
          title: Text("Go To The Next Hole!"),
          actions: <Widget>[
            FlatButton(
              child: const Text('NO', style: TextStyle(color: Colors.white),),
              onPressed: () {

                Navigator.of(context).pop(ConfirmAction.CANCEL);
              },
            ),
            FlatButton(
              child: const Text('YES', style: TextStyle(color: Colors.white),),
              onPressed: () {
                reset = 1;
                getUserLocation();
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            )
          ],
        );
      },
    )?? false;
  }

//  static List decodePoly(String poly) {
//    var list = poly.codeUnits;
//    var lList = new List();
//    int index = 0;
//    int len = poly.length;
//    int c = 0;
//    // repeating until all attributes are decoded
//    do {
//      var shift = 0;
//      int result = 0;
//
//      // for decoding value of one attribute
//      do {
//        c = list[index] - 63;
//        result |= (c & 0x1F) << (shift * 5);
//        index++;
//        shift++;
//      } while (c >= 32);
//      /* if value is negative then bitwise not the value */
//      if (result & 1 == 1) {
//        result = ~result;
//      }
//      var result1 = (result >> 1) * 0.00001;
//      lList.add(result1);
//    } while (index < len);
//
//    /*adding to previous value as done in encoding */
//    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];
//
//    print(lList.toString());
//
//    return lList;
//  }
//
//  static List<LatLng> convertToLatLng(List points) {
//    List<LatLng> result = <LatLng>[];
//    for (int i = 0; i < points.length; i++) {
//      if (i % 2 != 0) {
//        result.add(LatLng(points[i - 1], points[i]));
//      }
//    }
//    return result;
//  }


  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

      Widget rotation_update(double rotation_now)
      {
        //List<double> rotaion = [270.0, 90.0,170.0, 320.0];
//        for(var i=0;i<rotaion.length;i++ )
//        {
//          rotation_up=rotaion[i];
//
//        }
        _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: rotation_now,
            target:  LatLng(_center1.latitude, _center1.longitude),
            tilt: 50.0,
            zoom: 19.0,
          ),
        ));
//                  remaining != null ? remaining : "0",
//                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),

      }

        Widget rotation_update1()
           {
            List<double> rotaion = [270.0, 90.0,170.0, 320.0];

    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 320.0,
        target:  LatLng(_center1.latitude, _center1.longitude),
        tilt: 50.0,
        zoom: 19.0,
      ),
    ));
//                  remaining != null ? remaining : "0",
//                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('Dashboard'),
          backgroundColor: selectedColor,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 2.0),
              child:GestureDetector(
                child: IconButton(icon: Icon(Icons.play_for_work, color: selectedColor1,),
                  onPressed: () async {

                    _asyncConfirmDialog(context);

                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 2.0),
              child:GestureDetector(
                child: IconButton(icon: Icon(Icons.refresh, color: selectedColor1,),
                  onPressed: () async {
                    _asyncConfirmDialogrefresh(context);
                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 2.0),
              child:GestureDetector(
                child: IconButton(icon: Icon(Icons.score, color: selectedColor1,),
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Scorecard()));
                  },

                ),
              ),
            ),
          ],
        ),

        body: Stack(

          children: <Widget>[
        GoogleMap(
        myLocationEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
               rotateGesturesEnabled: true,
               onMapCreated: onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _current != null ? _current : save.current,
              zoom: 19.0,
            ),

            mapType: _currentMapType,
            markers: _markers,
            polylines: Set<Polyline>.of(_mapPolylines.values),
            onCameraMove: _onCameraMove,
        ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 50.0,right: 50.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  total != null ?  total : "0",
                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 80.0,right: 50.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  cover != null ? cover : "0",
                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 110.0,right: 50.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  remaining != null ? remaining : "0",
                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),

                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0,top: 50.0,right: 20.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: FloatingActionButton(
                  child:Icon(Icons.screen_rotation),
                  backgroundColor: selectedColor,
                  elevation: 20.0,

                  onPressed:  () {
                    if(rotation_index==0){
                      rotation_update(90.0);
                      rotation_index=1;
                    }
                    else if(rotation_index==1)
                    {
                      rotation_update(30.0);
                      rotation_index=2;
                    }
                    else if(rotation_index==2)
                    {
                      rotation_update(340.0);
                      rotation_index=3;
                    }
                    else if(rotation_index==3)
                    {
                      rotation_update(270.0);
                      rotation_index=4;
                    }
                    else if(rotation_index==4)
                    {
                      rotation_update(180.0);
                      rotation_index=0;
                    }
//                    rotation_update1();

                  },

                ),
              ),
            ),
          ],
        ),
      );
    //);
  }
}
