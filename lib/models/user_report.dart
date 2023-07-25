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
  String? photoURL;

  UserReport(
      {this.date,
      this.geopoint,
      this.geohash,
      this.observation,
      this.species,
      this.observationNumber,
      this.waterColor,
      this.waterTemp,
      this.photoURL});

  factory UserReport.fromFirestore(Map post) {
    // ToDo: calculate geohash here using geoflutterfire package.

    return UserReport(
      geopoint: post['geopoint'],
      date: post['date'].toDate(),
      observation: post['observation'],
      species: post['species'],
      observationNumber: post['observation_number'],
      waterColor: post['water_color'],
      waterTemp: post['water_temp'],
      photoURL: post['photo_url']
    );
  }

  List<String> csvHeaderList() {
    return [
      'observation',
      'species',
      'number',
      'water temperature',
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
      '$date',
      '${geopoint?.latitude},${geopoint?.longitude}'
    ];
  }
}
