import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  List foods = [
    {
      "url": "assets/images/food1.jpeg",
      "name": "Sandwich de aguacate",
      "price": "\$50"
    },
    {
      "url": "assets/images/food2.jpeg",
      "name": "Ensalada César",
      "price": "\$80"
    },
    {
      "url": "assets/images/food3.jpeg",
      "name": "Pizza casera",
      "price": "\$129"
    },
    {
      "url": "assets/images/food1.jpeg",
      "name": "Sandwich de aguacate",
      "price": "\$50"
    },
    {
      "url": "assets/images/food2.jpeg",
      "name": "Ensalada César",
      "price": "\$80"
    },
    {
      "url": "assets/images/food3.jpeg",
      "name": "Pizza casera",
      "price": "\$129"
    },
  ];

  @override
  void initState() {
    getFoodFromFirebase();
    super.initState();
  }

  Future getFoodFromFirebase() async {
    // await Firebase.initializeApp();
    // QuerySnapshot query =
    //     await FirebaseFirestore.instance.collection('foods').get();
    // query.docs.forEach((food) {
    //   setState(() {
    //     foods.add(food.data());
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Wrap(
          children: foods
              .map(
                (food) => Container(
                  width: width / 2,
                  child: Card(
                      child: Column(
                    children: [
                      Image.asset(
                        food['url'],
                        width: width / 2,
                        height: width / 1.5,
                        fit: BoxFit.cover,
                      ),
                      Text("${food['name']}"),
                      Text(
                        "${food['price']}",
                        style: TextStyle(color: Colors.green, fontSize: 22),
                      ),
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {},
                          child: Text("Comprar"))
                    ],
                  )),
                ),
              )
              .toList()),
    ));
  }
}
