import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List comidas = [
      {
        "url": "assets/images/food1.jpeg",
        "name": "Sandwich de aguacate",
        "price": "Precio \$50"
      },
      {
        "url": "assets/images/food2.jpeg",
        "name": "Ensalada César",
        "price": "Precio \$80"
      },
      {
        "url": "assets/images/food3.jpeg",
        "name": "Pizza casera",
        "price": "Precio \$129"
      },
      {
        "url": "assets/images/food1.jpeg",
        "name": "Sandwich de aguacate",
        "price": "Precio \$50"
      },
      {
        "url": "assets/images/food2.jpeg",
        "name": "Ensalada César",
        "price": "Precio \$80"
      },
      {
        "url": "assets/images/food3.jpeg",
        "name": "Pizza casera",
        "price": "Precio \$129"
      },
    ];
    return Scaffold(
        body: SingleChildScrollView(
      child: Wrap(
          children: comidas
              .map(
                (e) => Container(
                  width: width / 2,
                  child: Card(
                      child: Column(
                    children: [
                      Image.asset(
                        e['url'],
                        width: width / 2,
                        height: width / 1.5,
                        fit: BoxFit.cover,
                      ),
                      Text("${e['name']}"),
                      Text("${e['price']}"),
                    ],
                  )),
                ),
              )
              .toList()),
    ));
  }
}
