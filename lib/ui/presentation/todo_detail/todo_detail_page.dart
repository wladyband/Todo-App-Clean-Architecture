import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/todo/todoForm/todo_form_bloc.dart';
import 'package:todo/domain/entities/todo.dart';
import 'package:todo/injection.dart';
import 'package:todo/ui/presentation/routes/router.gr.dart';
import 'package:todo/ui/presentation/todo_detail/widgets/safe_progress_over_lay.dart';
import 'package:todo/ui/presentation/todo_detail/widgets/todo_form.dart';

class TodoDetailPage extends StatelessWidget {
  final Todo? todo;

  const TodoDetailPage({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
          sl<TodoFormBloc>()..add(InitializeTodoDetailPage(todo: todo)),
      child: BlocConsumer<TodoFormBloc, TodoFormState>(
        listenWhen: (previous, current) => previous.failureOrSuccessOption != current.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(
           () => {},
          (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
          (failure) =>  ScaffoldMessenger.of(context).showSnackBar(
                const  SnackBar(
                  content: Text("failure"),
                  backgroundColor: Colors.redAccent )),
             (_) => Navigator.of(context).popUntil(
                    (route) => route.settings.name == HomePageRoute.name)));
        },
        builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(todo == null ? "Create Todo" : "Edit Todo"),
            ),
            body: Stack(
              children: [
                const TodoForm(),
                SafeInProgressOverLay(isSaving: state.isSaving)],
            ),
          );
        },
      ),
    );
  }
}
