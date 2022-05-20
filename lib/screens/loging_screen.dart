import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
// ignore: unused_import
import 'package:quickoo/screens/home_screen.dart';
import 'package:quickoo/services/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  // ignore: prefer_final_fields
  // ignore: unused_field
  final TextEditingController _emailController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _passwordController = TextEditingController();
  // ignore: unused_field
  final _formkey = GlobalKey<FormState>();
  // ignore: prefer_const_constructors

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(60, 100, 60, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  CircleAvatar(
                    // ignore: prefer_const_constructors
                    radius: 40,
                    // ignore: prefer_const_constructors
                    backgroundImage: AssetImage('asset/logo.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 50),

                  TextFormField(
                    controller: _emailController,
                    validator: (value) =>
                        value!.isEmpty ? 'please enter validate email' : null,
                    decoration: const InputDecoration(
                      labelText: 'Email : ',

                      border: OutlineInputBorder(),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 40),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) => value!.isEmpty
                        ? 'please enter validate Password'
                        : null,
                    decoration: const InputDecoration(
                      labelText: 'Password : ',
                      border: OutlineInputBorder(),
                      isDense: true, // Added this
                      contentPadding: EdgeInsets.all(15),
                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(height: 40),
                  // ignore: deprecated_member_use
                  // ignore: prefer_const_constructors
                  // ignore: deprecated_member_use
                  RaisedButton(
                    // ignore: prefer_const_constructors
                    child: Text('Login',
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          letterSpacing: 1,
                        )),
                    // ignore: prefer_const_constructors
                    shape: RoundedRectangleBorder(
                        // ignore: prefer_const_constructors
                        borderRadius: BorderRadius.all(Radius.circular(16.0))),
                    // ignore: prefer_const_constructors
                    padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                    color: Colors.amber[800],
                    onPressed: () {
                      Map creds = {
                        'email': _emailController.text,
                        'password': _passwordController.text,
                        'context': context
                      };

                      if (_formkey.currentState!.validate()) {
                        Provider.of<Auth>(context, listen: false).login(
                          creds: creds,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
