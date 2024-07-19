import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/modules/search_repo/repository/search_repo_repository.dart';
import 'package:github_search_app/resources/styles/themes.dart';
import 'package:github_search_app/source/local/my_shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'data/di/di.dart';
import 'modules/global/cubit/global_cubit.dart';
import 'modules/global/cubit/global_state.dart';
import 'modules/home/home_screen.dart';
import 'modules/search_repo/bloc/search_repo_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  await sl<MySharedPref>().initSP();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<SearchRepoBloc>(
        create: (context) => sl<SearchRepoBloc>(),
      ),
      BlocProvider(
        create: (context) => sl<GlobalCubit>(),
      ),
      Provider(
        create: (context) => sl<SearchRepository>(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  late GlobalCubit globalCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalStates>(builder: (context, state)
    {
      return Sizer(
          builder: (context, orientation, deviceType) {
            globalCubit = sl<GlobalCubit>();
            globalCubit.getAppTheme();
            return
              MaterialApp(
                title: 'GitHub Repo Search',
                theme: globalCubit.isLightTheme
                    ? Themes.lightTheme
                    : Themes.darkTheme,
                home: BlocProvider(
                  create: (context) => sl<SearchRepoBloc>(),
                  child: const HomeScreen(),
                ),
              );
          },
            );
          });
    }
  }
