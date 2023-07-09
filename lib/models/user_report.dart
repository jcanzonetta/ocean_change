import 'package:cloud_firestore/cloud_firestore.dart';

class UserReport {
  DateTime? date;
  GeoPoint? geopoint;
  String? geohash;
  String? observation;
  String? waterColor;
  num? waterTemp;
  String? photoURL;

  UserReport(
      {this.date,
      this.geopoint,
      this.geohash,
      this.observation,
      this.waterColor,
      this.waterTemp,
      this.photoURL});

  factory UserReport.fromFirestore(Map post) {
    // ToDo: calculate geohash here using geoflutterfire package.

    return UserReport(
      date: post['date'].toDate(),
      geopoint: post['geopoint'],
      observation: post['observation'],
      waterColor: post['water_color'],
      waterTemp: post['water_temp'],
    );
  }
}
