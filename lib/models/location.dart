import './location_fact.dart';

class Location {
  final String name;
  final String url;
  final List<LocationFact>
      facts; //variable is facts[i] of type Class LocationFact

  Location(
      {required this.name,
      required this.url,
      required this.facts}); // Constructor
}
