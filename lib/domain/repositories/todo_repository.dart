import 'package:dartz/dartz.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/entities/todo.dart';

abstract class TodoRepository {
  Stream<Either<TodoFailures, List<Todo>>> watchAll();

  Future<Either<TodoFailures, Unit>> create(Todo todo);

  Future<Either<TodoFailures, Unit>> update(Todo todo);

  Future<Either<TodoFailures, Unit>> delete(Todo todo);
}