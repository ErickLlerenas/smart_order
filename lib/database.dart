import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Database {
  late FirebaseFirestore firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String desc, double price, String seller,
      String image) async {
    var locationMessage = "";
    var addr = "";
    var addr1 = "";
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();

    var lat = position.latitude;
    var longi = position.longitude;

    final coordinates = GeoPoint(lat, longi);

    try {
      await firestore.collection("foods").add({
        'name': name,
        'description': desc,
        'price': price,
        'seller': seller,
        'image': image,
        'location': coordinates
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore.collection("foods").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot = await firestore.collection('foods').get();
      print("jala");
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "name": doc['name'],
            "description": doc["description"],
            "price": doc["price"].toString(),
            "seller": doc["seller"],
            "image": doc["image"]
          };
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<void> update(String id, String name, String desc, double price,
      String seller, String image) async {
    try {
      await firestore.collection("foods").doc(id).update({
        'name': name,
        'description': desc,
        'price': price,
        'seller': seller,
        'image': image
      });
    } catch (e) {
      print(e);
    }
  }
}
