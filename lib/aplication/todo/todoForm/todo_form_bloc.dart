import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/domain/entities/todo_color.dart';
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
      } else {
        emit(state);
      }
    });

    on<ColorChangedEvent>((event, emit) {
      emit(state.copyWith(todo: state.todo.copyWith(color: TodoColor(color: event.color))));
    });

    on<SafePressedEvent>((event, emit) async {
      Either<TodoFailure, Unit>? failureOrSuccess;
      emit(state.copyWith(isSaving: true, failureOrSuccessOption: none()));
      if (event.title != null && event.body != null ) { //&& event.color != null
        final Todo editedTodo = state.todo
            .copyWith(
           // color: TodoColor(color: event.color!),
            title: event.title, body: event.body);
        if (state.isEditing) {
          failureOrSuccess = await todoRepository.update(editedTodo);
        } else {
          failureOrSuccess = await todoRepository.create(editedTodo);
        }
      }
      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        failureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
  }
}
