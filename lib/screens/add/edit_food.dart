// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../database.dart';

class EditFood extends StatefulWidget {
  EditFood(
      {Key? key, required this.food, required this.db, required this.index})
      : super(key: key);
  final Map food;
  final Database db;
  final int index;
  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    titleController.text = widget.food['title'];
    descController.text = widget.food['description'];
    priceController.text = widget.food['price'].toDouble().toString();
    imageController.text = widget.food['image'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Editar"),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                widget.db.delete(id: '3121811727', index: widget.index);
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
                style: const TextStyle(color: Colors.black),
                decoration: inputDecoration("Country Name"),
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
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
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
          child: ElevatedButton(
              onPressed: () {
                widget.db.update(
                    id: '3121811727',
                    title: titleController.text,
                    description: descController.text,
                    price: double.parse(priceController.text),
                    image: imageController.text,
                    index: widget.index);
                Navigator.pop(context, true);
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.black),
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
