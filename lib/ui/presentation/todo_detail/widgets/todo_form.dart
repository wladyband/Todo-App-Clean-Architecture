import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/todo/todoForm/todo_form_bloc.dart';

class TodoForm extends StatelessWidget {
  TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final textEditingControllerTitle = TextEditingController();
    final textEditingControllerBody = TextEditingController();

    late String title;
    late String body;

    String? validateTitle(String? input) {
      if (input == null || input == input.isEmpty) {
        return "please enter a title";
      }else if(input.length < 30){
        title = input;
        return null;
      }else{
        return "title too long";
      }
    }

    String? validateBody(String? input) {
      if (input == null || input == input.isEmpty) {
        return "please enter a description";
      }else if(input.length < 300){
        body = input;
        return null;
      }else{
        return "body too long";
      }
    }

    return BlocConsumer<TodoFormBloc, TodoFormState>(
      listenWhen: (p, c) => p.isEditing != c.isEditing,
      listener: (context, state) {
        textEditingControllerTitle.text = state.todo.title;
        textEditingControllerBody.text = state.todo.body;
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Form(
            key: formKey,
            autovalidateMode:
                state.showErrorMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
            child: Column(
              children: [
                TextFormField(
                  validator: validateTitle,
                  controller: textEditingControllerTitle,
                  decoration: InputDecoration(
                      labelText: "Title",
                      counterText: "",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  maxLength: 100,
                  maxLines: 2,
                  minLines: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validateBody,
                  controller: textEditingControllerBody,
                  decoration: InputDecoration(
                      labelText: "Body",
                      counterText: "",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
                  maxLength: 300,
                  maxLines: 8,
                  minLines: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
