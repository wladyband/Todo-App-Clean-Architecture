import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/auth/authBloc/auth_bloc.dart';
import 'package:todo/aplication/todo/controller/controller_bloc.dart';
import 'package:todo/aplication/todo/observer/observer_bloc.dart';
import 'package:todo/core/failures/todo_failures.dart';
import 'package:todo/injection.dart';
import 'package:todo/ui/presentation/home/widgets/home_body.dart';
import 'package:todo/ui/presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  String mapFailureToMessage(TodoFailure todoFailure) {
    switch (todoFailure.runtimeType) {
      case InsufficientPermisssons:
        return "You have not the permissions to do that";
      case UnexpectedFailure:
        return "Something went wrong";

      default:
        return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    final observerBloc = sl<ObserverBloc>()..add(ObserveAllEvent());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => observerBloc),
        BlocProvider(
          create: (context) => sl<ControllerBloc>(),
        )
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthStateUnauthenticated) {
              AutoRouter.of(context).push(const SignUpPageRoute());
            }
          }),
          BlocListener<ControllerBloc, ControllerState>(listener: (context, state) {
            if (state is ControllerFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text(mapFailureToMessage(state.todoFailure))));
            }
          }),
        ],
        child: Scaffold(
          /*appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
                },
                icon: Icon(Icons.exit_to_app)),
            title: Text("tudo"),
          ),*/
          body: HomeBody(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () {
              AutoRouter.of(context).push(TodoDetailPageRoute(todo: null));
            },
            child: const Icon(
              Icons.add,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
