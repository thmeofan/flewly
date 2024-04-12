import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/model/rental.dart';

class SharedPreferencesService {
  static const String _rentedBoatKey = 'flights';

  Future<void> saveRentedBoat(List<FlightModel> rentedBoat) async {
    final prefs = await SharedPreferences.getInstance();
    final rentedBoatJson =
        jsonEncode(rentedBoat.map((vm) => vm.toJson()).toList());
    await prefs.setString(_rentedBoatKey, rentedBoatJson);
  }

  Future<List<FlightModel>> getRentedBoat() async {
    final prefs = await SharedPreferences.getInstance();
    final rentedBoatJson = prefs.getString(_rentedBoatKey);
    if (rentedBoatJson != null) {
      final List<dynamic> rentedBoatList = jsonDecode(rentedBoatJson);
      return rentedBoatList.map((json) => FlightModel.fromJson(json)).toList();
    }
    return [];
  }
}
