import 'package:flutter/material.dart';
import 'package:smart_order/providers/login_provider.dart';
import 'package:smart_order/screens/login/pin_code_verification.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height / 10),
                Container(
                  margin: EdgeInsets.all(width / 10),
                  child: Center(
                    child: Image.asset('assets/images/bg.png'),
                  ),
                ),
                Text("Hola,",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
                Text("Bienvenido a Smart Order",
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 24,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center),
                Container(
                  margin: EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Form(
                        key:_formKey,
                        child: TextFormField(
                          controller: phoneController,
                          decoration: new InputDecoration(

                            labelText: "Número de teléfono",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: new BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if (val?.length == 0) {
                              return "Ingresa un número de teléfono";
                            } else if(val?.length!=10){
                              return "El número debe tener 10 dígitos";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.number,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        ),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              minimumSize: Size(double.infinity, 50)),
                          onPressed: () async{
                             if (_formKey.currentState!.validate()) {
                           
                               //TODO: Crear el registro de login y ver si jala
                               context.read<LoginProvider>().verifyCode(phoneController.text);
                                Navigator.pop(context);
                               Navigator.push(context,
                                MaterialPageRoute(builder: (_) => PinCodeVerificationScreen(phoneController.text)));
                             }  
                            
                          },
                          child: Text("Verificar teléfono",style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300))),
                      SizedBox(height: 15),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
