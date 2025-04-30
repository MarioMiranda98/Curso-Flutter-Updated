import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/src/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/src/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo usuario')),
      body: const _RegisterView(),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlutterLogo(size: 100.0),
            BlocProvider(
              create: (_) => RegisterCubit(),
              child: _RegisterForm(),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final userName = registerCubit.state.userName;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;

    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            CustomTextFormField(
              label: 'Nombre de Usuario',
              onChanged: (value) => registerCubit.userNameChanged(value),
              errorMessage: userName.errorMessage,
            ),
            const SizedBox(height: 10.0),
            CustomTextFormField(
              label: 'Correo Electrónico',
              onChanged: (value) => registerCubit.emailChanged(value),
              errorMessage: email.errorMessage,
            ),
            const SizedBox(height: 10.0),
            CustomTextFormField(
              label: 'Contraseña',
              obscureText: true,
              onChanged: (value) => registerCubit.passwordChanged(value),
              errorMessage: password.errorMessage,
            ),
            const SizedBox(height: 20.0),
            FilledButton.tonalIcon(
              onPressed: () {
                registerCubit.onSubmit();
              },
              icon: const Icon(Icons.save),
              label: const Text('Crear usuario'),
            ),
          ],
        ),
      ),
    );
  }
}
