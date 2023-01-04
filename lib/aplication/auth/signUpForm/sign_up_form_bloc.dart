import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo/domain/repositories/auth_repository.dart';

part 'sign_up_form_event.dart';

part 'sign_up_form_state.dart';

class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final AuthRepository authRepository;

  SignUpFormBloc({required this.authRepository})
      : super(SignUpFormState(isSubmitting: false, showValidationMesseges: false)) {
    on<SignInWithEmailAndPasswordPress>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMesseges: true));
      } else {
        emit(SignUpFormState(isSubmitting: true, showValidationMesseges: false));
      }
      // TODO: implement authentication
    });

    on<RegisterWithEmailAndPasswordPress>((event, emit) {
      if (event.email == null || event.password == null) {
        emit(SignUpFormState(isSubmitting: false, showValidationMesseges: true));
      } else {
        emit(SignUpFormState(isSubmitting: true, showValidationMesseges: false));
      }
      // TODO: implement authentication
    });
  }
}
