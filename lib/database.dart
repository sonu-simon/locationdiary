import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';


class DatabaseService {
  final CollectionReference locDataCollection =
      Firestore.instance.collection('locData');

  Future updateLocData(String currentPosition, String locURL, String streetName,
      String now) async {
        print("this shit ran");
    return await locDataCollection.add({
      'currentPosition': currentPosition,
      'locURL': locURL,
      'streetName': streetName,
      'now': now,
    });
  }
}
