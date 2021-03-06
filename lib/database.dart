import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';

class DatabaseService {
  final CollectionReference locDataCollection =
      Firestore.instance.collection('$name - $phone');

  Future updateLocData(String currentPosition, String locURL, String streetName,
      String now, String type) async {
    print("this shit ran");
    return await locDataCollection.document(now + ' ID ' + type).setData({
      'currentPosition': currentPosition,
      'locURL': locURL,
      'streetName': streetName,
      'now': now,
      'type': type,
    });
  }

  // Future updateLocDataLatLong(String currentPosition, String locURL,
  //     String streetName, String now, String type, String per) async {
  //   final CollectionReference locDataCollection =
  //       Firestore.instance.collection(currentPosition);
  //   print("this shit ran");
  //   return await locDataCollection.document(now + ' ID ' + type).setData({
  //     'person': per,
  //     'currentPosition': currentPosition,
  //     'locURL': locURL,
  //     'streetName': streetName,
  //     'now': now,
  //     'type': type,
  //   });
  // }

  Future updateLocDataPer(String currentPosition, String locURL,
      String streetName, String now, String person) async {
    print("this shit ran");
    return await locDataCollection.document(now + ' ID ' + person).setData({
      'currentPosition': currentPosition,
      'locURL': locURL,
      'streetName': streetName,
      'now': now,
      'Person': person,
    });
  }

  Future updateLocDataPerOther(String otherPerson, String currentPosition,
      String locURL, String streetName, String now, String person) async {
    final CollectionReference otherP = Firestore.instance.collection(person);
    return await otherP.document(now + ' ID ' + person).setData({
      'currentPosition': currentPosition,
      'locURL': locURL,
      'streetName': streetName,
      'now': now,
      'Person': otherPerson,
    });
  }

  Future updateLocDataOtherppl(
      String ppl,
      String otherPerson,
      String currentPosition,
      String locURL,
      String streetName,
      String now,
      String person) async {
    final CollectionReference otherP =
        Firestore.instance.collection("person - $name");
    return await otherP.document(now + ' ID ' + person).setData({
      'currentPosition': currentPosition,
      'locURL': locURL,
      'streetName': streetName,
      'now': now,
      'Person': person,
    });
  }

  Future updateLocDataPublicPlc(now, place) async {
    final CollectionReference locDataCollection2 =
        Firestore.instance.collection('$name - $phone');
    return await locDataCollection2
        .document(now + ' ID ' + place)
        .setData({'now': now, 'public': place});
  }

  Future updateLocDataPublicPlcAll(now, place, pls) async {
    final CollectionReference locDataCollection2 =
        Firestore.instance.collection('plc - $name');
    return await locDataCollection2
        .document(now + ' ID ' + place)
        .setData({'now': now, 'public': place});
  }
}