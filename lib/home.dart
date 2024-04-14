import 'package:avatar_glow/avatar_glow.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuelfinder/google_map.dart';
import 'package:fuelfinder/main.dart';
import 'package:fuelfinder/map_utils.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("users");
  bool _isService = false;
  bool _islocationOn = false;
  double latitude = 0.000;
  double longitude = 0.000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Fuel Finder",
        ),
        titleTextStyle: TextStyle(
            fontSize: 36, fontWeight: FontWeight.w600, color: Colors.black),
        centerTitle: true,
        leading: const Text(""),
        backgroundColor: Colors.yellow,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hello, ${prefs.getString("name")!}",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 300,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset("assets/images/homebanner.png"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            _islocationOn
                ? Text(
                    "Location\nLat : ${latitude.toString()}\nLong : ${longitude.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline),
                  )
                : Text(
                    "1.Get Current Location.\n2.Find nearby Petrol Station.\n3.Use Location to pinpoint in Google Map.",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  _isService = false;
                  _islocationOn = !_islocationOn;
                  latitude = 0.00;
                  longitude = 0.00;
                });
                await _determinePosition().then((value) {
                  setState(() {
                    print(value.latitude);
                    _isService = !_isService;
                    latitude = value.latitude;
                    longitude = value.longitude;
                  });
                });
                await ref.push().set({
                  'name': prefs.getString("name"),
                  'number': prefs.getString("number"),
                  "latitude": latitude,
                  "longitude": longitude
                }).then((_) {
                  print('Data added to Realtime Database');
                }).catchError((error) {
                  print('Failed to add data to Realtime Database: $error');
                });
              },
              child: _islocationOn
                  ? AvatarGlow(
                      glowRadiusFactor: 1,
                      startDelay: const Duration(milliseconds: 1000),
                      glowColor: Colors.yellow,
                      glowShape: BoxShape.circle,
                      animate: true,
                      curve: Curves.bounceInOut,
                      child: const Material(
                        elevation: 8.0,
                        shape: CircleBorder(),
                        color: Colors.yellow,
                        child: Icon(
                          Icons.my_location_sharp,
                          size: 80,
                        ),
                      ),
                    )
                  : Icon(
                      Icons.my_location_rounded,
                      size: 80,
                    ),
            ),
            SizedBox(
              height: 50,
            ),
            _isService
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Google_Map(
                                      lat: latitude,
                                      long: longitude,
                                    ))),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow),
                          child: const Center(
                              child: Text(
                            "Google Map",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Maptutils.openmap(
                            latitude.toString(), longitude.toString()),
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.yellow),
                          child: const Center(
                              child: Text(
                            "Petrol Station",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          )),
                        ),
                      )
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
