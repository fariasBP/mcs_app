import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';

class SignupSection extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthState state;
  SignupSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Crear Cuenta Nueva',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormFieldWidget(
                  controller: _nameController,
                  icon: Icons.person,
                  label: 'Nombre Completo',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _emailController,
                  icon: Icons.email,
                  label: 'Correo Electrónica',
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _passwordController,
                  icon: Icons.lock,
                  label: 'Contraseña',
                  obscureText: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: _confirmPasswordController,
                  icon: Icons.lock,
                  label: 'Confirmar Contraseña',
                  obscureText: true,
                  onChanged: (value) {},
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                    isLoading: state.isLoading,
                    label: 'Registrarse',
                    style: ButtonWidget.NORMAL,
                    onPressed: () => _handleSignup(context)),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(GoToLoginEvent());
                    BlocProvider.of<AuthBloc>(context)
                        .add(EndLoadingAuthEvent());
                  },
                  child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignup(BuildContext context) {
    BlocProvider.of<AuthBloc>(context).add(StartLoadingAuthEvent());
  }
}
