import 'package:flutter/material.dart';

class FoodInfo extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final double price;

  const FoodInfo(
      {Key? key,
      required this.description,
      required this.image,
      required this.title,
      required this.price})
      : super(key: key);

  @override
  _FoodInfoState createState() => _FoodInfoState();
}

class _FoodInfoState extends State<FoodInfo> {
  int counter = 0;

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
                                if (counter >= 1) counter--;
                              });
                            },
                            child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.remove)),
                          ),
                        ),
                      ),
                      Text(counter.toString()),
                      ClipOval(
                        child: Material(
                          color: Colors.grey[200], // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              setState(() {
                                if (counter < 10) counter++;
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
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    onPressed: () {},
                    child: Text('Realizar pedido')),
              )
            ],
          )
        ],
      ),
    );
  }
}
