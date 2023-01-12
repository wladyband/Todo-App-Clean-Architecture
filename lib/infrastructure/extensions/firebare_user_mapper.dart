import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/entities/id.dart';
import 'package:todo/domain/entities/user.dart';

extension FirebaseUserToDomain on User {
  CustomUser toDomain() {
    return CustomUser(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}