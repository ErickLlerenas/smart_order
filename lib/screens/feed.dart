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
        body: SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
            children: foods
                .map(
                  (food) => Container(
                    width: width,
                    child: Card(
                        child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: EdgeInsets.all(12),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                food['image'],
                                width: 200,
                                height: 115,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("${food['name']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22)),
                              Text("${food['description']}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18)),
                              Text(
                                "\$${food['price']}",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
                  ),
                )
                .toList()),
      ),
    ));
  }
}
