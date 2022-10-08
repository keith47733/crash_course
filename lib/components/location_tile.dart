import 'package:flutter/material.dart';

import '../models/location.dart';
import '../styles.dart';

const locationTileHeaight = 100.0;

class LocationTile extends StatelessWidget {
  final Location location;
  final bool isDarkTheme;

  const LocationTile({Key? key, required this.location, required this.isDarkTheme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = location.name.toUpperCase();
    final subTitle = location.userItinerarySummary.toUpperCase();
    final caption = location.tourPackageName.toUpperCase();

    return Container(
      padding: const EdgeInsets.all(0.0),
      height: locationTileHeaight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: isDarkTheme ? Styles.locationTileTitleDark : Styles.locationTileTitleLight),
          Text(subTitle, style: Styles.locationTileSubTitle),
          Text(caption, style: Styles.locationTileCaption),
        ],
      ),
    );
  }
}
