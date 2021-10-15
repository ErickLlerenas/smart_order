import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:smart_order/helpers/database.dart';
import 'package:smart_order/providers/app_provider.dart';
import 'package:smart_order/screens/add/add_food.dart';
import 'package:smart_order/screens/add/edit_food.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  Database db = Database();
  List foods = [];
  String phone = "";
  initialise(String id) {
    db.initiliase();
    db.read(id).then((value) {
      setState(() {
        foods = value;
      });
    });
  }

  @override
  void initState() {
    phone = Provider.of<AppProvider>(context, listen: false).phone;
    super.initState();
    initialise(phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Column(
              children:
                  foods.map((food) => Food(foods: food['foods'],db:db)).toList())),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor:Colors.orange,
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) {
            if (value != null) {
              initialise(phone);
            }
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Food extends StatelessWidget {
  final List foods;
  final dynamic db;

  const Food({
    Key? key,
    required this.foods,
    required this.db,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Wrap(
        children: foods
            .asMap().map((index, food) => MapEntry(index,GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>EditFood(food: food, db: db,index:index)));
                },
                child: Container(
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
                            Text("${food['title']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            Text("${food['description']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 18)),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "\$${food['price'].toDouble()}",
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
              ),
            )
            ).values.toList());
  }
}

