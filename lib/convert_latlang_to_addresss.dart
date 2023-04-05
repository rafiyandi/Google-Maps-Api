import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String address = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(address),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () async {
              // 5.357765007679426, 95.96200412616079
              // -6.1670954926426145, 106.7974031532054
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  -6.1670954926426145, 106.7974031532054);
              var second = placemarks.last;
              print("kambing ${second.name}");
              setState(() {
                address = second.country.toString() +
                    " " +
                    second.administrativeArea.toString() +
                    " " +
                    second.subAdministrativeArea.toString() +
                    second.locality.toString() +
                    " Kecamatan " +
                    second.subLocality.toString();
              });
            },
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(color: Colors.amber),
              child: Center(
                  child: Text(
                "Convert",
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
