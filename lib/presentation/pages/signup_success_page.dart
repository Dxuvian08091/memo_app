import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up | Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //First Element
            Text(
              'Successfully Registered',
              style: TextStyle(fontSize: 24),
            ),
            //Second Element
            SizedBox(
              height: 2,
            ),
            //Third Element
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to Login',
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  IconButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(LoggedOut());
                      },
                      icon: Icon(Icons.login_rounded))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
