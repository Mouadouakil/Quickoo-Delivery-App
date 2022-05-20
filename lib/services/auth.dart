// ignore: library_prefixes

import 'package:dio/dio.dart' as Dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickoo/models/user.dart';
import 'package:quickoo/services/dio.dart';

class Auth extends ChangeNotifier {
  // ignore: unused_field
  bool _isloggedIn = false;

  late dynamic _user;
  // ignore: unused_field
  late dynamic _token;
  // ignore: prefer_const_constructors
  // ignore: unnecessary_new
  // ignore: prefer_const_constructors
  final storage = new FlutterSecureStorage();

  bool get authenticated => true;
  User get user => _user;
  // ignore: use_function_type_syntax_for_parameters
  void login({required Map creds}) async {
    Map data = {
      'email': creds['email'],
      'password': creds['password'],
    };
    try {
      Dio.Response response = await dio().post('/login', data: data);

      // ignore: avoid_print
      if (response.statusCode == 200) {
        if (response.data['success']) {
          // ignore: unnecessary_this
          this._isloggedIn = true;
          // ignore: unnecessary_this
          this._token = response.data['token'];
          // ignore: unnecessary_this
          this.storeToken(
              token: response.data['token'],
              role: response.data['role'],
              name: response.data['name'],
              email: response.data['email'],
              avatar: response.data['image']);

          // ignore: unnecessary_this
          this._user = User.fromJson(response.data);
          notifyListeners();
          if (response.data['role'].isNotEmpty) {
            if (response.data['role'].toString() == 'admin') {
              Navigator.pushReplacementNamed(creds['context'], '/admin');
            } else if (response.data['role'].toString() == 'livreur') {
              Navigator.popAndPushNamed(creds['context'], '/livreur');
            } else {
              Navigator.popAndPushNamed(creds['context'], '/client');
            }
          } else {
            Navigator.popAndPushNamed(creds['context'], '/home');
          }
        } else {
          _isloggedIn = false;

          // ignore: prefer_const_constructors
          notifyListeners();

          // ignore: prefer_const_constructors
          final snackBar = SnackBar(
              // ignore: prefer_const_constructors
              content: Text('email ou mot de passse nest pas valide'));

          // ignore: void_checks
          ScaffoldMessenger.of(creds['context']).showSnackBar(snackBar);
        }
        // ignore: avoid_print

      } else {
        _isloggedIn = false;
        // ignore: prefer_const_constructors

        notifyListeners();
        // ignore: prefer_const_constructors
        final snackBar = SnackBar(
            // ignore: prefer_const_constructors
            content: Text('error de connexion '));

        // ignore: void_checks
        ScaffoldMessenger.of(creds['context']).showSnackBar(snackBar);
      }

      // ignore: avoid_print

    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    // ignore: avoid_print
  }

  // ignore: non_constant_identifier_names
  void TokenExist({required Map storageData}) {
    // ignore: unnecessary_this
    if (storageData['token'] == null) {
      _isloggedIn = false;
      Navigator.pushReplacementNamed(storageData['context'], '/login');
    } else {
      // ignore: unnecessary_null_comparison
      try {
        // ignore: unnecessary_this

        _user = User(
            name: storageData['name'].toString(),
            email: storageData['email'].toString(),
            avatar: storageData['avatar'].toString());
        _isloggedIn = true;

        if (storageData['role'].toString() == 'admin') {
          Navigator.pushReplacementNamed(storageData['context'], '/admin');
        } else if (storageData['role'].toString() == 'livreur') {
          Navigator.pushReplacementNamed(storageData['context'], '/livreur');
        } else {
          Navigator.pushReplacementNamed(storageData['context'], '/client');
        }

        notifyListeners();
      } catch (e) {
        print(e);
      }
    }
  }

  void storeToken(
      {required String token,
      required String role,
      required String name,
      required String email,
      required String avatar}) async {
    // ignore: unnecessary_this
    this.storage.write(key: 'token', value: token);
    storage.write(key: 'role', value: role);
    storage.write(key: 'name', value: name);
    storage.write(key: 'email', value: email);
    storage.write(key: 'avatar', value: avatar);
  }

  void logout(context) {
    _isloggedIn = false;
    cleanUp();
    Navigator.pushNamedAndRemoveUntil(
        context, "/login", (Route<dynamic> route) => false);
    notifyListeners();
  }

  void cleanUp() async {
    _isloggedIn = false;
    _token = null;
    await storage.delete(key: 'token');
    await storage.delete(key: 'role');
    await storage.delete(key: 'name');
    await storage.delete(key: 'email');
    await storage.delete(key: 'avatar');
  }
}
