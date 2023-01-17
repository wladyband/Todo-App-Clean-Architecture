// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:todo/aplication/auth/authBloc/auth_bloc.dart' as _i8;
import 'package:todo/aplication/auth/signUpForm/sign_up_form_bloc.dart' as _i5;
import 'package:todo/aplication/todo/observer/observer_bloc.dart' as _i9;
import 'package:todo/domain/repositories/auth_repository.dart' as _i3;
import 'package:todo/domain/repositories/todo_repository.dart' as _i6;
import 'package:todo/infrastructure/repositories/auth_repository_impl.dart'
    as _i4;
import 'package:todo/infrastructure/repositories/todo_repository_impl.dart'
    as _i7;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of main-scope dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AuthRepository>(() => _i4.AuthRepositoryImpl());
  gh.factory<_i5.SignUpFormBloc>(
      () => _i5.SignUpFormBloc(authRepository: gh<_i3.AuthRepository>()));
  gh.factory<_i6.TodoRepository>(() => _i7.TodoRepositoryImpl());
  gh.factory<_i8.AuthBloc>(
      () => _i8.AuthBloc(authRepository: gh<_i3.AuthRepository>()));
  gh.factory<_i9.ObserverBloc>(
      () => _i9.ObserverBloc(todoRepository: gh<_i6.TodoRepository>()));
  return getIt;
}
