// import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import "dart:convert";

import '../../lib/models/location.dart';

void main() {
  test('location_deserialization', () {
    const locationJSON =
        '{ "name": "Arishiyama Bamboo Grove", "url": "https://cdn-images-1.medium.com/max/2000/1*vdJuSUKWl_SA9Lp-32ebnA.jpeg", "facts": [{"title": "Summary", "text": "This bamboo grove is on the outskirts of Kyoto." }] }';

    final locationMap = json.decode(locationJSON) as Map<String, dynamic>;

    expect("Arishiyama Bamboo Grove", equals(locationMap['name']));
  });
}
