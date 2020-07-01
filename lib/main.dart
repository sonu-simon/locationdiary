import 'package:flutter/material.dart';
import './location.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:background_fetch/background_fetch.dart';

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
  String status = "not started";
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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
        status = "bgfetch started";
      });
    });
  }

  void _onBackgroundFetch(String taskId) async {
    setState(() {
      status = "bgfetch initiated";
    });
    LocationData locationData = LocationData();
    locationData.getCurrentLocation("BackgroundFetch");
    setState(() {
      status = "bgfetch started successfully";
    });

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
            Text(status),
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