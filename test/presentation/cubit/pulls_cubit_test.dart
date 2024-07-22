import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_search_app/presentation/cubit/pulls/pulls_cubit.dart';
import 'package:github_search_app/presentation/cubit/pulls/pulls_state.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/mock_pulls.mocks.dart';

void main() {
  late MockPullsRepository mockPullsRepository;
  late PullsCubit pullsCubit;

  setUp(() {
    mockPullsRepository = MockPullsRepository();
    pullsCubit = PullsCubit(mockPullsRepository);
  });

  tearDown(() {
    pullsCubit.close();
  });

  test('initial state is correct', () {
    expect(pullsCubit.state.status, PullsStatus.initialLoading);
  });

  blocTest<PullsCubit, PullsState>(
    'emits [initialLoading, pending] when data is being fetched',
    build: () {
      when(mockPullsRepository.fetchAllPulls(any, any)).thenAnswer((_) async => []);
      return pullsCubit;
    },
    act: (cubit) => cubit.initStateEvent('owner', 'name'),
    expect: () => [
      isA<PullsState>().having((s) => s.status, 'status', PullsStatus.initialLoading),
      isA<PullsState>().having((s) => s.status, 'status', PullsStatus.pending),
    ],
  );

  blocTest<PullsCubit, PullsState>(
    'emits [initialLoading, pending, success] with list of pulls on successful fetch',
    build: () {
      when(mockPullsRepository.fetchAllPulls(any, any)).thenAnswer((_) async => []);
      return pullsCubit;
    },
    act: (cubit) => cubit.initStateEvent('Magadya', 'Magadya.github.io'),
    expect: () => [
      isA<PullsState>().having((s) => s.status, 'status', PullsStatus.initialLoading),
      isA<PullsState>().having((s) => s.status, 'status', PullsStatus.pending).having((s) => s.items, 'items', []),
    ],
  );
}
