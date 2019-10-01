import 'package:json_annotation/json_annotation.dart';

part 'Point.g.dart';

@JsonSerializable()
class Point extends Object with _$PointSerializerMixin {
  final double latitude;
  final double longitude;

  Point(
      {this.latitude,
        this.longitude});

  factory Point.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

