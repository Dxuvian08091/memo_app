import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/data/models/user_register.dart';
import 'package:flutter_app/data/repository/user_repository.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  RegisterBloc(
      {@required this.userRepository, @required this.authenticationBloc})
      : assert(authenticationBloc != null),
        assert(userRepository != null),
        super(RegisterInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(RegisterLoading());
      try {
        final UserRegister userRegister = UserRegister(
          username: event.username,
          password: event.password,
          password2: event.password2,
          email: event.email,
          notes: event.notes,
        );
        await userRepository.register(userRegister: userRegister);
        authenticationBloc.add(SignUp());
      } catch (error) {
        emit(RegisterFailure(error: error.toString()));
      }
      emit(RegisterInitial());
    });
  }
}
