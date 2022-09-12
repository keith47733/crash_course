import 'dart:async';
import 'package:flutter/material.dart';
import 'components/location_tile.dart';
import 'models/location.dart';
import 'location_detail.dart';
import 'styles.dart';

const ListItemHeight = 245.0;

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
        body: RefreshIndicator(
            onRefresh: loadData,
            child: Column(children: [
              renderProgressBar(context),
              Expanded(child: renderListView(context))
            ])));
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

  Future<void> loadData() async {
    if (this.mounted) {
      setState(() => this.isLoading = true);
      Timer(Duration(seconds: 3), () async {
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
    return GestureDetector(
        onTap: () => _navigateToLocationDetail(context, location.id),
        child: Container(
          height: ListItemHeight,
          child: Stack(children: [
            _tileImage(location.url, MediaQuery.of(context).size.width,
                ListItemHeight),
            _tileFooter(location),
          ]),
        ));
  }

  void _navigateToLocationDetail(BuildContext context, int locationID) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LocationDetail(locationID)));
  }

  Widget _tileImage(String url, double width, double height) {
    Image image;
    try {
      image = Image.network(url, fit: BoxFit.cover);
    } catch (e) {
      print("could not load image $url");
    }
    return Container(
      constraints: BoxConstraints.expand(),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, isDarkTheme: true);
    final overlay = Container(
      padding: EdgeInsets.symmetric(
          vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

  Widget _itemTitle(Location location) {
    return Text('${location.name}', style: Styles.textDefault);
  }
}
