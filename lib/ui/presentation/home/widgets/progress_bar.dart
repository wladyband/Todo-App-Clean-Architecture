import 'package:flutter/material.dart';
import 'package:todo/domain/entities/todo.dart';

class ProgressBar extends StatelessWidget {
  final List<Todo> todo;

  const ProgressBar({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(10);
    return Material(
      elevation: 16,
      borderRadius: radius,
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor, borderRadius: radius),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Todos progress",
                style: Theme.of(context).textTheme.headline1!.copyWith(fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
