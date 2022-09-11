import 'package:json_annotation/json_annotation.dart';
import './location_fact.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String name;
  final String url;
  final List<LocationFact>
      facts; //variable is facts[i] of type Class LocationFact

  Location(
      {required this.name,
      required this.url,
      required this.facts}); // Constructor

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
