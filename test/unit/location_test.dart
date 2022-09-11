// import 'package:flutter/material.dart';
import 'package:test/test.dart';
import "dart:convert";

import '../../lib/models/location.dart';

void main() {
  test('location_deserialization', () {
    const locationJSON =
        '{ "name": "Arishiyama Bamboo Grove", "url": "https://cdn-images-1.medium.com/max/2000/1*vdJuSUKWl_SA9Lp-32ebnA.jpeg", "facts": [{"title": "Summary", "text": "This bamboo grove is on the outskirts of Kyoto." }] }';

    final locationMap = json.decode(locationJSON) as Map<String, dynamic>;

    expect("Arishiyama Bamboo Grove", equals(locationMap['name']));

    final location = Location.fromJson(locationMap);

    expect(location.name, equals(locationMap['name']));
    expect(location.url, equals(locationMap['url']));

    expect(location.facts[0].title, matches(locationMap['facts'][0]['title']));
    expect(location.facts[0].text, matches(locationMap['facts'][0]['text']));
  });
}
