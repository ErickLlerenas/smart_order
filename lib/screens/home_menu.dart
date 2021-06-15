import 'package:flutter/material.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Wrap(
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
      ),
    );
  }
}
