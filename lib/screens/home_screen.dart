import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: unused_import
import 'package:quickoo/screens/loging_screen.dart';
import 'package:quickoo/services/auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Consumer<Auth>(builder: (context, auth, child) {
      if (auth.authenticated) {
        return Scaffold(
          appBar: AppBar(
            // ignore: prefer_const_constructors
            title: Text('Flutter quickoo'),
          ),
          // ignore: prefer_const_constructors
          body: Center(

              // ignore: prefer_const_constructors
              child: Text('home page')),

          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                // ignore: prefer_const_constructors
                DrawerHeader(
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      // ignore: prefer_const_constructors
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: 10),
                      // ignore: prefer_const_constructors
                      Text(
                        'Drawer Header',
                        // ignore: prefer_const_constructors
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                    // ignore: prefer_const_constructors
                  ),
                  // ignore: prefer_const_constructors
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  // ignore: prefer_const_constructors
                ),
                // ignore: prefer_const_constructors

                ListTile(
                  // ignore: prefer_const_constructors
                  title: Text('logout'),
                  // ignore: prefer_const_constructors
                  leading: Icon(Icons.logout),
                  onTap: () {
                    Provider.of<Auth>(context, listen: false).logout(context);
                  },
                ),
              ],
            ),
          ),
        );
      } else {
        return Center(
            child: Center(
          child: Scaffold(
            // ignore: prefer_const_constructors
            body: Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.all(100),

              // ignore: deprecated_member_use
              child: RaisedButton(
                // ignore: prefer_const_constructors
                child: Text('Password ou email nest pas valide reconnecter'),
                textColor: Colors.red,
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/login');
                },
              ),
            ),
          ),
        ));
      }
    }));
  }
}
