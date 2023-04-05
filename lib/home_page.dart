import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 5.357765007679426, 95.96200412616079
  // -6.167170164502122, 106.79744070737434  leumart
  // -6.167139497610282, 106.79741790860008 dekat leu

  Completer<GoogleMapController> _controller = Completer();
  List<Marker> _markers = <Marker>[];
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(5.357765007679426, 95.96200412616079), zoom: 14);
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print("error" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        compassEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_markers),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("my current user");
          getUserCurrentLocation().then(
            (value) async {
              _markers.add(
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(value.latitude, value.longitude),
                  draggable: true,
                  infoWindow: InfoWindow(title: "My Current User"),
                  onDrag: (value) {
                    print(
                        "ini geser lat ${value.latitude} dan geser ${value.longitude}");
                  },
                ),
              );
              CameraPosition cameraPosition = CameraPosition(
                  target: LatLng(value.latitude, value.longitude), zoom: 14);
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              print("ini lat ${value.latitude} dan long ${value.longitude}");
              setState(() {});
            },
          );
        },
        child: Icon(Icons.search),
      ),
    );
  }
}
