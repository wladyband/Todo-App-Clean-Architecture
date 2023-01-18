import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

part 'observer_event.dart';

part 'observer_state.dart';

@injectable
class ObserverBloc extends Bloc<ObserverEvent, ObserverState> {
  final TodoRepository todoRepository;

  StreamSubscription<Either<TodoFailures, List<Todo>>>? todoStreamSubscription;

  ObserverBloc({required this.todoRepository}) : super(ObserverInitial()) {
    on<ObserverEvent>((event, emit) async {
      emit(ObserverLoading());
      await todoStreamSubscription?.cancel();
      todoStreamSubscription = todoRepository
          .watchAll()
          .listen((failureOrTodos) => add(TodosUpdatedEvent(failureOrTodos: failureOrTodos)));
    });

    on<TodosUpdatedEvent>((event, emit) {
      event.failureOrTodos.fold((failures) => emit(ObserverFailure(todoFailure: failures)),
          (todos) => emit(ObserverSuccess(todos: todos)));
    });
  }

  @override
  Future<void> close() async {
    await todoStreamSubscription?.cancel();
    return super.close();
  }
}
