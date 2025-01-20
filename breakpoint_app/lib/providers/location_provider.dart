import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../model/LocationModel.dart';

class LocationProvider with ChangeNotifier {
  LocationModel? selectedLocation;
  bool isWithinRadius = false;

  void setSelectedLocation(LocationModel location) {
    selectedLocation = location;
    notifyListeners();
  }

  Future<void> checkProximity() async {
    if (selectedLocation == null) return;

    Position currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      selectedLocation!.latitude,
      selectedLocation!.longitude,
    );

    isWithinRadius = distance <= 100; // Verifica se está dentro de 100 metros
    notifyListeners();
  }
}
