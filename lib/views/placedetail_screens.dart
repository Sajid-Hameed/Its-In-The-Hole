import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:its_in_the_hole/models/place_model.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
const kGoogleApiKey = "AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";

class PlaceDetailScreen extends StatefulWidget {
  Place _place;
  static String unit = "yard";
  PlaceDetailScreen(Place place){
    this._place = place;
  }
  @override
  PlaceDetailScreenState createState() => PlaceDetailScreenState(_place);
}

class PlaceDetailScreenState extends State<PlaceDetailScreen> {
  static double a,b;
  Completer<GoogleMapController> _controller = Completer();
  static Position position;
  static LatLng _center ;
  static LatLng _center1 ;
  static LatLng _center2 ;
  static LatLng _drag ;
  static LatLng _drag1 ;
  static LatLng _drag2 ;
  List<LatLng> polylineCoordinates = [];
  List<LatLng> latlng;
  LatLng _lastMapPosition1;
  Polyline polyline;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  var cover,remaining,total;
  List<Polyline> poly;
  String googleAPIKey = "AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
  double lat,lng;
  Map<PolylineId, Polyline> _mapPolylines = {};
  final PolylineId polylineId = PolylineId("poly");
  double latt,lngg,a1,b2;
  PolylinePoints polylinePoints = PolylinePoints();
  PlaceDetailScreenState(Place place){
    this.lat = place.lat;
    this.lng = place.long;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setSourceAndDestinationIcons();
    getUserLocation();
  }

  Future<Position> locateUser() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 6.5),
        'assets/golfball.jpeg');
    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 6.5), 'assets/flag.jpg');
  }

  _change(LatLng latLng){
    setState(() {
      final List<LatLng> points = <LatLng>[];
      points.add(LatLng(_drag.latitude, _drag.longitude));
      points.add(LatLng(_drag2.latitude, _drag2.longitude));
      points.add(LatLng(_drag1.latitude, _drag1.longitude));

        cover = distance(_drag.latitude, _drag.longitude, _drag2.latitude, _drag2.longitude).toString();
        remaining = distance(_drag2.latitude, _drag2.longitude , _drag1.latitude,_drag1.longitude).toString();
        total = int.parse(cover) + int.parse(remaining);
      if(PlaceDetailScreen.unit == "yard"){
        cover = cover +" y";
        remaining = remaining +" y";
        total = total.toString() +" y";
      }
      else{
        cover = cover +" m";
        remaining = remaining +" m";
        total = total.toString() +" m";

      }

      polyline=Polyline(
        polylineId: PolylineId(_center.toString()),
        consumeTapEvents: true,
        color: Colors.white,
        width: 2,
        points: points,
      );

      _mapPolylines[polylineId] = polyline;
    });
  }

  getUserLocation() async {

    setState(() {
     lat=lat -0.0003;
      double la=lat +0.0006;
      double ln=lng;
      double ll = la - 0.0003;

     _center= LatLng(lat.toDouble(),lng.toDouble());
     _center1= LatLng(la,ln);
      _center2= LatLng(ll,ln);
      _drag = _center;
      _drag1 = _center1;
      _drag2 = _center2;

      List<LatLng> _createPoints(points) {
        final List<LatLng> points = <LatLng>[];
        points.add(LatLng(_drag.latitude, _drag.longitude));
        points.add(LatLng(_drag2.latitude, _drag2.longitude));
        points.add(LatLng(_drag1.latitude, _drag1.longitude));

        cover = distance(_drag.latitude, _drag.longitude, _drag2.latitude, _drag2.longitude).toString();
        remaining = distance(_drag2.latitude, _drag2.longitude , _drag1.latitude,_drag1.longitude).toString();
        total = int.parse(cover) + int.parse(remaining);

        if(PlaceDetailScreen.unit == "yard"){
          cover = cover +" y";
          remaining = remaining +" y";
          total = total.toString() +" y";

        }
        else{
          cover = cover +" m";
          remaining = remaining +" m";
          total = total.toString() +" m";

        }
        return points;
      }

      setState(() {
        polyline=Polyline(
          polylineId: PolylineId(_center.toString()),
          consumeTapEvents: true,
          color: Colors.white,
          width: 2,
          points: _createPoints(_center),
        );
      });
       _lastMapPosition1 = _center;


    });
    Future<Uint8List> getBytesFromAsset(String path, int width) async {
      ByteData data = await rootBundle.load(path);
      ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
    }
    final Uint8List markerIcon = await getBytesFromAsset('assets/goalfballrem.png', 50);
    final Uint8List markerIcon1 = await getBytesFromAsset('assets/marker.png', 50);
    final Uint8List goalmarker = await getBytesFromAsset('assets/goalrem.png', 50);
    setState((){
      _markers.add(Marker(
        markerId: MarkerId("second"),
        position: _center2,
          consumeTapEvents: true,
        draggable: true,
          icon: BitmapDescriptor.fromBytes(markerIcon1),
          infoWindow: InfoWindow(title: cover,snippet: cover),
          onDragEnd: (_center2){
            _drag2  = LatLng(_center2.latitude , _center2.longitude);
            _change(_drag2);
            print("second");
            print(_center2.latitude);
            print(_center2.longitude);
          }),
      );
    });

    setState((){
      _markers.add(Marker(
        markerId: MarkerId(lat.toString()),
        position: _center,
        draggable: true,
        icon: BitmapDescriptor.fromBytes(markerIcon),
          onDragEnd: (_center){
          _drag  = LatLng(_center.latitude , _center.longitude);
          _change(_drag);
          print("lat");
            print(_center.latitude);
            print(_center.longitude);
          }
      ));

      setState(() {
        _mapPolylines[polylineId] = polyline;
      });
    });

    setState((){
      _markers.add(Marker(
        markerId: MarkerId("first"),
        position: _center1,
        draggable: true,

        icon: BitmapDescriptor.fromBytes(goalmarker),
          onDragEnd: (_center1){
            _drag1 = LatLng(_center1.latitude , _center1.longitude);
            _change(_drag1);
            print("first");
            print(_center1.latitude);
            print(_center1.longitude);
          },
      ),
      );
    });

  }

  Set<Marker> _markers = {};

  static LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.hybrid;
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

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      home: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center != null ? _center : '54.4510',
                zoom: 19.0,
              ),
              polylines: Set<Polyline>.of(_mapPolylines.values),
              mapType: _currentMapType,
              markers: _markers,
              onCameraMove: _onCameraMove,
              //circles: circles,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 50.0,right: 50.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Total "+total.toString(),
                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 80.0,right: 50.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                    "Cover "+cover,
                    style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0,top: 110.0,right: 50.0,bottom: 0.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Remaining "+remaining,
                  style: TextStyle(fontSize: 25.0,color: Colors.white,fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }



