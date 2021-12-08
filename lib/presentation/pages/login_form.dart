import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _onRegisterButtonPressed() =>
        BlocProvider.of<LoginBloc>(context).add(RegisterButtonPressed());
    _onLoginButtonPressed() =>
        BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text));
    return BlocConsumer<LoginBloc, LoginState>(builder: (context, state) {
      return Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  //First Element
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Username', icon: Icon(Icons.person)),
                    controller: _usernameController,
                  ),
                  //Second Element
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password', icon: Icon(Icons.security)),
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  //Third Element
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: state is! LoginLoading
                            ? _onLoginButtonPressed
                            : null,
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 24.0),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //Fourth Element
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: TextButton(
                      child: Text('Sign up | Register',
                          style: TextStyle(fontSize: 15.0)),
                      onPressed: state is! LoginLoading
                          ? _onRegisterButtonPressed
                          : null,
                    ),
                  ),
                  //FIfth Element
                  Container(
                    child: state is LoginLoading
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is LoginFailure) {
        //displays a snackbar with error message when error occurs
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${state.error}'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
