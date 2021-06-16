import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List comidas = [1, 2, 3, 4, 5, 6];
    return Scaffold(
        body: Wrap(
            children: comidas
                .map(
                  (e) => Container(
                    width: width,
                    child: Card(
                        child: Column(
                      children: [
                        Image.asset('assets/images/food1.jpeg'),
                        const Text('Comida xd'),
                        const Text('Precio \$123213 xd'),
                      ],
                    )),
                  ),
                )
                .toList()));
  }
}
