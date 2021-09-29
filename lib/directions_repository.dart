import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap_implementation/directions_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class DirectionsRepository {
  Future<Directions> getDirections({
    @required LatLng origin,
    @required LatLng destination,
  }) async {
    // final response = await _dio.get(
    //   _baseUrl,
    //   queryParameters: {
    //     'origin': '${origin.latitude},${origin.longitude}',
    //     'destination': '${destination.latitude},${destination.longitude}',
    //     'key': "AIzaSyBpHijNV4EjlKMr6IsP-NFSD8ZT5x6OMig",
    //   },
    // );

    String urlQuery =
        "https://api-gateway-dev.dukaanapp.pk/maps/api/directions/json?origin=" +
            origin.latitude.toString() +
            "," +
            origin.longitude.toString() +
            "&destination=" +
            destination.latitude.toString() +
            "," +
            destination.longitude.toString() +
            // "&waypoints=via:" +
            // storeWayPoints +
            "&mode=driving&avoidHighways=false&avoidFerries=true&avoidTolls=false";
    Response response = await http.get(urlQuery).timeout(Duration(seconds: 20));

    print(urlQuery);
    print('------response');
    print(response);
    // Check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(jsonDecode(response.body));
    }
    return null;
  }
}
