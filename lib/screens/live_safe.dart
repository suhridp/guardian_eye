import 'package:flutter/material.dart';
import 'package:guardian_eye/LiveSafeSpots/BusStationCard.dart';
import 'package:guardian_eye/LiveSafeSpots/HospitalCard.dart';
import 'package:guardian_eye/LiveSafeSpots/PharmacyCard.dart';
import 'package:guardian_eye/LiveSafeSpots/PoliceStationCard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: [
            HospitalCard(openMapFunc: openMap),
            PoliceStationCard(openMapFunc: openMap),
            PharmacyCard(openMapFunc: openMap),
            BusStationCard(openMapFunc: openMap)
          ]),
    );
  }

  static Future<void> openMap(String location) async {
    // Properly format the URL using Uri class
    Uri googleUrl =
        Uri.parse('https://www.google.com/maps/search/?api=1&query=$location');

    // Check if the URL can be launched before attempting to launch it
    if (await canLaunchUrl(googleUrl)) {
      try {
        await launchUrl(googleUrl);
      } catch (e) {
        // Handle the exception and show a message
        print(e);
        Fluttertoast.showToast(
          msg: "Something went wrong! Call emergency numbers.",
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      // If the URL cannot be launched, throw an error or show a message
      Fluttertoast.showToast(
        msg: "Could not open the map. Please try again later.",
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
