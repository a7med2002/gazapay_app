import 'package:flutter/material.dart';
import 'package:gazapay/Provider/forgot_pin_provider.dart';
import 'package:gazapay/Provider/login_provider.dart';
import 'package:gazapay/Provider/register_provider.dart';
import 'package:gazapay/View/Auth/forgot_pin_screen.dart';
import 'package:gazapay/View/Auth/login_screen.dart';
import 'package:gazapay/View/Auth/register_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gazapay/View/Home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RegisterProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ForgotPinProvider()),
      ],
      child: MaterialApp(
        title: 'Gaza Pay',
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),

        supportedLocales: const [Locale('ar'), Locale('en')],

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(fontFamily: 'Tajawal'),
        home: LoginScreen(),
        routes: {
          RegisterScreen.id: (context) => const RegisterScreen(),
          LoginScreen.id: (context) => const LoginScreen(),
          ForgotPinScreen.id: (context) => const ForgotPinScreen(),
          HomeScreen.id: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
