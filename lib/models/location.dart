import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'
    as http; // Not really a class, so we import AS an http object
import 'package:json_annotation/json_annotation.dart';

import 'location_fact.dart';
import '../endpoint.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String name;
  final String url;
  final List<LocationFact>
      facts; //variable is array facts[i] of type Class LocationFact

  Location(
      {required this.id,
      required this.name,
      required this.url,
      required this.facts}); // Constructor

  Location.blank()
      : id = 0,
        name = '',
        url = '',
        facts =
            []; // This prevents the location_detail.dart from encountering a null value

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  static Future<List<Location>> fetchAll() async {
    var uri = Endpoint.uri('/locations', queryParameters: {});

    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }

    List<Location> list = <Location>[];
    for (var jsonItem in json.decode(resp.body)) {
      list.add(Location.fromJson(jsonItem));
    }
    return list;
  }

  static Future<Location> fetchByID(int id) async {
    var uri = Endpoint.uri('/locations/$id', queryParameters: {});

    final resp = await http.get(
        uri); // This is response from web server - By using await, 'resp' is of type Response

    if (resp.statusCode != 200) {
      throw (resp.body);
    }

    final Map<String, dynamic> itemMap = json.decode(resp.body);
    return Location.fromJson(itemMap);
  }
}
