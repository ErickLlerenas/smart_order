import 'dart:ffi';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import '../../database.dart';

class Profile extends StatefulWidget {
  final Database db;
  Profile({Key? key, required this.db}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Tu perfil"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: BottomAppBar(
            color: Colors.transparent,
            child: ElevatedButton(
                onPressed: () async {
                  await widget.db.setLocation(
                    id: '3121811727',
                  );
                },
                child: const Text(
                  "Establecer ubicacion actual",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
          ),
        ),
      ),
    );
  }
}
