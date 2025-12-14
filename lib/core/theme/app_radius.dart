import 'package:flutter/widgets.dart';

class AppRadius {
  static const double sm = 8.0; // 0.5rem - welcome buttons
  static const double md = 12.0; 
  static const double lg = 16.0; // 1rem - inputs default
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double full = 9999.0;

  static const Radius rSM = Radius.circular(sm);
  static const Radius rMD = Radius.circular(md);
  static const Radius rLG = Radius.circular(lg);
  static const Radius rXL = Radius.circular(xl);
  static const Radius rXXL = Radius.circular(xxl);
  static const Radius rFull = Radius.circular(full);

  static const BorderRadius roundedSM = BorderRadius.all(rSM);
  static const BorderRadius roundedMD = BorderRadius.all(rMD);
  static const BorderRadius roundedLG = BorderRadius.all(rLG);
  static const BorderRadius roundedXL = BorderRadius.all(rXL);
  static const BorderRadius roundedXXL = BorderRadius.all(rXXL);
  static const BorderRadius roundedFull = BorderRadius.all(rFull);
}
