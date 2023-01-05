part of 'sign_up_form_bloc.dart';

class SignUpFormState {
  final bool isSubmitting;
  final bool showValidationMesseges;
  final Option<Either<AuthFailure, Unit>> authFailureOrSuccessOption;

  SignUpFormState({
    required this.isSubmitting,
    required this.showValidationMesseges,
    required this.authFailureOrSuccessOption,
  });

  SignUpFormState copyWith({
    bool? isSubmitting,
    bool? showValidationMesseges,
    Option<Either<AuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return SignUpFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMesseges: showValidationMesseges ?? this.showValidationMesseges,
      authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
