part of 'internet_bloc.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;
  InternetConnected({@required this.connectionType});

  @override
  List<Object> get props => [connectionType];

  @override
  String toString() {
    return 'InternetConnected: {connectionType : $connectionType}';
  }
}

class InternetDisconnected extends InternetState {}
