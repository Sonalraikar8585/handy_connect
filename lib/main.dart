import 'package:flutter/material.dart';
import 'screens/register_user.dart';
import 'screens/register_provider.dart';
import 'screens/list_providers.dart';
import 'screens/login.dart';  // <-- Import at the top

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HandyConnect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/register_user': (context) => RegisterUser(),
        '/register_provider': (context) => RegisterProvider(),
        '/list_providers': (context) => ListProviders(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("HandyConnect")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_user');
              },
              child: Text("Register as User"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register_provider');
              },
              child: Text("Register as Service Provider"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/list_providers');
              },
              child: Text("View Service Providers"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
