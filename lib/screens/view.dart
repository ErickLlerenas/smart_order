// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database.dart';

class View extends StatefulWidget {
  View({Key? key, required this.food, required this.db}) : super(key: key);
  final Map food;
  final Database db;
  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sellerController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.food['name'];
    descController.text = widget.food['description'];
    priceController.text = widget.food['price'].toDouble().toString();
    sellerController.text = widget.food['seller'];
    imageController.text = widget.food['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(56, 75, 49, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(56, 75, 49, 1.0),
        title: const Text("Detalles"),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.db.delete(widget.food["id"]);
                Navigator.pop(context, true);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Country Name"),
                controller: nameController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Descripcion de comida"),
                controller: descController,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Precio de comida"),
                controller: priceController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("Vendedor"),
                controller: sellerController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: inputDecoration("link de imagen"),
                controller: imageController,
              ),
              const SizedBox(
                height: 20,
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
          child: RaisedButton(
              color: Colors.black,
              onPressed: () {
                widget.db.update(
                    widget.food['id'],
                    nameController.text,
                    descController.text,
                    double.parse(priceController.text),
                    sellerController.text,
                    imageController.text);
                Navigator.pop(context, true);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String labelText) {
    return InputDecoration(
      focusColor: Colors.white,
      labelStyle: const TextStyle(color: Colors.white),
      labelText: labelText,
      fillColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.white),
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
