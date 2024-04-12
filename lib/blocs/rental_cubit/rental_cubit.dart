import '../../data/model/rental.dart';
import '../../util/shared_pref_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightModelCubit extends Cubit<List<FlightModel>> {
  final SharedPreferencesService _sharedPreferencesService;

  FlightModelCubit(this._sharedPreferencesService) : super([]);

  void _loadRentedBoat() async {
    final rentedBoat = await _sharedPreferencesService.getRentedBoat();
    emit(rentedBoat);
  }

  void addFlightModel(FlightModel newFlight) async {
    final List<FlightModel> updatedList = List.from(state)..add(newFlight);
    emit(updatedList);
    await _sharedPreferencesService.saveRentedBoat(updatedList);
  }

  void updateRentedBoatList(int index, FlightModel updatedFlightModel) async {
    final List<FlightModel> currentList = List.from(state);
    if (index >= 0 && index < currentList.length) {
      currentList[index] = updatedFlightModel;
      emit(currentList);
      await _sharedPreferencesService.saveRentedBoat(currentList);
    }
  }

  void deleteFlightModel(FlightModel rental) async {
    final List<FlightModel> updatedList = List.from(state)..remove(rental);
    emit(updatedList);
    await _sharedPreferencesService.saveRentedBoat(updatedList);
  }
}
