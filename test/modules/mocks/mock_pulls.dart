// Use this annotation to automatically generate the mock class
import 'package:github_search_app/data/repositories/pulls_repository_impl.dart';
import 'package:github_search_app/domain/repositories/pulls_repository.dart';
import 'package:github_search_app/presentation/cubit/pulls/pulls_cubit.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([PullsRepository,PullsCubit,PullsRepositoryImpl])


void main() {}