import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickoo/screens/admin_screen.dart';
import 'package:quickoo/screens/client_screen.dart';
// ignore: unused_import
import 'package:quickoo/screens/home_screen.dart';
import 'package:quickoo/screens/livreur_screen.dart';
import 'package:quickoo/screens/loading_screen.dart';
import 'package:quickoo/screens/loging_screen.dart';
import 'package:quickoo/services/auth.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        // Provider(create: (context) => SomeOtherClass()),
      ],
      // ignore: prefer_const_constructors
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // ignore: prefer_const_constructors
        '/home': (context) => HomeScreen(),
        // ignore: prefer_const_constructors
        '/login': (context) => LoginScreen(),
        // ignore: prefer_const_constructors
        '/admin': (context) => AdminScreen(),
        // ignore: prefer_const_constructors
        '/livreur': (context) => LivreurScreen(),
        // ignore: prefer_const_constructors
        '/client': (context) => ClientScreen(),
        // ignore: prefer_const_constructors
        '/': (context) => loadingScreen(),
      },
      // ignore: prefer_const_constructors
    );
  }
}
