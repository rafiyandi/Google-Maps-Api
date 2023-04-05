import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 5.357765007679426, 95.96200412616079
  // -6.1670954926426145, 106.7974031532054  leumart

  Completer<GoogleMapController> _controller = Completer();
  // LatLng latLang = LatLng(5.357765007679426, 95.96200412616079);
  static final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(-6.1670954926426145, 106.7974031532054), zoom: 14);
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
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: const LatLng(-6.1670954926426145, 106.7974031532054),
            draggable: true,
            onDragEnd: (value) {
              // value is the new position
            },
            // icon: markerIcon,
          ),
        },
      ),
    );
  }
}
