// screens/login_screen.dart
import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _phone = '';
  String _role = 'user'; // default role is 'user'
  bool _isLoading = false;

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    final dbHelper = DatabaseHelper();

    bool exists = false;
    if (_role == 'user') {
      exists = await dbHelper.checkUserPhone(_phone);
    } else {
      exists = await dbHelper.checkProviderPhone(_phone);
    }

    setState(() {
      _isLoading = false;
    });

    if (exists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login successful as $_role!")),
      );

      // Navigate to home or dashboard here, e.g.
      // Navigator.pushReplacementNamed(context, '/home');

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No $_role found with this phone.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: _role,
                decoration: InputDecoration(labelText: "Select Role"),
                items: [
                  DropdownMenuItem(
                    child: Text("User"),
                    value: "user",
                  ),
                  DropdownMenuItem(
                    child: Text("Service Provider"),
                    value: "provider",
                  ),
                ],
                onChanged: (val) {
                  setState(() {
                    _role = val!;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Please enter phone number";
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(val)) {
                    return "Enter valid 10-digit phone number";
                  }
                  return null;
                },
                onSaved: (val) => _phone = val!.trim(),
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
