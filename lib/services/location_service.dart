import 'dart:async';

import 'package:location/location.dart';
import 'package:flutter_client_php_backend/models/Point.dart';

class LocationService {
  Point _currentLocation;
  var location = Location();
  Future<Point> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = Point(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } on Exception catch (e) {
      print('Could not get location: ${e.toString()}');
    }
    return _currentLocation;
  }

  StreamController<Point> _locationController =
  StreamController<Point>();
  Stream<Point> get locationStream => _locationController.stream;
  LocationService() {
    // Request permission to use location
    location.requestPermission().then((granted) {
      if (granted) {
        // If granted listen to the onLocationChanged stream and emit over our controller
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(Point(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
            ));
          }
        });
      }
    });
  }
}