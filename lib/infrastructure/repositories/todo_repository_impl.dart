import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/infrastructure/extensions/firstore_helpers.dart';
import 'package:todo/infrastructure/models/todo_model.dart';

@Injectable(as: TodoRepository)
class TodoRepositoryImpl implements TodoRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<Either<TodoFailure, Unit>> create(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);

      await userDoc.todoCollection.doc(todoModel.id).set(todoModel.toMap()); // creates a new document with the local generated unique id

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermisssons());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TodoFailure, Unit>> delete(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);
      await userDoc.todoCollection.doc(todoModel.id).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermisssons());
      } else if (e.code.contains('NOT_FOUND')) {
        return left(unableToUpdate());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TodoFailure, Unit>> update(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);

      await userDoc.todoCollection.doc(todoModel.id).update(todoModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code.contains('PERMISSION_DENIED')) {
        return left(InsufficientPermisssons());
      } else if (e.code.contains('NOT_FOUND')) {
        return left(unableToUpdate());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Stream<Either<TodoFailure, List<Todo>>> watchAll() async* {
    //yield left(const InsufficientPermissions());
    // users/{user ID}/notes/{todo ID}
    final userDoc = await firestore.userDocument();
    yield* userDoc.todoCollection
        .snapshots()
        .map((snapshot) => right<TodoFailure, List<Todo>>(snapshot.docs
        .map((doc) => TodoModel.fromFirestore(doc).toDomain()).toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') || e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermisssons());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        // ? check for the unauthenticated error
        // ! log.e(e.toString());  // we can log unexpected exceptions
        return left(UnexpectedFailure());
      }
    });
  }
}
