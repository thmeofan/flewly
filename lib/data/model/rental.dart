class FlightModel {
  final String date;
  final double flightNumber;
  final double travelBudget;
  final String destination;
  final String comment;
  final FlightType flightType;

  FlightModel({
    this.travelBudget = 0,
    this.date = '',
    this.flightNumber = 0.0,
    this.destination = '',
    this.comment = '',
    this.flightType = FlightType.vacation,
  });

  FlightModel copyWith({
    String? date,
    double? flightNumber,
    double? travelBudget,
    String? destination,
    String? comment,
    FlightType? flightType,
  }) {
    return FlightModel(
      date: date ?? this.date,
      flightNumber: flightNumber ?? this.flightNumber,
      travelBudget: travelBudget ?? this.travelBudget,
      destination: destination ?? this.destination,
      comment: comment ?? this.comment,
      flightType: flightType ?? this.flightType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'flightNumber': flightNumber,
      'travelBudget': travelBudget,
      'destination': destination,
      'comment': comment,
      'flightType': flightType.name,
    };
  }

  factory FlightModel.fromJson(Map<String, dynamic> json) {
    return FlightModel(
      date: json['date'],
      flightNumber: (json['flightNumber'] as num).toDouble(),
      travelBudget: (json['travelBudget'] as num).toDouble(),
      destination: json['destination'],
      comment: json['comment'],
      flightType: FlightType.values.byName(json['flightType']),
    );
  }
}

enum FlightType { vacation, work, other }
