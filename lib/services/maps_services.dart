import 'dart:convert';
import 'package:eatopia_refactored/config.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class MapsServices with ChangeNotifier {
  // SharedPreferences? prefs;
  bool _isLocationEnabled = false;
  bool _isLocationPermissionGranted = false;
  bool get isLocationEnabled => _isLocationEnabled;
  bool get isLocationPermissionGranted => _isLocationPermissionGranted;
  Future<LatLng> getCurrentLocation() async {
    _isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isLocationEnabled) {
      Geolocator.openLocationSettings();
      if (!await Geolocator.isLocationServiceEnabled()) {
        return const LatLng(0, 0);
      }
      // Location services are disabled, show an error message
      _isLocationEnabled = true;
    }

    // Check if the app has permission to access location
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // Permission to access location is denied forever, show an error message
      return const LatLng(0, 0);
    }

    if (permission == LocationPermission.denied) {
      // Request permission to access location
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // Permission to access location is denied, show an error message
        return const LatLng(0, 0);
      }
      _isLocationPermissionGranted = true;
    }

    // Get the user's current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    LatLng currentLocation = LatLng(position.latitude, position.longitude);

    // List<Placemark> place =
    //     await placemarkFromCoordinates(position.latitude, position.longitude);

    // print(
    //     '${place[0].street}, ${place[0].subLocality}, ${place[0].subAdministrativeArea}');
    final response = await http.get(Uri.parse(
        'https://api.mapbox.com/geocoding/v5/mapbox.places/${currentLocation.longitude},${currentLocation.latitude}.json?country=pk&access_token=${Secrets.mapBoxPublicKey}'));
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final place = data['features'][0]['place_name'] as String;
    if (kDebugMode) {
      print(place);
    }
    return currentLocation;
  }
}
