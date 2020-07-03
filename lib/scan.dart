import 'package:barcode_scan/barcode_scan.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'database.dart';
import 'location.dart';
import 'login.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<Scan> {
  dynamic scaRes = "Nothing Scanned ";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Scan")),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                height: 60,
                alignment: Alignment.center,
                margin: EdgeInsets.all(5),
                child: Text(
                  scaRes,
                  textAlign: TextAlign.center,
                ),
                color: Colors.blue[200],
              ),
              SizedBox(
                width: 20,
                height: 10,
              ),
              FlatButton(
                textTheme: ButtonTextTheme.accent,
                padding: EdgeInsets.all(15),
                child: Text("Scan"),
                onPressed: () async {
                  var scan = await BarcodeScanner.scan();
                  var now = DateFormat('yyyy-MM-dd – kk:mm:ss')
                      .format(DateTime.now());
                  if (scan.rawContent.toString().substring(0, 3) == "pLc") {
                    print("==============================");
                    print("Entered public place");
                    print("==============================");

                    String place = scan.rawContent.toString().substring(3);
                    DatabaseService().updateLocDataPublicPlc(now, place);
                    DatabaseService()
                        .updateLocDataPublicPlcAll(now, place, "place");
                  } else if (scan.rawContent.toString().substring(0, 6) ==
                      "p-Ee-r") {
                    print("==============================");
                    print("met a person");
                    print("==============================");

                    String person = scan.rawContent.toString().substring(6);
                    LocationData locationData = LocationData();
                    locationData.getCurrentLocationForPerson(
                        person, "$name - $phone");
                    //locationData.getCurrentLocationForPerson(person);
                  }

                  setState(() {
                    scaRes = scan.rawContent.toString() + now.toString();
                    print(scaRes);
                  });
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23),
                    side: BorderSide(color: Colors.teal[400], width: 3)),
              )
            ]),
      ),
    );
  }
}
