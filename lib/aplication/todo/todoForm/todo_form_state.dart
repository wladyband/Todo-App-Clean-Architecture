part of 'todo_form_bloc.dart';

class TodoFormState {
  final Todo todo;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<TodoFailure, Unit>> failureOrSuccessOption;

  TodoFormState(
      {required this.todo,
        required this.showErrorMessages,
        required this.isEditing,
        required this.isSaving,
        required this.failureOrSuccessOption});

  factory TodoFormState.initial() => TodoFormState(
      failureOrSuccessOption: none(),
      todo: Todo.empty(),
      showErrorMessages: false,
      isEditing: false,
      isSaving: false);

  TodoFormState copyWith({
    Todo? todo,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<TodoFailure, Unit>>? failureOrSuccessOption,
  }) {
    return TodoFormState(
      todo: todo ?? this.todo,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
      failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}