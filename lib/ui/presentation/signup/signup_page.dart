import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/auth/signUpForm/sign_up_form_bloc.dart';
import 'package:todo/injection.dart';
import 'package:todo/ui/presentation/signup/widgets/signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<SignUpFormBloc>(),
        child: SignUpForm(),
      ),
    );
  }
}
