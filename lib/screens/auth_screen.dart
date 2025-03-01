import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mcs_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:mcs_app/screens/auth/login_section.dart';
import 'package:mcs_app/screens/auth/signup_section.dart';

class AuthScreen extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) => Row(
          children: [
            // Left Panel - Decorative
            Expanded(flex: 3, child: _buildLeftSectionAuth(context)),
            // Right Panel - Login Form
            Expanded(
              flex: 2,
              child: _buildRightSectionAuth(state),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftSectionAuth(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/img/logo2x.png',
              width: 250,
              height: 250,
              color: Colors.white,
            ),
            // const SizedBox(height: 5),
            Text(
              'MITEX',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 90,
                fontWeight: FontWeight.bold,
                height: 0.9,
              ),
            ),
            // const SizedBox(height: 10),
            Text(
              'SERVICIO TÉCNICO',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 17,
                letterSpacing: 7.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightSectionAuth(AuthState state) {
    return state.login
        ? LoginSection(
            userController: _userController,
            pwdController: _pwdController,
            state: state,
          )
        : SignupSection(state: state);
  }
}
