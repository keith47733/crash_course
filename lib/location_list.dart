import 'package:flutter/material.dart';

import 'styles.dart';
import 'models/location.dart';
import 'location_detail.dart';

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

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

  loadData() async {
    final locations = await Location.fetchAll();
    setState(() {
      this.locations = locations;
    });
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () => _navigateToLocationDetail(context, location.id),
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
