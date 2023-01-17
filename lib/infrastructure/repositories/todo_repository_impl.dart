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
  Future<Either<TodoFailures, Unit>> create(Todo todo) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoFailures, Unit>> delete(Todo todo) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoFailures, Unit>> update(Todo todo) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Stream<Either<TodoFailures, List<Todo>>> watchAll() async* {
    //yield left(const InsufficientPermissions());
    // users/{user ID}/notes/{todo ID}
    final userDoc = await firestore.userDocument();
    yield* userDoc.todoCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map((snapshot) => right<TodoFailures, List<Todo>>(
            snapshot.docs.map((doc) => TodoModel.fromFirestore(doc).toDomain()).toList()))
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
