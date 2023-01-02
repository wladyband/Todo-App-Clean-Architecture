part of 'sign_up_form_bloc.dart';

class SignUpFormState {
  final bool isSubmitting;
  final bool showValidationMesseges;

  SignUpFormState({required this.isSubmitting, required this.showValidationMesseges});

  SignUpFormState copyWith({
    bool? isSubmitting,
    bool? showValidationMesseges,
  }) {
    return SignUpFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMesseges: showValidationMesseges ?? this.showValidationMesseges,
    );
  }
}

