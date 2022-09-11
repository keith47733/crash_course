import 'package:flutter/material.dart';

import 'models/location.dart';
import 'location_detail.dart';
import 'styles/styles.dart';

class LocationList extends StatelessWidget {
  final List<Location> locations;

  LocationList(this.locations);

  @override
  Widget build(BuildContext context) {
    // An abstract class that returns the Scaffold object and its contents
    return Scaffold(
      appBar: AppBar(title: Text('Locations', style: Styles.navBarTitle)),
      body: ListView.builder(
        itemCount: this.locations.length,
        itemBuilder:
            _listViewItemBuilder, // It's a callback and requires only function definition (don't execute it right away with (...). Function must return a ListTile widget
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var locationIndex = this.locations[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(locationIndex),
      title: _itemTitle(locationIndex),
      onTap: () => _navigateToLocationDetail(context, index),
    );
  }

  void _navigateToLocationDetail(BuildContext context, int locationID) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationDetail(locationID)),
    );
  }

  Widget _itemThumbnail(Location locationRender) {
    return Container(
      constraints: BoxConstraints.tightFor(width: 100.0),
      child: Image.network(locationRender.url, fit: BoxFit.fitWidth),
    );
  }

  Widget _itemTitle(Location locationRender) {
    return Text(
      '${locationRender.name}', // $ string interpolation - can add text before $
      style: Styles.textDefault,
    );
  }
}
