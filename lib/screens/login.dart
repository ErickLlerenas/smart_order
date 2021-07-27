import 'package:flutter/material.dart';
import 'package:smart_order/screens/home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => const Home()));
        },
        child: const Text("Iniciar Sesión"),
      )),
    );
  }
}
