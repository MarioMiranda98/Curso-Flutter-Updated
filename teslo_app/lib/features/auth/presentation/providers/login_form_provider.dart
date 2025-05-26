import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:teslo_app/features/shared/shared.dart';

class LoginFormState {
  const LoginFormState({
    this.email = const Email.pure(),
    this.isFormPosted = false,
    this.isPosting = false,
    this.isValid = false,
    this.password = const Password.pure(),
  });

  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  @override
  String toString() =>
      """
      isPosting: $isPosting,
      isFormPosted: $isFormPosted,
      isValid: $isValid,
      email: $email,
      password: $password,
    """;

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
  }) => LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    email: email ?? this.email,
    password: password ?? this.password,
  );
}

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier({required this.login}) : super(LoginFormState());

  final void Function(String, String) login;

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail, state.password]),
    );
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword, state.email]),
    );
  }

  void onFormSubmit() async {
    _touchAllFields();

    if (!state.isValid) return;

    login(state.email.value, state.password.value);
  }

  void _touchAllFields() {
    final Email email = Email.dirty(state.email.value);
    final Password password = Password.dirty(state.password.value);

    state = state.copyWith(
      email: email,
      password: password,
      isFormPosted: true,
      isValid: Formz.validate([email, password]),
    );
  }
}

final loginFormProvider =
    StateNotifierProvider<LoginFormNotifier, LoginFormState>((ref) {
      final authProviderN = ref.watch(authProvider.notifier);

      return LoginFormNotifier(login: authProviderN.loginUser);
    });
