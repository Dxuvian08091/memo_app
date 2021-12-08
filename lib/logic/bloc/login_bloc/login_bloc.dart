import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/repository/user_repository.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      try {
        final user = await userRepository.authenticate(
            username: event.username, password: event.password);

        authenticationBloc.add(LoggedIn(user: user));
      } catch (error) {
        emit(LoginFailure(error: error.toString()));
      }
      emit(LoginInitial());
    });
    on<RegisterButtonPressed>((event, emit) {
      authenticationBloc.add(Register());
    });
  }
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;
}
