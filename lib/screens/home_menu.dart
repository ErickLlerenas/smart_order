import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  List foods = [];

  @override
  void initState() {
    getFoodFromFirebase();
    super.initState();
  }

  Future getFoodFromFirebase() async {
    await Firebase.initializeApp();
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('foods').get();
    query.docs.forEach((food) {
      setState(() {
        foods.add(food.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Wrap(
            children: foods
                .map(
                  (food) => Container(
                    width: width,
                    child: Card(
                        child: Column(
                      children: [
                        Image.network(food['image']),
                        Text(food['name']),
                        Text(food['price'].toString()),
                      ],
                    )),
                  ),
                )
                .toList()));
  }
}
