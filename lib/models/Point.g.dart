// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Point.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Point _$UserFromJson(Map<String, dynamic> json) => new Point(
    latitude: json['latitude'] as double,
    longitude: json['longitude'] as double);

abstract class _$PointSerializerMixin {
  double get latitude;

  double get longitude;

  Map<String, dynamic> toJson() => <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude
  };
}
