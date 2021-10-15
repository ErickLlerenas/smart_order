import 'package:flutter/material.dart';
import 'package:smart_order/screens/home.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.blue,
            child: SizedBox(
              height: height / 2,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Smart Order",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 36)),
                    SizedBox(height: 10),
                    Text("Iniciar Sesión",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 24))
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(50),
            child: Column(
              children: [
                
                SizedBox(height: 30),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Ingresa numero",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  validator: (val) {
                    if (val?.length == 0) {
                      return "Por favor ingresa el numero";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 50)),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Home()));
                    },
                    child: Text("Iniciar Sesión")),
                SizedBox(height: 15),
                Text("¿No tienes cuenta?"),
                Text(
                  "Registrate aquí",
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
