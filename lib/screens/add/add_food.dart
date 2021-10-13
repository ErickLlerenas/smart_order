// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database.dart';

class Add extends StatefulWidget {
  final Database db;
  Add({Key? key, required this.db}) : super(key: key);
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  bool isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Agregar nueva comida"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Nombre de comida"),
                controller: titleController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Descripcion de comida"),
                controller: descController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Precio de comida"),
                controller: priceController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 20,
              ),
             
              TextFormField(
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Link de imagen"),
                controller: imageController,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.transparent,
        child: BottomAppBar(
          color: Colors.transparent,
          child: isLoading ? LinearProgressIndicator(): ElevatedButton(
              onPressed: () async{
                  setState(() {
                    isLoading = true;
                  });
                  await widget.db.add(
                  id: '3121811727',
                  title: titleController.text,
                  description: descController.text,
                  image: imageController.text,
                  price: double.parse(priceController.text),
                );
                 setState(() {
                    isLoading = false;
                  });
                Navigator.pop(context, true);
              },
              
              child: const Text(
                "Agregar comida",
                style: TextStyle(color: Colors.white,fontSize: 18),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.black,
      labelStyle: const TextStyle(color: Colors.black),
      labelText: labelText,
      fillColor: Colors.black,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.black),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
    );
  }
}
