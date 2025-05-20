// screens/register_user.dart
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/user.dart';

class RegisterUser extends StatefulWidget {
  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  void _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final user = User(
        name: nameController.text,
        role: 'user',
        phone: phoneController.text,
      );
      try {
        await DatabaseHelper().insertUser(user);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User Registered")),
        );

        nameController.clear();
        phoneController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: Phone number might be taken.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register User")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
              validator: (val) => val!.isEmpty ? "Enter name" : null,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
              validator: (val) => val!.isEmpty ? "Enter phone" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _registerUser, child: Text("Register")),
            TextButton(
  onPressed: () {
    Navigator.pushReplacementNamed(context, '/login');
  },
  child: Text('Already have an account? Login'),
),

          ]),
        ),
      ),
    );
  }
}
