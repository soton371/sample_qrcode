part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class DoLoginEvent extends LoginEvent {
  final String username,password;
  const DoLoginEvent({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

