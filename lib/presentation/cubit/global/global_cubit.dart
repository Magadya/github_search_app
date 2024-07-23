import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/local/my_shared_preferences.dart';
import '../../../core/local/my_shared_preferences_keys.dart';
import '../../../core/resources/styles/themes.dart';
import '../../../data/di/di.dart';
import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalStates> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of<GlobalCubit>(context);

  bool isLightTheme = false;

  ThemeData getAppTheme() {
    isLightTheme = sl<MySharedPref>().getBoolean(key: MySharedKeys.theme) ?? true;
    if (isLightTheme) {
      return Themes.lightTheme;
    } else {
      return Themes.darkTheme;
    }
  }

  void setAppTheme() {
    isLightTheme = !isLightTheme;
    sl<MySharedPref>().putBoolean(key: MySharedKeys.theme, value: isLightTheme);
    emit(ChangeAppThemeState());
  }
}
