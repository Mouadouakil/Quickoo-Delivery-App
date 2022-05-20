import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:quickoo/screens/home_screen.dart';
import 'package:quickoo/services/auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// ignore: camel_case_types
class loadingScreen extends StatefulWidget {
  const loadingScreen({Key? key}) : super(key: key);

  @override
  _loadingScreenState createState() => _loadingScreenState();
}

// ignore: camel_case_types
class _loadingScreenState extends State<loadingScreen> {
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    readToken();
  }

  void readToken() async {
    String? token = await storage.read(key: 'token');
    String? role = await storage.read(key: 'role');
    String? avatar = await storage.read(key: 'avatar');
    String? name = await storage.read(key: 'name');
    String? email = await storage.read(key: 'email');
    print(role);
    Map storageData = {
      'token': token,
      'role': role,
      'avatar': avatar,
      'name': name,
      'email': email,
      'context': context
    };
    Provider.of<Auth>(context, listen: false)
        .TokenExist(storageData: storageData);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.amber[600],
            // ignore: prefer_const_constructors
            body: Center(
              // ignore: prefer_const_constructors
              child: SpinKitHourGlass(
                color: Colors.white,
                size: 50.0,
              ),
            ),
          ),
        ));
  }
}
