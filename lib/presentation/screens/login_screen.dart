import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/repository/user_repository.dart';
import 'package:flutter_app/presentation/pages/login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;
  LoginScreen({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login | Memo'),
      ),
      body: LoginForm(),
    );
  }
}
