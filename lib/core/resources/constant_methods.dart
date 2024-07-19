import 'dart:ui';

import 'package:flutter/foundation.dart';

import '../../data/di/di.dart';
import '../../presentation/cubit/global/global_cubit.dart';


void printResponse(String text) {
  if (kDebugMode) {
    print('\x1B[33m$text\x1B[0m');
  }
}

void printError(String text) {
  if (kDebugMode) {
    print('\x1B[31m$text\x1B[0m');
  }
}

void printTest(String text) {
  if (kDebugMode) {
    print('\x1B[32m$text\x1B[0m');
  }
}

Color darkOrLightColor(Color lightColor, Color darkColor) {
  return sl<GlobalCubit>().isLightTheme ? lightColor : darkColor;
}
