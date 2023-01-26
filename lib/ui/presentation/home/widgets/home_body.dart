import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/auth/authBloc/auth_bloc.dart';
import 'package:todo/aplication/todo/observer/observer_bloc.dart';
import 'package:todo/ui/presentation/core/image.dart';
import 'package:todo/ui/presentation/home/widgets/flexible_space.dart';
import 'package:todo/ui/presentation/home/widgets/progress_bar.dart';
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
          return SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  collapsedHeight: 70,
                  expandedHeight: 280,
                  backgroundColor: themeData.scaffoldBackgroundColor,
                  pinned: true,
                  flexibleSpace: const FlexibleSpace(),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(left: spacing, right: spacing),
                  sliver: SliverToBoxAdapter(
                    child: ProgressBar(todo: state.todos),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(spacing),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final todo = state.todos[index];
                        return TodoItem(todo: todo);
                      },
                      childCount: state.todos.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: spacing,
                        childAspectRatio: 4 / 5,
                        mainAxisSpacing: spacing),
                  ),
                ),
              ],
            ),
          );
        }

        return Container();
      },
    );
  }
}
