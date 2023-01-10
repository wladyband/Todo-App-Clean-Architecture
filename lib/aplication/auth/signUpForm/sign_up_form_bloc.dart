import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:todo/core/failures/auth_failures.dart';
import 'package:todo/domain/repositories/auth_repository.dart';

part 'sign_up_form_event.dart';

part 'sign_up_form_state.dart';

@injectable
class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthRepository authRepository;

  SignUpFormBloc({required this.authRepository})
      : super(SignUpFormState(
            isSubmitting: false,
            showValidationMesseges: false,
            authFailureOrSuccessOption: none())) {
    on<SignInWithEmailAndPasswordPress>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMesseges: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMesseges: false));
        final failureOrSuccess = await authRepository.signInWithEmailAndPassword(
            emailAddress: event.email!, password: event.password!);
        emit(state.copyWith(
            isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<RegisterWithEmailAndPasswordPress>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMesseges: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMesseges: false));
        final failureOrSuccess = await authRepository.registerWithEmailAndPassword(
            emailAddress: event.email!, password: event.password!);
        emit(state.copyWith(
            isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });
  }
}
