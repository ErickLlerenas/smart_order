import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_order/providers/app_provider.dart';
import 'package:provider/provider.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List orders = [];
  String phone = "";
  @override
  void initState() {
    phone = Provider.of<AppProvider>(context, listen: false).phone;
    getOrders(phone);
    super.initState();
   }

  Future getOrders(String phone) async {
    await Firebase.initializeApp();
    DocumentSnapshot seller =
        await FirebaseFirestore.instance.collection('orders').doc(phone).get();
      if(mounted){
        if(seller.exists){
         setState(() {
            orders = seller['orders'];
         });
        } 
      }

  }

  @override
  Widget build(BuildContext context) {
            double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: Wrap(
        children: orders
            .map(
              (order) => GestureDetector(
                onTap: () {
                 
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
                              order['food']['image'],
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
                            Text("${order['food']['title']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22)),
                            Text("${order['food']['description']}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18)),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "\$${order['food']['price'].toDouble()}",
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
            .toList())
      ),
    ));
  }
}

