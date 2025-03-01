import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:mcs_app/services/auth_service.dart';
import 'package:mcs_app/widgets/button_widget.dart';
import 'package:mcs_app/widgets/msgDialog_widget.dart';
import 'package:mcs_app/widgets/textFormField_widget.dart';

class LoginSection extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController pwdController;
  final AuthState state;

  const LoginSection({
    super.key,
    required this.userController,
    required this.pwdController,
    required this.state,
  });

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
                  'Iniciar Sesión',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormFieldWidget(
                  controller: userController,
                  icon: Icons.person,
                  label: 'Usuario',
                ),
                const SizedBox(height: 20),
                TextFormFieldWidget(
                  controller: pwdController,
                  icon: Icons.lock,
                  label: 'Contraseña',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('Recuerdame'),
                  value: state.rememberMe,
                  onChanged: (value) => BlocProvider.of<AuthBloc>(context)
                      .add(ToggleRememberAuthEvent(value: value ?? false)),
                ),
                const SizedBox(height: 30),
                ButtonWidget(
                  isLoading: state.isLoading,
                  label: 'Iniciar Sesión',
                  style: ButtonWidget.NORMAL,
                  onPressed: () => _handleLogin(context, state.rememberMe),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context).add(GoToSignupEvent());
                    BlocProvider.of<AuthBloc>(context)
                        .add(EndLoadingAuthEvent());
                  },
                  child: const Text('¿No tienes una cuenta? Regístrate'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context, bool rememberMe) {
    BlocProvider.of<AuthBloc>(context).add(StartLoadingAuthEvent());
    AuthService.login(userController.text, pwdController.text).then((token) {
      Prefs.init?.setString(Prefs.token, token);
      Prefs.init?.setBool(Prefs.remember, rememberMe);
      BlocProvider.of<AuthBloc>(context).add(EndLoadingAuthEvent());
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (context) => MsgDialogWidget(
          msg: err.toString(),
          typeMsg: MsgDialogWidget.DANGER,
        ),
      );
      Prefs.init?.setBool(Prefs.remember, false);
      BlocProvider.of<AuthBloc>(context).add(EndLoadingAuthEvent());
    });
  }
}
