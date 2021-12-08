import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/const/enums.dart';
import 'package:flutter_app/data/repository/user_repository.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app/logic/bloc/internet_bloc/internet_bloc.dart';
import 'package:flutter_app/presentation/pages/no_internet.dart';
import 'package:flutter_app/presentation/pages/signup_success_page.dart';
import 'package:flutter_app/presentation/screens/login_screen.dart';
import 'package:flutter_app/presentation/screens/note_list.dart';
import 'package:flutter_app/presentation/screens/signup_screen.dart';
import 'package:flutter_app/presentation/widgets/loading_indicator.dart';
import 'package:flutter_app/utils/database_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/note.dart';
import 'logic/bloc/login_bloc/login_bloc.dart';
import 'logic/bloc/note_bloc/note_bloc.dart';
import 'logic/bloc/register_bloc/register_bloc.dart';

void main() {
  final UserRepository userRepository = UserRepository();
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final List<Note> noteList = [];
  final Connectivity connectivity = Connectivity();

  runApp(
    //MultiBlocProvider to provide bloc access to all of the child widgets
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: userRepository)
                  ..add(AppStarted())),
        BlocProvider<NoteBloc>(
            create: (context) =>
                NoteBloc(databaseHelper: databaseHelper, noteList: noteList)),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(
              userRepository: userRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        ),
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
              userRepository: userRepository,
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
        ),
        BlocProvider<InternetBloc>(
            create: (context) => InternetBloc(
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context))),
      ],
      child: App(
        userRepository: userRepository,
        connectivity: connectivity,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;
  final Connectivity connectivity;
  StreamSubscription connectivityStreamSubscription;

  //App constructor takes to parameter userRepository and connectivity
  App({Key key, @required this.userRepository, @required this.connectivity})
      : assert(userRepository != null),
        assert(connectivity != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    _checkConnection(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
        if (state is AuthenticationUninitialized) {
          return SignUpSuccess();
        }
        if (state is AuthenticationAuthenticated) {
          return NoteList();
        }
        if (state is AuthenticationRegister) {
          return SignUpScreen();
        }
        if (state is AuthenticationSignUp) {
          return SignUpSuccess();
        }
        if (state is NoInternet) {
          return NoInternetPage();
        }
        if (state is AuthenticationUnauthenticated) {
          return LoginScreen(
            userRepository: userRepository,
          );
        }
        return LoadingIndicator();
      }),
    );
  }

  //listens to the internet connectivity stream via and emits InternetConnected and InternetDisconnected State
  void _checkConnection(BuildContext context) {
    connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        BlocProvider.of<InternetBloc>(context)
            .add(InternetConnection(connectionType: ConnectionType.Wifi));
      } else if (connectivityResult == ConnectivityResult.mobile) {
        BlocProvider.of<InternetBloc>(context)
            .add(InternetConnection(connectionType: ConnectionType.Mobile));
      } else {
        BlocProvider.of<InternetBloc>(context).add(InternetDisconnection());
      }
    });
  }

  void close() {
    connectivityStreamSubscription.cancel();
  }
}
