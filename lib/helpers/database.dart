import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Database {
  
  late var firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> add(
      {required String id,
      required String title,
      required String description,
      required double price,
      required String image}) async {
    try {
      var food = {
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'rate': 0
      };
      List sellers = await read(id);
      List foods = sellers[0]["foods"];
      foods.add(food);
      await firestore.collection("sellers").doc(id).update({'foods': foods});
    } catch (e) {
      print(e);
    }
  }

  Future<void> createOrder(
      {required String sellerID,
      required String userID,
      required Map food,
      required int amount}) async {
    try {
      DocumentSnapshot seller =
          await firestore.collection("orders").doc(sellerID).get();
      List orders = [];
      if (seller.exists) {
        orders = seller['orders'];
        orders.add({
          'food': food,
          'user_id': userID,
          'amount': amount,
          'state': {'accepted': false, 'canceled': false, 'finished': false}
        });

        await firestore
            .collection("orders")
            .doc(sellerID)
            .update({'orders': orders});
      } else {
        orders.add({
          'food': food,
          'user_id': userID,
          'amount': amount,
          'state': {'accepted': false, 'canceled': false, 'finished': false}
        });

        await firestore
            .collection("orders")
            .doc(sellerID)
            .set({'orders': orders});
      }
    } catch (e) {
      print("$e");
    }
  }

  Future<void> update(
      {required String id,
      required String title,
      required String description,
      required double price,
      required String image,
      required int index}) async {
    try {
      var food = {
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'rate': 0
      };
      List sellers = await read(id);
      List foods = sellers[0]["foods"];
      foods.removeAt(index);
      foods.insert(index, food);
      await firestore.collection("sellers").doc(id).update({'foods': foods});
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete({required String id, required int index}) async {
    try {
      List sellers = await read(id);
      List foods = sellers[0]["foods"];
      foods.removeAt(index);
      await firestore.collection("sellers").doc(id).update({'foods': foods});
    } catch (e) {
      print(e);
    }
  }

  Future<List> read(String id) async {
    List docs = [];
    try {
      DocumentSnapshot seller =
          await firestore.collection('sellers').doc(id).get();
      if (seller.exists) {
        Map sellers = {
          "foods": seller['foods'],
          "name": seller['name'],
          "location": seller["location"]
        };
        docs.add(sellers);

        return docs;
      } else {}
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<void> setLocation({required String id}) async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var lat = position.latitude;
      var long = position.longitude;

      final location = new GeoPoint(lat, long);

      await firestore
          .collection("sellers")
          .doc(id)
          .update({'location': location});
    } catch (e) {
      print(e);
    }
  }


  Future getUserData (bool isUser,String phone) async{
    DocumentSnapshot document =  await firestore.collection(isUser?"users":"sellers").doc(phone).get();
    return document.data();
  }

}
