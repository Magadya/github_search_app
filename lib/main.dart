import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_search_app/core/local/my_shared_preferences.dart';
import 'package:github_search_app/presentation/cubit/global/global_cubit.dart';
import 'package:github_search_app/presentation/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'core/resources/styles/themes.dart';
import 'data/di/di.dart';

import 'presentation/bloc/search_repo/search_repo_bloc.dart';
import 'data/repositories/search_repopository_impl.dart';
import 'presentation/cubit/global/global_state.dart';

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
        create: (context) => sl<SearchRepoDataSourceImpl>(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GlobalCubit globalCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalCubit, GlobalStates>(builder: (context, state) {
      return Sizer(
        builder: (context, orientation, deviceType) {
          globalCubit = sl<GlobalCubit>();
          globalCubit.getAppTheme();
          return MaterialApp(
            title: 'GitHub Repo Search',
            theme: globalCubit.isLightTheme ? Themes.lightTheme : Themes.darkTheme,
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
