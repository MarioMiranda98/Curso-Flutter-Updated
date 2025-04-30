part of 'register_cubit.dart';

sealed class RegisterFormState extends Equatable {
  const RegisterFormState();
}

enum FormStatus { invalid, valid, validating, posting }

final class RegisterInitial extends RegisterFormState {
  const RegisterInitial({
    this.userName = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
  });

  final bool isValid;
  final FormStatus formStatus;
  final Username userName;
  final Email email;
  final Password password;

  RegisterInitial copyWith({
    FormStatus? formStatus,
    Username? userName,
    Email? email,
    Password? password,
    bool? isValid,
  }) => RegisterInitial(
    formStatus: formStatus ?? this.formStatus,
    userName: userName ?? this.userName,
    email: email ?? this.email,
    password: password ?? this.password,
    isValid: isValid ?? this.isValid,
  );

  @override
  List<Object> get props => [userName, email, password, formStatus, isValid];
}
