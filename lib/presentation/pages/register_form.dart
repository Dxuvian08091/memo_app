import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_app/logic/bloc/register_bloc/register_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _password2Controller = TextEditingController();
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _onSignUpButtonPressed() =>
        BlocProvider.of<RegisterBloc>(context).add(SignUpButtonPressed(
            username: _usernameController.text,
            password: _passwordController.text,
            password2: _password2Controller.text,
            email: _emailController.text,
            notes: []));
    return BlocConsumer<RegisterBloc, RegisterState>(builder: (context, state) {
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
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        icon: Icon(Icons.vpn_key)),
                    controller: _password2Controller,
                    obscureText: true,
                  ),
                  //Fourth Element
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email', icon: Icon(Icons.email)),
                    controller: _emailController,
                  ),
                  //Fifth Element
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: ElevatedButton(
                        onPressed: state is! RegisterLoading
                            ? _onSignUpButtonPressed
                            : null,
                        child: Text(
                          'Sign Up',
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
                  //Sixth Element
                  Container(
                    padding: EdgeInsets.only(top: 5, bottom: 10),
                    child: TextButton(
                      child: Text('Login', style: TextStyle(fontSize: 15.0)),
                      onPressed: state is! RegisterLoading
                          ? () {
                              BlocProvider.of<AuthenticationBloc>(context)
                                  .add(LoggedOut());
                            }
                          : null,
                    ),
                  ),
                  //7th Element
                  Container(
                    child: state is RegisterLoading
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ))),
        ),
      );
    }, listener: (context, state) {
      //displays a snackbar with error message when error occurs
      if (state is RegisterFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${state.error}'),
          backgroundColor: Colors.red,
        ));
      }
    });
  }
}
