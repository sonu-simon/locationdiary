//import 'dart:async';
//import 'dart:convert';

import 'package:flutter/material.dart';
import './location.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:background_fetch/background_fetch.dart';

//const EVENTS_KEY = "fetch_events";

// This "Headless Task" is run when app is terminated.
void backgroundFetchHeadlessTask(String taskId) async {
  print("Headless task fn entered");

  LocationData headlessLocationData = LocationData();
  headlessLocationData.getCurrentLocation("backgroundFetchHeadless");

  BackgroundFetch.finish(taskId);
}

void main() {
  runApp(MyApp());

  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
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
  //bool _enabled = true;
  //int _status = 0;
  //List<String> _events = [];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Load persisted fetch events from SharedPreferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String json = prefs.getString(EVENTS_KEY);
    // if (json != null) {
    //   setState(() {
    //     _events = jsonDecode(json).cast<String>();
    //   });
    // }

    // Configure BackgroundFetch.
    BackgroundFetch.configure(
            BackgroundFetchConfig(
              minimumFetchInterval: 15,
              forceAlarmManager: false,
              stopOnTerminate: false,
              startOnBoot: true,
              enableHeadless: true,
              requiresBatteryNotLow: false,
              requiresCharging: false,
              requiresStorageNotLow: false,
              requiresDeviceIdle: false,
              requiredNetworkType: NetworkType.NONE,
            ),
            _onBackgroundFetch)
        .then((int status) {})
        .catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
      setState(() {
        //_status = e;
      });
    });

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  void _onBackgroundFetch(String taskId) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    //DateTime timestamp = new DateTime.now();
    // This is the fetch-event callback.
    //print("[BackgroundFetch] Event received: $taskId");
    //setState(() {
    //_events.insert(0, "$taskId@${timestamp.toString()}");
    //});
    // Persist fetch events in SharedPreferences
    //prefs.setString(EVENTS_KEY, jsonEncode(_events));
    LocationData locationData = LocationData();
    locationData.getCurrentLocation("BackgroundFetch");

    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GeoLocate"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {});
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
                  LocationData locationData = LocationData();
                  locationData.getCurrentLocation("onButtonPressed");
                  // print(locationData.streetName);
                });
              },
            ),
            // if (locationData.status == true)
            //   Text(locationData.streetName ?? "Waiting for data"),
            // Text(locationData.formattedDate),
            // FlatButton(onPressed: locationData.locURLFn, child: Text("maps"))
          ],
        ),
      ),
    );
  }
}
