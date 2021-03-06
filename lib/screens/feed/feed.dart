import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_order/screens/feed/food_info.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  List sellers = [];
  bool isLoading = true;

  @override
  void initState() {
    getSellersFood();
    super.initState();
  }

  Future getSellersFood() async {
    await Firebase.initializeApp();
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('sellers').get();
    query.docs.forEach((seller) {
      if(mounted){
        setState(() {
        isLoading = false;
        sellers.add(seller.data());
      });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading ? Center(child: CircularProgressIndicator(),): SafeArea(
          child: SingleChildScrollView(
              child: Column(
          children: sellers.map((seller) => Food(foods: seller['foods'],sellerID:seller['id'])).toList()),
            ),
        ));
  }
}

class Food extends StatelessWidget {
  final List foods;
  final String sellerID;

   const Food({
    Key? key,
    required this.foods,
    required this.sellerID
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width;

    return Wrap(
        children: foods
            .map(
              (food) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FoodInfo(
                              sellerID: sellerID,
                              image: food['image'],
                              title: food['title'],
                              description: food['description'],
                              price: food['price'].toDouble())));
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                            Text("${food['description']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
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
            .toList());
  }
}
