import 'package:geoloc/database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class LocationData {
  Position currentPosition;
  String locURL;
  String streetName;
  bool status = false;
  DateTime now = DateTime.now();
  String type;
  var formattedDate =
      DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now());

  getCurrentLocation(String type) async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    double lat;
    double lng;
    String typefn = type;

    //Get current location
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
      lat = currentPosition.latitude;
      lng = currentPosition.longitude;
      print(currentPosition);
    }).catchError((e) {
      print(e);
    });

    //Get the street name of the current location
    await geolocator
        .placemarkFromCoordinates(lat, lng)
        .then((List<Placemark> placemark) {
      streetName = placemark[0].name;
      print(streetName);
    }).catchError((e) {
      print(e);
    });

    status = true;

    //Set URL for redirecting to Google Maps
    locURL = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    print(locURL);

    DatabaseService().updateLocData(
        currentPosition.toString(), locURL, streetName, formattedDate, typefn);
  }

  //Launch the URL with map coordindates
  locURLFn() {
    launch(locURL);
  }
}
