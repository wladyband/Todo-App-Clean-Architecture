import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/entities/todo.dart';

import '../../../../aplication/todo/controller/controller_bloc.dart';
import '../../routes/router.gr.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  void showDeletionDialog({required BuildContext context, required ControllerBloc bloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selected todo to delete:"),
            content: Text(
              todo.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    bloc.add(DeleteTodoEvent(todo: todo));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
        onTap: () {
          AutoRouter.of(context).push(TodoDetailPageRoute(todo: todo));
        },
        onLongPress: () {
          final controllerBloc = context.read<ControllerBloc>();
          showDeletionDialog(context: context, bloc: controllerBloc);
        },
        child: Material(
          elevation: 16,
          borderRadius: BorderRadius.circular(15),
          color: Colors.transparent,
          child: Container(
            decoration:
                BoxDecoration(color: todo.color.color, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.headline1!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    todo.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: themeData.textTheme.bodyText2!.copyWith(fontSize: 16),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            shape: const CircleBorder(),
                            activeColor: Colors.white,
                              checkColor: themeData.scaffoldBackgroundColor,
                              value: todo.done,
                              onChanged: (value) {
                                if (value != null) {
                                  BlocProvider.of<ControllerBloc>(context)
                                      .add(UpdateTodoEvent(todo: todo, done: value));
                                }
                              }),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
