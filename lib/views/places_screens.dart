import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:its_in_the_hole/appstate.dart';
import 'package:its_in_the_hole/commons/navigation_bloc.dart';
import 'package:its_in_the_hole/models/place_model.dart';
import 'package:its_in_the_hole/views/placedetail_screens.dart';
import 'package:its_in_the_hole/services/place_services.dart';



List<Place>_placess;

const kGoogleApiKey = "AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
const kKey = "&key=AIzaSyDPnwRkWGUajxdbUd20L8r3r9E2NwXNtxA";
const appp= "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=";
class PlacesScreens extends StatefulWidget with NavigationStates{
  @override
  PlacesScreensState createState() => PlacesScreensState();
}

class PlacesScreensState extends State<PlacesScreens> {
  Prediction p;

  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Nearby GolfCourses'),
        backgroundColor: selectedColor,

        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 2.0),
            child:GestureDetector(
            child: IconButton(icon: Icon(Icons.search, color: selectedColor1,),
              onPressed: () async {
                p = await PlacesAutocomplete.show(
                    context: context, apiKey: kGoogleApiKey , mode: Mode.overlay);
                // show input autocomplete with selected mode
                // then get the Prediction selected

                      _placess.clear();
                      new Center(
                        child: new CircularProgressIndicator(),
                      );
                this.setState(() async {
                  PlaceService.get().displayPrediction(p).then((data1) {
                    this.setState(() {
                      _placess = data1;
                    });
                  });
                });
              },
            ),
          ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 2.0),
            child:GestureDetector(
              child: IconButton(icon: Icon(Icons.location_on, color: selectedColor1,),
                onPressed: () async {
//                  p = await PlacesAutocomplete.show(
//                      context: context, apiKey: kGoogleApiKey);
                  // show input autocomplete with selected mode
                  // then get the Prediction selected
                  if(mounted)
                  {
                    setState(() {
                      _placess.clear();
                      new Center(
                        child: new CircularProgressIndicator(),
                      );

                    });
                  }
                 this.setState(() async {
                   PlaceService.get().getNearbyPlaces().then((data) {
                     this.setState(() {
                       _placess = data;
                     });
                    });
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Container(

        child: Center(
          child: _createContent(),
        ),
      ),

    );
  }

  String buildPhotoURL(String photoReference) {
    if(!photoReference.contains("https:")) {
      return "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference="+photoReference+"&key="+kGoogleApiKey;
    }
    else{
      return photoReference;
    }
  }

  Widget _createContent() {

    if (_placess == null) {
      return new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      return new ListView(
        children: _placess.map((f) {
          return new Card(
              child: ListTile(
                  title: new Text(f.name),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: new NetworkImage(buildPhotoURL(f.photos)),
                    radius: 30.0,
                  ),
                  subtitle: new Text(f.vicinity),
                  trailing: new Column(
                    children: <Widget>[
                      new Icon(Icons.star, color: selectedColor,),
                      new Text(f.rating)
                    ],
                  ),
                  onTap: () {
                    handleTap(f);
                  }
              )
          );
        }).toList(),
      );
    }
  }

  handleTap(Place place) {
    Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => new PlaceDetailScreen(place)));
  }



  @override void initState() {
super.initState();
  this.setState(() {

    PlaceService.get().getNearbyPlaces().then((data) {
      this.setState(() {
        _placess = data;
      });
    });
  });

  }
}