import 'package:flutter/material.dart';
import '../styles.dart';

class DefaultAppBar extends AppBar {
  @override
  final Widget title =
      Text('Tourism & Co.'.toUpperCase(), style: Styles.navBarTitle);

  @override
  final IconThemeData iconTheme = const IconThemeData(color: Colors.black);

  @override
  final Color backgroundColor = Colors.white;

  @override
  final bool centerTitle = true;

  @override
  final double elevation = 5.0;

  DefaultAppBar({Key? key}) : super(key: key);
}
