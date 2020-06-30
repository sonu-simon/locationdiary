import 'package:flutter/material.dart';
import './location.dart';

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
  LocationData locationData = LocationData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GeoLocate"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {
            setState(() {
              
            });
          })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("Get location"),
              onPressed: () {
                setState(() {
                  locationData = LocationData();
                  locationData.getCurrentLocation();
                  print(locationData.streetName);
                });
              },
            ),
            if (locationData.status == true)
              Text(locationData.streetName ?? "Waiting for data"),
            Text(locationData.formattedDate),
            FlatButton(onPressed: locationData.locURLFn, child: Text("maps"))
          ],
        ),
      ),
    );
  }
}
