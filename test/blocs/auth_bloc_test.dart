import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedx/blocs/auth/auth_bloc.dart';
import 'package:pokedx/blocs/auth/auth_event.dart';
import 'package:pokedx/blocs/auth/auth_repository.dart';
import 'package:pokedx/blocs/auth/auth_state.dart';
import 'package:pokedx/models/user.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthBloc', () {
    MockAuthRepository mockAuthRepository;
    AuthBloc authBloc;

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository: mockAuthRepository);
    });

    tearDown(() {
      authBloc?.close();
    });

    test('throws AssertionError when authRepository is null', () {
      expect(() => AuthBloc(authRepository: null), throwsAssertionError);
    });

    test('has a correct initial state', () {
      expect(authBloc.state, UnknownState());
    });

    group('StateChange', () {
      var user = User('', '');
      blocTest(
        'emits [UnauthenticatedState] when user is set as null',
        build: () => authBloc,
        act: (bloc) => bloc.add(StateChange(user: null)),
        expect: [
          UnauthenticatedState(),
        ],
      );
      blocTest(
        'emits [AuthenticatedState] when user is set',
        build: () {
          when(mockAuthRepository.getUser()).thenAnswer(
                (_) => user,
          );
          return authBloc;
        },
        act: (bloc) => bloc.add(StateChange(user: user)),
        expect: [
          AuthenticatedState(user),
        ],
      );
    });

    group('SignInRequested', () {
      var user = User('', '');
      blocTest(
        'emits [ErrorState] when user is set an error',
        build: () {
          when(mockAuthRepository.signIn(user, '')).thenThrow(AssertionError(''));
          return authBloc;
        },
        act: (bloc) => bloc.add(SignInRequested(user: user, password: '')),
        expect: [
          RequestChangeState(),
          ErrorState(''),
        ],
      );
      blocTest(
        'emits [AuthenticatedState] when user is set',
        build: () => authBloc,
        act: (bloc) => bloc.add(SignInRequested(user: user, password: '')),
        expect: [
          RequestChangeState(),
        ],
      );
    });

    group('SignUpRequested', () {
      var user = User('', '');
      blocTest(
        'emits [RequestChangeState,ErrorState] when user is set an error',
        build: () {
          when(mockAuthRepository.signUp(user, '')).thenThrow(AssertionError(''));
          return authBloc;
        },
        act: (bloc) => bloc.add(SignUpRequested(user: user, password: '')),
        expect: [
          RequestChangeState(),
          SignUpError(''),
        ],
      );
      blocTest(
        'emits [RequestChangeState,SignUpSuccess] when user is set',
        build: () => authBloc,
        act: (bloc) => bloc.add(SignUpRequested(user: user, password: '')),
        expect: [
          RequestChangeState(),
          SignUpSuccess()
        ],
      );
    });

    group('SignOutRequested', () {
      blocTest(
        'emits [RequestChangeState,UnauthenticatedState]',
        build: () => authBloc,
        act: (bloc) => bloc.add(SignOutRequested()),
        expect: [
          RequestChangeState(),
          UnauthenticatedState(),
        ],
      );
    });

  });


  group('AuthEvent', () {

    group('StateChange', () {
      var user = User('', '');
      test('props are [user]', () {
        expect(StateChange(user: user).props, [user]);
      });
    });

    group('SignInRequested', () {
      var user = User('', '');
      var password = '';
      test('props are [user, password]', () {
        expect(SignInRequested(user: user, password: password).props, [user, password]);
      });
    });

    group('SignUpRequested', () {
      var user = User('', '');
      var password = '';
      test('props are [user, password]', () {
        expect(SignUpRequested(user: user, password: password).props, [user, password]);
      });
    });

    group('SignOutRequested', () {
      test('props are []', () {
        expect(SignOutRequested().props, []);
      });
    });

  });
}