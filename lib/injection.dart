import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todo/aplication/auth/signUpForm/sign_up_form_bloc.dart';
import 'package:todo/domain/repositories/auth_repository.dart';
import 'package:todo/infrastructure/repositories/auth_repository_impl.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async{

  // ! state management
  sl.registerFactory(() => SignUpFormBloc(authRepository: sl()));

  //! repositories
  sl.registerLazySingleton<AuthRepository>(
          () => AuthRepositoryImpl(firebaseAuth: sl()));

//! External
  final firebase = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebase);
}