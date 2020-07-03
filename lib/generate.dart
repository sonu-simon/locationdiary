import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class Generate extends StatefulWidget {
  @override
  _GenerateState createState() => _GenerateState();
}

class _GenerateState extends State<Generate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Generate")),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children:<Widget>[
            QrImage(data: "Welcome i am Cyril",)

          ]
        ),
      ),
      
    );
  }
}