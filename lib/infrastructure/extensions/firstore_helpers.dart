import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/core/errors/errors.dart';
import 'package:todo/domain/repositories/auth_repository.dart';

import '../../injection.dart';

extension FirestorExt on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance.collection('users').doc(user.id.value);
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference<Map<String, dynamic>> get todoCollection => collection('todos');
}
