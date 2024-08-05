
import 'package:get_it/get_it.dart';
import 'package:github_search_app/presentation/bloc/home_repo/home_repo_bloc.dart';

import '../../presentation/bloc/search_repo/search_repo_bloc.dart';
import '../../presentation/cubit/global/global_cubit.dart';
import '../repositories/home_repository_impl.dart';
import '../repositories/search_repository_impl.dart';
import '../../core/local/my_shared_preferences.dart';
import '../../core/networking/network.dart';


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
        () => SearchRepoBloc(searchRepository: SearchRepoDataSourceImpl()),
  );
  sl.registerLazySingleton<HomeRepoBloc>(
        () => HomeRepoBloc(homeRepository: HomeRepoDataSourceImpl()),
  );
  sl.registerLazySingleton<SearchRepoDataSourceImpl>(
        () => SearchRepoDataSourceImpl(),
  );

}