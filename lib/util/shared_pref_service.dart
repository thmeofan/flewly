import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/flight_model.dart';

class SharedPrefService {
  static const String _flightListKey = 'flight_list';

  Future<void> saveFlightList(List<FlightModel> flightList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> flightJsonList =
        flightList.map((flight) => json.encode(flight.toJson())).toList();
    await prefs.setStringList(_flightListKey, flightJsonList);
  }

  Future<List<FlightModel>> getFlightList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? flightJsonList = prefs.getStringList(_flightListKey);
    if (flightJsonList != null) {
      return flightJsonList
          .map((jsonString) => FlightModel.fromJson(json.decode(jsonString)))
          .toList();
    }
    return [];
  }
}
