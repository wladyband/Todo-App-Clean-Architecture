import 'package:get_it/get_it.dart';
import 'package:todo/aplication/auth/signUpForm/sign_up_form_bloc.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async{

  // ! state management
  sl.registerFactory(() => SignUpFormBloc());
}