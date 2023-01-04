import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/auth_failures.dart';

abstract class AuthRepository {
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String emailAddress, required String password});
}
