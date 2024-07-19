import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/di/di.dart';
import '../../../source/local/my_shared_preferences.dart';
import '../../../source/local/my_shared_preferences_keys.dart';
import 'global_state.dart';

class GlobalCubit extends Cubit<GlobalStates> {
  GlobalCubit() : super(GlobalInitial());

  static GlobalCubit get(context) => BlocProvider.of<GlobalCubit>(context);

  bool isLightTheme = false;

  void getAppTheme() {
    isLightTheme = sl<MySharedPref>().getBoolean(key: MySharedKeys.theme) ?? true;
  }

  void setAppTheme() {
    isLightTheme = !isLightTheme;
    sl<MySharedPref>().putBoolean(key: MySharedKeys.theme, value: isLightTheme);
    emit(ChangeAppThemeState());
  }
}
