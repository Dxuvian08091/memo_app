part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends RegisterEvent {
  final String username;
  final String password;
  final String password2;
  final String email;
  final List notes;

  const SignUpButtonPressed(
      {@required this.username,
      @required this.password,
      @required this.password2,
      @required this.email,
      @required this.notes});

  @override
  List<Object> get props => [username, password, password2, email];

  @override
  String toString() =>
      'SignUpButtonPressed {username: $username, password: $password, password2: $password2, email: $email}';
}
