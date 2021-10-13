import 'package:flutter/material.dart';
import 'package:smart_order/database.dart';

class FoodInfo extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final double price;
  final String sellerID;

  const FoodInfo(
      {Key? key,
      required this.description,
      required this.sellerID,
      required this.image,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  _FoodInfoState createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  int amount = 1;

  bool isLoading = false;

  Database db = Database();
  List foods = [];
  initialise() {
    db.initiliase();
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.image,
            width: width,
            height: width / 1.25,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  widget.description,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                        child: Material(
                          color: Colors.grey[200], // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              setState(() {
                                if (amount > 1) amount--;
                              });
                            },
                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.remove)),
                          ),
                        ),
                      ),
                      Text(amount.toString()),
                      ClipOval(
                        child: Material(
                          color: Colors.grey[200], // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              setState(() {
                                if (amount < 10) amount++;
                              });
                            },
                            child: SizedBox(
                                width: 56, height: 56, child: Icon(Icons.add)),
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: isLoading ? LinearProgressIndicator() : ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () async{
                      setState(() {
                        isLoading = true;
                      });
                      await db.createOrder(
                          userID: '3121811727',
                          sellerID: widget.sellerID,
                          food: {
                            'title': widget.title,
                            'description': widget.description,
                            'image': widget.image,
                            'price': widget.price,
                          },
                          amount: amount);
                       setState(() {
                        isLoading = false;
                      });
                      Navigator.pop(context);
                    },
                    child: Text('Realizar pedido')),
              )
            ],
          )
        ],
      ),
    );
  }
}
