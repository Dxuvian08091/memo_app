import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/const/enums.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';

part 'internet_event.dart';
part 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final AuthenticationBloc authenticationBloc;
  InternetBloc({@required this.authenticationBloc}) : super(InternetLoading()) {
    on<InternetConnection>((event, emit) {
      emit(InternetConnected(connectionType: event.connectionType));
      authenticationBloc.add(LoggedOut());
    });
    on<InternetDisconnection>((event, emit) {
      emit(InternetDisconnected());
      authenticationBloc.add(NoInternetConnection());
    });
  }
}
