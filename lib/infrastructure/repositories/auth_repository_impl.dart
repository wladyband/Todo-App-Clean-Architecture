import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/core/failures/auth_failures.dart';
import 'package:todo/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final firebaseAuth = FirebaseAuth.instance;

  AuthRepositoryImpl();

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        return left(InvalidEmailAndPasswordCombination());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(EmailAlreadyInUse());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<void> signOut() => Future.wait([
    firebaseAuth.signOut(),
  ]);
}