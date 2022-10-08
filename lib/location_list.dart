import 'dart:async';

import 'package:flutter/material.dart';

import 'components/banner_image.dart';
import 'components/default_app_bar.dart';
import 'components/location_tile.dart';
import 'location_detail.dart';
import 'models/location.dart';
import 'styles.dart';

const listItemHeight = 245.0;

class LocationList extends StatefulWidget {
  const LocationList({Key? key}) : super(key: key);

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
      appBar: DefaultAppBar(),
      body: RefreshIndicator(
        onRefresh: loadData,
        child: Column(
          children: [renderProgressBar(context), Expanded(child: renderListView(context))],
        ),
      ),
    );
  }

  Widget renderProgressBar(BuildContext context) {
    return (isLoading
        // ignore: prefer_const_constructors
        ? LinearProgressIndicator(
            value: null, backgroundColor: Colors.white, valueColor: const AlwaysStoppedAnimation(Colors.grey))
        : Container());
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(itemCount: locations.length, itemBuilder: _listViewItemBuilder);
  }

  Future<void> loadData() async {
    if (mounted) {
      setState(() => isLoading = true);
      Timer(const Duration(seconds: 3), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          isLoading = false;
        });
      });
    }
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = locations[index];
    return GestureDetector(
      onTap: () => _navigateToLocationDetail(context, location.id),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          2.0,
          1.0,
          2.0,
          0,
        ),
        child: Card(
          elevation: 8.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: SizedBox(
              height: listItemHeight,
              child: Stack(
                children: [
                  BannerImage(url: location.url, height: 300.0),
                  _tileFooter(location),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToLocationDetail(BuildContext context, int locationID) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LocationDetail(locationID)));
  }

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, isDarkTheme: true);
    final overlay = Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }
}
