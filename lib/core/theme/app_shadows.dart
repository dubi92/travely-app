import 'package:flutter/material.dart';

class AppShadows {
  // shadow-[0_2px_12px_rgba(0,0,0,0.06)]
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.06),
      offset: Offset(0, 2),
      blurRadius: 12,
    ),
  ];

  // shadow-[0_4px_20px_rgba(48,140,232,0.4)]
  static const List<BoxShadow> primary = [
    BoxShadow(
      color: Color.fromRGBO(48, 140, 232, 0.4),
      offset: Offset(0, 4),
      blurRadius: 20,
    ),
  ];
  
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.05),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];
}
