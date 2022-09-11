import 'package:flutter/material.dart';
import 'dart:async';
import 'models/location.dart';
import 'location_detail.dart';
import 'styles.dart';

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Locations", style: Styles.navBarTitle)),
        body: Column(children: [
          renderProgressBar(context),
          Expanded(child: renderListView(context))
        ]));
  }

  Widget renderProgressBar(BuildContext context) {
    return (this.isLoading
        // ignore: prefer_const_constructors
        ? LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation(Colors.grey))
        : Container());
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(
        itemCount: this.locations.length, itemBuilder: _listViewItemBuilder);
  }

  loadData() async {
    if (this.mounted) {
      setState(() => this.isLoading = true);
      Timer(Duration(seconds: 8), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          this.isLoading = false;
        });
      });
    }
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = this.locations[index];
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: _itemThumbnail(this.locations[index]),
      title: _itemTitle(this.locations[index]),
      onTap: () => _navigateToLocationDetail(context, location.id),
    );
  }

  void _navigateToLocationDetail(BuildContext context, int locationID) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationDetail(locationID)));
  }

  Widget _itemThumbnail(Location location) {
    if (location.url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: BoxConstraints.tightFor(height: 100.0),
        child: Image.network(location.url, fit: BoxFit.fitWidth),
      );
    } catch (e) {
      print("could not load image ${location.url}");
      return Container();
    }
  }

  Widget _itemTitle(Location location) {
    return Text('${location.name}', style: Styles.textDefault);
  }
}
