part of 'sign_up_form_bloc.dart';

@immutable
abstract class SignUpFormEvent {}

class SignInWithEmailAndPasswordPress extends SignUpFormEvent {
  final String? email;
  final String? password;
  SignInWithEmailAndPasswordPress({required this.email, required this.password});
}

class RegisterWithEmailAndPasswordPress extends SignUpFormEvent {
  final String? email;
  final String? password;
  RegisterWithEmailAndPasswordPress({required this.email, required this.password});
}
