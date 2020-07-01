import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference locDataCollection =
      Firestore.instance.collection('locData');

  Future updateLocData(String currentPosition, String locURL, String streetName,
      String now, String type) async {
    print("this shit ran");
    return await locDataCollection.document(now + ' SP ' + type).setData({
      'currentPosition': currentPosition,
      'locURL': locURL,
      'streetName': streetName,
      'now': now,
      'type': type,
    });
  }
}
