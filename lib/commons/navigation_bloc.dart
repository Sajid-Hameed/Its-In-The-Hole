import 'package:bloc/bloc.dart';
import 'package:its_in_the_hole/views/ProfileScreen.dart';
import 'package:its_in_the_hole/views/SettingsScreen.dart';
import 'package:its_in_the_hole/views/places_screens.dart';
import 'package:its_in_the_hole/views/scorecard.dart';
import '../about.dart';
import '../currentloc.dart';


enum NavigationEvents {
  HomePageClickedEvent,
  MyProfileClickEvent,
  MyAboutClickedEvent,
  MySettingClickedEvent,
  MyScorecardClickedEvent,
  Nearby,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => CurrentLocation();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.HomePageClickedEvent:
        yield CurrentLocation();
        //yield PlacesScreens();
        break;
      case NavigationEvents.Nearby:
        yield PlacesScreens();
        break;
      case NavigationEvents.MyProfileClickEvent:
        yield ProfileScreen();
        break;
      case NavigationEvents.MyAboutClickedEvent:
      yield About();
      break;
      case NavigationEvents.MySettingClickedEvent:
        yield SettingsScreen();
        break;
      case NavigationEvents.MyScorecardClickedEvent:
        yield Scorecard();
        break;

    }
  }
}