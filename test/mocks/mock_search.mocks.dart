// Mocks generated by Mockito 5.4.4 from annotations
// in github_search_app/test/modules/mocks/mock_search.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i7;
import 'package:github_search_app/data/models/repo_data_model.dart' as _i5;
import 'package:github_search_app/data/repositories/search_repository_impl.dart'
    as _i9;
import 'package:github_search_app/domain/repositories/search_repository.dart'
    as _i2;
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_bloc.dart'
    as _i6;
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_event.dart'
    as _i8;
import 'package:github_search_app/presentation/bloc/search_repo/search_repo_state.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSearchRepository_0 extends _i1.SmartFake
    implements _i2.SearchRepository {
  _FakeSearchRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSearchRepoState_1 extends _i1.SmartFake
    implements _i3.SearchRepoState {
  _FakeSearchRepoState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [SearchRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchRepository extends _i1.Mock implements _i2.SearchRepository {
  MockSearchRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.RepoDataModel>> getRepositoriesWithSearchQuery(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRepositoriesWithSearchQuery,
          [query],
        ),
        returnValue:
            _i4.Future<List<_i5.RepoDataModel>>.value(<_i5.RepoDataModel>[]),
      ) as _i4.Future<List<_i5.RepoDataModel>>);
}

/// A class which mocks [SearchRepoBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchRepoBloc extends _i1.Mock implements _i6.SearchRepoBloc {
  MockSearchRepoBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.SearchRepository get searchRepository => (super.noSuchMethod(
        Invocation.getter(#searchRepository),
        returnValue: _FakeSearchRepository_0(
          this,
          Invocation.getter(#searchRepository),
        ),
      ) as _i2.SearchRepository);

  @override
  _i3.SearchRepoState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeSearchRepoState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.SearchRepoState);

  @override
  _i4.Stream<_i3.SearchRepoState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i3.SearchRepoState>.empty(),
      ) as _i4.Stream<_i3.SearchRepoState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);

  @override
  _i7.EventTransformer<T> debounce<T>(Duration? duration) =>
      (super.noSuchMethod(
        Invocation.method(
          #debounce,
          [duration],
        ),
        returnValue: (
          _i4.Stream<T> events,
          _i7.EventMapper<T> mapper,
        ) =>
            _i4.Stream<T>.empty(),
      ) as _i7.EventTransformer<T>);

  @override
  void add(_i8.SearchRepoEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i8.SearchRepoEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.SearchRepoState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i8.SearchRepoEvent>(
    _i7.EventHandler<E, _i3.SearchRepoState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i7.Transition<_i8.SearchRepoEvent, _i3.SearchRepoState>?
              transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onChange(_i7.Change<_i3.SearchRepoState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}

/// A class which mocks [SearchRepoDataSourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchRepoDataSourceImpl extends _i1.Mock
    implements _i9.SearchRepoDataSourceImpl {
  MockSearchRepoDataSourceImpl() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<List<_i5.RepoDataModel>> getRepositoriesWithSearchQuery(
          String? query) =>
      (super.noSuchMethod(
        Invocation.method(
          #getRepositoriesWithSearchQuery,
          [query],
        ),
        returnValue:
            _i4.Future<List<_i5.RepoDataModel>>.value(<_i5.RepoDataModel>[]),
      ) as _i4.Future<List<_i5.RepoDataModel>>);
}
