import 'package:flutter/material.dart';

class Orders extends StatelessWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Wrap(
        children: [
          Container(
            width: width / 2,
            child: Card(
                child: Column(
              children: [
                Image.asset('assets/images/food1.jpeg'),
                const Text('Comida xd'),
                const Text('Precio \$123213 xd'),
              ],
            )),
          ),
          Container(
            width: width / 2,
            child: Card(
                child: Column(
              children: [
                Image.asset('assets/images/food1.jpeg'),
                const Text('Comida xd'),
                const Text('Precio \$123213 xd'),
              ],
            )),
          ),
          Container(
            width: width / 2,
            child: Card(
                child: Column(
              children: [
                Image.asset('assets/images/food1.jpeg'),
                const Text('Comida xd'),
                const Text('Precio \$123213 xd'),
              ],
            )),
          ),
          Container(
            width: width / 2,
            child: Card(
                child: Column(
              children: [
                Image.asset('assets/images/food1.jpeg'),
                const Text('Comida xd'),
                const Text('Precio \$123213 xd'),
              ],
            )),
          ),
        ],
      ),
    );
  }
}
