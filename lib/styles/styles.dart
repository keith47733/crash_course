import 'package:flutter/material.dart';

class Styles {
  // NavBarTitle
  static final String _fontNameNavBarTitle = 'Muli';

  // Header1
  static final String _fontNameHeader1 = 'Muli';
  static const _textSizeHeader1 = 25.0;
  static final Color _textColorHeader1 = _hexToColor('000000');

  // Default
  static final String _fontNameDefault = 'Muli';
  static const _textSizeDefault = 16.0;
  static final Color _textColorDefault = _hexToColor('666666');

  static final navBarTitle = TextStyle(
    fontFamily: _fontNameNavBarTitle,
  );

  static final textHeader1 = TextStyle(
    fontFamily: _fontNameHeader1,
    fontSize: _textSizeHeader1,
    color: _textColorHeader1,
  );

  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
