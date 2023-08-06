import 'package:cloud_firestore/cloud_firestore.dart';

class UserReport {
  DateTime? date;
  GeoPoint? geopoint;
  String? geohash;
  String? observation;
  String? species;
  num? observationNumber;
  String? waterColor;
  num? waterTemp;
  bool? temperatureBreak;
  String? photoURL;
  String? user;
  String? id;
  UserReport(
      {this.date,
      this.geopoint,
      this.geohash,
      this.observation,
      this.species,
      this.observationNumber,
      this.waterColor,
      this.waterTemp,
      this.temperatureBreak,
      this.photoURL,
      this.user,
      this.id});

  factory UserReport.fromFirestore(Map post, String id) {
    return UserReport(
        geopoint: post['geopoint'],
        date: post['date'].toDate(),
        observation: post['observation'],
        species: post['species'],
        observationNumber: post['observation_number'],
        waterColor: post['water_color'],
        waterTemp: post['water_temp'],
        temperatureBreak: post['temperature_break'],
        photoURL: post['photo_url'],
        user: post['user'],
        id: id);
  }

  List<String> csvHeaderList() {
    return [
      'observation',
      'species',
      'number',
      'water temperature',
      'water color',
      'temperatuse break',
      'date',
      'location'
    ];
  }

  List<String> toCSVList() {
    return [
      '$observation',
      '$species',
      '$observationNumber',
      '$waterTemp',
      '$waterColor',
      '$temperatureBreak',
      '$date',
      '${geopoint?.latitude},${geopoint?.longitude}'
    ];
  }
}
