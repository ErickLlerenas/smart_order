// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late BitmapDescriptor pinLocationIcon;

  List sellers = [];
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> myMarker = [];
  var userLocation = LatLng(12, -141);

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.242962, -108.719511),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    getSellersFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          currentCamera();
        },
        markers: Set.from(myMarker),
      ),
    );
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(12, 12)),
        '../../assets/images/icono-circulo.png');
  }

  Future getSellersFood() async {
    await Firebase.initializeApp();
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('sellers').get();
    query.docs.forEach((seller) {
      print(seller["location"]);
      if (mounted) {
        GeoPoint pos = seller["location"];
        LatLng latLng = new LatLng(pos.latitude, pos.longitude);

        myMarker.add(
          Marker(
            markerId: MarkerId(seller['name']),
            position: latLng,
          ),
        );
      }
    });

    setState(() {});
  }

  void currentCamera() async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // var lastPosition = await Geolocator.getLastKnownPosition();

    CameraPosition newCamera = CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 14.4746,
    );
    final GoogleMapController controller = await _controller.future;
    if (mounted) {
      setState(() {
        myMarker.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: LatLng(position.latitude, position.longitude),
            infoWindow: const InfoWindow(title: "Tu ubicacion", snippet: ''),
          ),
        );
      });
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(newCamera));
  }
}
