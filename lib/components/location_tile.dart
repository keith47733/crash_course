import 'package:flutter/material.dart';
import '../models/location.dart';
import '../styles.dart';

const LocationTileHeaight = 100.0;

class LocationTile extends StatelessWidget {
  final Location location;
  final bool isDarkTheme;

  LocationTile({required this.location, required this.isDarkTheme});

  @override
  Widget build(BuildContext context) {
    final title = location.name.toUpperCase();
    final subTitle = location.userItinerarySummary.toUpperCase();
    final caption = location.tourPackageName.toUpperCase();

    return Container(
      padding: EdgeInsets.all(0.0),
      height: LocationTileHeaight,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: this.isDarkTheme
                    ? Styles.locationTileTitleDark
                    : Styles.locationTileTitleLight),
            Text('$subTitle', style: Styles.locationTileSubTitle),
            Text('$caption', style: Styles.locationTileCaption),
          ]),
    );
  }
}
