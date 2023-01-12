import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
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
  Stream<Either<TodoFailures, List<Todo>>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }
}