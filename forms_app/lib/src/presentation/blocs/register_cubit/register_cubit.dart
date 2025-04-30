import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/src/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterInitial> {
  RegisterCubit() : super(RegisterInitial());

  void userNameChanged(String value) {
    final username = Username.dirty(value: value);
    emit(
      state.copyWith(
        userName: username,
        isValid: Formz.validate([username, state.password, state.email]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value: value);

    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.userName, state.password]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value: value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.userName, state.email]),
      ),
    );
  }

  void onSubmit() {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        userName: Username.dirty(value: state.userName.value),
        password: Password.dirty(value: state.password.value),
        email: Email.dirty(value: state.email.value),
        isValid: Formz.validate([state.userName, state.password, state.email]),
      ),
    );
    print("Register Cubit: $state");
  }
}
