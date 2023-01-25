import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/todo/observer/observer_bloc.dart';
import 'package:todo/aplication/todo/observer/observer_bloc.dart';
import 'package:todo/ui/presentation/home/widgets/todo_card.dart';
import 'package:todo/ui/presentation/home/widgets/todo_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  static const double spacing = 20;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<ObserverBloc, ObserverState>(
      builder: (context, state) {
        if (state is ObserverInitial) {
          return Container();
        } else if (state is ObserverLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: themeData.colorScheme.secondary,
            ),
          );
        } else if (state is ObserverFailure) {
          return const Center(
            child: Text("Failure"),
          );
        } else if (state is ObserverSuccess) {
          return Padding(
            padding: const EdgeInsets.all(spacing),
            child: GridView.builder(
                itemCount: state.todos.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    crossAxisSpacing: spacing,
                    childAspectRatio: 4 / 5,
                    mainAxisSpacing: spacing),
                itemBuilder: (context, index) {
                  final todo = state.todos[index];
                  return TodoItem(todo: todo,);
                }),
          );
        }

        // ListView.builder(
        //     itemCount: state.todos.length,
        //     itemBuilder: (context, index){
        //       final todo = state.todos[index];
        //       return TodoCard(todo: todo);
        //     }
        // );

        return Container();
      },
    );
  }
}
