import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/banner_image.dart';
import 'components/default_app_bar.dart';
import 'components/location_tile.dart';
import 'models/location.dart';
import 'styles.dart';

const bannerImageHeight = 300.0;
const bodyVerticalPadding = 20.0;
const footerHeight = 100.0;

class LocationDetail extends StatefulWidget {
  final int locationID;
  const LocationDetail(this.locationID, {Key? key}) : super(key: key);

  @override
  createState() => _LocationDetailState(locationID);
}

class _LocationDetailState extends State<LocationDetail> {
  final int locationID;
  Location location = Location.blank();

  _LocationDetailState(this.locationID);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DefaultAppBar(),
        body: Stack(children: [
          _renderBody(context, location),
          _renderFooter(context, location),
        ]));
  }

  loadData() async {
    final location = await Location.fetchByID(locationID);

    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  Widget _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(
      BannerImage(url: location.url, height: bannerImageHeight),
    );
    result.add(_renderHeader());
    result.addAll(_renderFacts(context, location));
    result.add(_renderBottomSpacer());
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: result));
  }

  Widget _renderHeader() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: bodyVerticalPadding, horizontal: Styles.horizontalPaddingDefault),
        child: LocationTile(location: location, isDarkTheme: false));
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = <Widget>[];
    for (int i = 0; i < (location.facts ?? []).length; i++) {
      result.add(_sectionTitle(location.facts![i].title));
      result.add(_sectionText(location.facts![i].text));
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(Styles.horizontalPaddingDefault, 25.0, Styles.horizontalPaddingDefault, 0.0),
        child: Text(text.toUpperCase(), textAlign: TextAlign.left, style: Styles.textHeader1));
  }

  Widget _sectionText(String text) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: Styles.horizontalPaddingDefault),
        child: Text(text, style: Styles.textDefault));
  }

  Widget _renderFooter(BuildContext context, Location location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
          height: footerHeight,
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0), child: _renderBookButton()),
        )
      ],
    );
  }

  Widget _renderBookButton() {
    return TextButton(
      onPressed: _handleBookPress,
      style: TextButton.styleFrom(
        backgroundColor: Styles.accentColor,
        foregroundColor: Styles.textColorBright,
      ),
      child: Text('Book'.toUpperCase()),
    );
  }

  void _handleBookPress() async {
    const url = 'mailto:keith47733@gmail.com?subject=Inquiry';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _renderBottomSpacer() {
    return Container(height: footerHeight);
  }
}
