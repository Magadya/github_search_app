
import 'package:get_it/get_it.dart';

import '../../modules/global/cubit/global_cubit.dart';
import '../../modules/search_repo/bloc/search_repo_bloc.dart';
import '../../modules/search_repo/repository/search_repo_repository.dart';
import '../../source/local/my_shared_preferences.dart';
import '../../source/networking/network.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NetworkDio>(
        () => NetworkDio(),
  );
  sl.registerLazySingleton<MySharedPref>(
        () => MySharedPref(),
  );
  sl.registerLazySingleton<GlobalCubit>(
        () => GlobalCubit(),
  );
  sl.registerLazySingleton<SearchRepoBloc>(
        () => SearchRepoBloc(searchRepository: SearchRepository()),
  );
}