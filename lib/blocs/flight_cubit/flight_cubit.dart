import '../../data/model/flight_model.dart';
import '../../util/shared_pref_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlightCubit extends Cubit<List<FlightModel>> {
  final SharedPrefService sharedPrefService;

  FlightCubit(this.sharedPrefService) : super([]) {
    loadFlights();
  }

  void updateFlight(FlightModel newFlightModel, {bool isNewFlight = false}) {
    List<FlightModel> updatedList = [...state];
    if (isNewFlight) {
      updatedList.add(newFlightModel);
    } else {
      int index = updatedList
          .indexWhere((flight) => flight.date == newFlightModel.date);
      if (index != -1) {
        updatedList[index] = newFlightModel;
      }
    }
    sharedPrefService.saveFlightList(updatedList);
    emit(updatedList);
  }

  void resetFlights() {
    sharedPrefService.saveFlightList([]);
    emit([]);
  }

  void loadFlights() async {
    List<FlightModel> flightList = await sharedPrefService.getFlightList();
    emit(flightList);
  }

  void deleteFlight(FlightModel flightToDelete) {
    List<FlightModel> updatedList = [...state];
    updatedList.removeWhere((flight) => flight.date == flightToDelete.date);
    sharedPrefService.saveFlightList(updatedList);
    emit(updatedList);
  }
}
