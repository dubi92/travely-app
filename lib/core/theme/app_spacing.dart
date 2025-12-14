import 'package:flutter/widgets.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 48.0;

  static const EdgeInsets pXS = EdgeInsets.all(xs);
  static const EdgeInsets pSM = EdgeInsets.all(sm);
  static const EdgeInsets pMD = EdgeInsets.all(md);
  static const EdgeInsets pLG = EdgeInsets.all(lg);
  static const EdgeInsets pXL = EdgeInsets.all(xl);

  static const EdgeInsets hXS = EdgeInsets.symmetric(horizontal: xs);
  static const EdgeInsets hSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets hMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets hLG = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets hXL = EdgeInsets.symmetric(horizontal: xl);

  static const EdgeInsets vXS = EdgeInsets.symmetric(vertical: xs);
  static const EdgeInsets vSM = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets vMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets vLG = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets vXL = EdgeInsets.symmetric(vertical: xl);

  static const SizedBox gapXS = SizedBox(width: xs, height: xs);
  static const SizedBox gapSM = SizedBox(width: sm, height: sm);
  static const SizedBox gapMD = SizedBox(width: md, height: md);
  static const SizedBox gapLG = SizedBox(width: lg, height: lg);
  static const SizedBox gapXL = SizedBox(width: xl, height: xl);
  static const SizedBox gapXXL = SizedBox(width: xxl, height: xxl);
}
