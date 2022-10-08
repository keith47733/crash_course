import 'package:flutter/material.dart';

class BannerImage extends StatelessWidget {
  final String url;
  final double height;

  const BannerImage({Key? key, required this.url, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: BoxConstraints.expand(height: height),
        child: Image.network(url, fit: BoxFit.cover),
      );
    } catch (e) {
      print("could not load image $url");
      return Container();
    }
  }
}
