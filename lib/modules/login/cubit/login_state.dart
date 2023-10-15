part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {
  final ShopLoginModel loginModel;

  LoginSuccessState({required this.loginModel});
}

final class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

final class ChangePasswordVisibilityState extends LoginState {}
