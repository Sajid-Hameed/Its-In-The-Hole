import 'dart:convert';
import 'package:google_maps_webservice/places.dart';
import 'package:its_in_the_hole/models/place_model.dart';
import 'package:its_in_the_hole/views/placedetail_screens.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

const kGoogleApiKey = "AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
class PlaceService{
  static final _service = new PlaceService();

  static Position position;
  static PlaceService get(){
    return _service;
  }


  int index = 0;
  List data;
   Future<List<Place>> getNearbyPlaces() async{
     position = await Geolocator().getCurrentPosition(
           desiredAccuracy: LocationAccuracy.high);
       String loc = position.latitude.toString() + "," +
           position.longitude.toString();
       PlaceDetailScreenState.a = position.latitude;
       PlaceDetailScreenState.b = position.longitude;
       final String searchurl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
           loc +
           "&radius=150000&type=courses&keyword=golf&key=AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
       var reponse = await http.get(
           searchurl, headers: {"Accept": "application/json"});
       var places = <Place>[];
       data = json.decode(reponse.body)["results"];
       for(final f in data){
         if(f.toString().contains("photos")){
           places.add(new Place(
               f["icon"],
               f["name"],
               f["rating"].toString(),
               f["vicinity"],
               f["place_id"],
               f["geometry"]["location"]["lat"],
               f["geometry"]["location"]["lng"],
               f["photos"][0]["photo_reference"]
           ));
         }
         else{
           places.add(new Place(
               f["icon"],
               f["name"],
               f["rating"].toString(),
               f["vicinity"],
               f["place_id"],
               f["geometry"]["location"]["lat"],
               f["geometry"]["location"]["lng"],
               f["icon"]
           ));
         }
       }

       return places;

  }

  Future<List<Place>> displayPrediction(Prediction p) async {
        if(p!=null) {
          PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
          String loc = detail.result.geometry.location.lat.toString() + "," +
              detail.result.geometry.location.lng.toString();
          final String searchurl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=" +
              loc +
              "&radius=150000&type=courses&keyword=golf&key=AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
          var reponse = await http.get(
              searchurl, headers: {"Accept": "application/json"});

          var places = <Place>[];
          List data1 = json.decode(reponse.body)["results"];

          for(final f in data1){
            if(f.toString().contains("photos")){
              places.add(new Place(
                  f["icon"],
                  f["name"],
                  f["rating"].toString(),
                  f["vicinity"],
                  f["place_id"],
                  f["geometry"]["location"]["lat"],
                  f["geometry"]["location"]["lng"],
                  f["photos"][0]["photo_reference"]
              ));
            }
            else{
              places.add(new Place(
                  f["icon"],
                  f["name"],
                  f["rating"].toString(),
                  f["vicinity"],
                  f["place_id"],
                  f["geometry"]["location"]["lat"],
                  f["geometry"]["location"]["lng"],
                  f["icon"]
              ));
            }
          }
          return places;
        }
  }

  static double lat;

  static double long;
  Future getPlace(Place p) async{
    Position position =  await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    String loc = position.latitude.toString()+","+position.longitude.toString();
    final String detailUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+loc+"&radius=150000&type=golf&keyword=courses&key=AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";

    var reponse = await http.get(detailUrl, headers: {"Accept": "application/json"});
    var data1 = json.decode(reponse.body)["results"];

    lat = data1["geometry"]["location"]["lat"];
    p.lat =lat;


    long = data1["geometry"]["location"]["lng"];
    p.long =long;

    return p;
  }
}
