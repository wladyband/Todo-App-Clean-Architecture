import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/domain/repositories/todo_repository.dart';

part 'todo_form_event.dart';

part 'todo_form_state.dart';

@injectable
class TodoFormBloc extends Bloc<TodoFormEvent, TodoFormState> {
  final TodoRepository todoRepository;
  TodoFormBloc({required this.todoRepository}) : super(TodoFormState.initial()) {
    on<InitializeTodoDetailPage>((event, emit) {
      if (event.todo != null) {
        emit(state.copyWith(todo: event.todo, isEditing: true));
      }else{
        emit(state);
      }
    });
  }
}
