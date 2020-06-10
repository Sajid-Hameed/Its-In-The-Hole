import 'dart:convert';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:its_in_the_hole/models/place_model.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
const kGoogleApiKey = "AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class SearchPlaces extends StatefulWidget {
  @override
  _MyHomePageState createState() =>_MyHomePageState();

}

class _MyHomePageState extends State<SearchPlaces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Map());
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: RaisedButton(
              onPressed: () async {
                Prediction p = await PlacesAutocomplete.show(
                    context: context, apiKey: kGoogleApiKey);
                displayPrediction(p);
              },
              child: Text('Find address'),
            )
        )
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);
      List <String> photos=new List<String>();
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
     photos.add(detail.result.photos.toString());

      String loc = detail.result.geometry.location.lat.toString()+","+detail.result.geometry.location.lng.toString();
      final  String searchurl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location="+loc+"&radius=150000&type=courses&keyword=golf&key=AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
      var reponse = await http.get(searchurl, headers: {"Accept": "application/json"});
      var places = <Place>[];
      List data = json.decode(reponse.body)["results"];

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

      print(lat);
      print(lng);
      return places;
    }
  }
}