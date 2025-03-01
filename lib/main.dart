import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:mcs_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:mcs_app/bloc/brands_bloc/brands_bloc.dart';
import 'package:mcs_app/bloc/companies_bloc/companies_bloc.dart';
import 'package:mcs_app/bloc/machines_bloc/machines_bloc.dart';
import 'package:mcs_app/bloc/navDsb_bloc/navDsb_bloc.dart';
import 'package:mcs_app/bloc/protocols_bloc/protocols_bloc.dart';
import 'package:mcs_app/bloc/services_bloc/services_bloc.dart';
import 'package:mcs_app/bloc/types_bloc/types_bloc.dart';
import 'package:mcs_app/screens/auth_screen.dart';
import 'package:mcs_app/screens/dashboard_screen.dart';
import 'package:mcs_app/screens/splash_screen.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<NavDsbBloc>(create: (_) => NavDsbBloc()),
        BlocProvider<CompaniesBloc>(create: (_) => CompaniesBloc()),
        BlocProvider<BrandsBloc>(create: (_) => BrandsBloc()),
        BlocProvider<TypesBloc>(create: (_) => TypesBloc()),
        BlocProvider<ProtocolsBloc>(create: (_) => ProtocolsBloc()),
        BlocProvider<MachinesBloc>(create: (_) => MachinesBloc()),
        BlocProvider<ServicesBloc>(create: (_) => ServicesBloc()),
      ],
      child: MaterialApp(
        title: 'Taller de Reparación',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color(0xff142E67),
          // primaryColor: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xff142E67),
            shadow: Color.fromARGB(255, 224, 227, 233),
          ),
          fontFamily: 'Poppins',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 13),
            bodyMedium: TextStyle(fontSize: 13),
            bodySmall: TextStyle(fontSize: 13),
            displayLarge: TextStyle(fontSize: 13),
            displayMedium: TextStyle(fontSize: 13),
            displaySmall: TextStyle(fontSize: 13),
            headlineLarge: TextStyle(fontSize: 13),
            headlineMedium: TextStyle(fontSize: 13),
            headlineSmall: TextStyle(fontSize: 13),
            titleLarge: TextStyle(fontSize: 13),
            titleMedium: TextStyle(fontSize: 13),
            titleSmall: TextStyle(fontSize: 13),
            labelLarge: TextStyle(fontSize: 13),
            labelMedium: TextStyle(fontSize: 13),
            labelSmall: TextStyle(fontSize: 13),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 13),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/auth': (context) => AuthScreen(),
          '/dashboard': (context) => const DashboardScreen(),
          // '/dashboard1': (context) => const Dashboard1Screen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
