part of 'google_signin_cubit.dart';

abstract class GoogleSigninState extends Equatable {
  const GoogleSigninState();

  @override
  List<Object> get props => [];
}

class GoogleSigninInitial extends GoogleSigninState {}

class GoogleSigninLoading extends GoogleSigninState {}

class GoogleSigninSuccess extends GoogleSigninState {}

class GoogleSigninError extends GoogleSigninState {}

class GoogleSigninLogout extends GoogleSigninState {}
