import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/models/user.dart';
import 'package:flutter_app/data/models/user_register.dart';
import 'package:flutter_app/data/repository/user_repository.dart';
import 'package:flutter_app/logic/bloc/internet_bloc/internet_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationUnauthenticated()) {
    on<AppStarted>((event, emit) async {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        emit(AuthenticationAuthenticated());
      } else {
        emit(AuthenticationUnauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.persistToken(user: event.user);
      emit(AuthenticationAuthenticated());
    });
    on<LoggedOut>((event, emit) async {
      emit(AuthenticationLoading());
      await userRepository.deleteToken(id: 0);
      emit(AuthenticationUnauthenticated());
    });
    on<Register>((event, emit) async {
      emit(AuthenticationLoading());
      emit(AuthenticationRegister());
    });

    on<SignUp>((event, emit) async {
      emit(AuthenticationLoading());
      emit(AuthenticationSignUp());
    });
    on<NoInternetConnection>((event, emit) async {
      emit(AuthenticationLoading());
      emit(NoInternet());
    });
  }
  final UserRepository userRepository;
}
