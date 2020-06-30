import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Position _currentPosition;
  String locURL;
  String _currentAddress;

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .placemarkFromCoordinates(
            _currentPosition.latitude, _currentPosition.longitude)
        .then((List<Placemark> placemark) {
      setState(() {
        _currentAddress = placemark[0].name;
        print(_currentAddress);
      });
    });
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      print(e);
    });
  }

  _setLocationURL(String lat, String lng) async {
    locURL = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
  }

  _locURL() {
    launch(locURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GeoLocate"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
                _setLocationURL(_currentPosition.latitude.toString(),
                    _currentPosition.longitude.toString());
              },
            ),
            if (_currentAddress != null) Text(_currentAddress),
            if (_currentPosition != null)
              RaisedButton(onPressed: _locURL, child: Text("View in maps"))
          ],
        ),
      ),
    );
  }
}
