import 'package:flutter/material.dart';
import 'package:mcs_app/assets/scripts/prefs.dart';
import 'package:mcs_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    Prefs.init = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    String token = Prefs.init?.getString(Prefs.token) ?? '';
    if (mounted) {
      if (token.isNotEmpty) {
        AuthService.checkToken(token).then((token) {
          if (Prefs.init?.getBool(Prefs.remember) ?? false) {
            Navigator.pushReplacementNamed(context, '/dashboard');
          } else {
            Navigator.pushReplacementNamed(context, '/auth');
          }
        }).catchError((err) {
          Prefs.init?.setString(Prefs.token, '');
          Navigator.pushReplacementNamed(context, '/auth');
        });
      } else {
        Prefs.init?.setString(Prefs.token, '');
        Navigator.pushReplacementNamed(context, '/auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              // Logo
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.settings_suggest,
                  size: 120,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 40),
              // App Name
              Text(
                'Taller de Reparación',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
              ),
              const SizedBox(height: 20),
              // Loading indicator
              const CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
