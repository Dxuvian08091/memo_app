part of 'internet_bloc.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class InternetConnection extends InternetEvent {
  final ConnectionType connectionType;
  InternetConnection({@required this.connectionType});

  @override
  List<Object> get props => [connectionType];

  @override
  String toString() {
    return 'InternetConnection: {connectionType : $connectionType}';
  }
}

class InternetDisconnection extends InternetEvent {}
