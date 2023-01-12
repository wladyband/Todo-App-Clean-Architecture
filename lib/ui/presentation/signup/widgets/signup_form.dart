import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/aplication/auth/signUpForm/sign_up_form_bloc.dart';
import 'package:todo/core/failures/auth_failures.dart';
import 'package:todo/ui/presentation/routes/router.gr.dart';
import 'package:todo/ui/presentation/signup/widgets/signin_register_button.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final themeData = Theme.of(context);

    late String email;
    late String password;

    String? validateEmail(String? input) {
      const emailRegex = r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
      if (input == null || input.isEmpty) {
        return "please enter email";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        email = input;
        return null;
      } else {
        return "Invalid e-mail";
      }
    }

    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter password";
      } else if (input.length >= 6) {
        password = input;
        return null;
      } else {
        return "short password";
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong";
        case EmailAlreadyInUse:
          return "email already in use";
        case InvalidEmailAndPasswordCombination:
          return "wrong password please try again";
        default:
          return "Something went wrong";
      }
    }

    return BlocConsumer<SignUpFormBloc, SignUpFormState>(
      
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {}, //! if none
            (either) => either.fold((failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content:
                          Text(mapFailureMessage(failure), style: themeData.textTheme.bodyText1)));
                }, (_) => {
              AutoRouter.of(context).replace(const HomePageRoute())
            }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode:
              state.showValidationMesseges ? AutovalidateMode.always : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                "Welcome",
                style: themeData.textTheme.headline1!
                    .copyWith(fontSize: 50, fontWeight: FontWeight.w500, letterSpacing: 4),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Please register or sign in",
                style: themeData.textTheme.headline1!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 4),
              ),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: "E-Mail",
                ),
                validator: validateEmail,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.disabled,
                cursorColor: Colors.white,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: validatePassword,
              ),
              const SizedBox(
                height: 40,
              ),
              SignInRegisterButton(
                buttonText: "Sign In",
                callBack: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpFormBloc>(context)
                        .add(SignInWithEmailAndPasswordPress(email: email, password: password));
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context)
                        .add(SignInWithEmailAndPasswordPress(email: null, password: null));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "invalid input",
                          style: themeData.textTheme.bodyText1,
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SignInRegisterButton(
                buttonText: "Register",
                callBack: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SignUpFormBloc>(context)
                        .add(RegisterWithEmailAndPasswordPress(email: email, password: password));
                  } else {
                    BlocProvider.of<SignUpFormBloc>(context)
                        .add(RegisterWithEmailAndPasswordPress(email: null, password: null));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          "invalid input",
                          style: themeData.textTheme.bodyText1,
                        ),
                      ),
                    );
                  }
                },
              ),
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 10,
                ),
                LinearProgressIndicator(
                  color: themeData.colorScheme.secondary,
                )
              ]
            ],
          ),
        );
      },
    );
  }
}
