// screens/register_provider.dart
import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/service_provider.dart';

class RegisterProvider extends StatefulWidget {
  @override
  _RegisterProviderState createState() => _RegisterProviderState();
}

class _RegisterProviderState extends State<RegisterProvider> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final serviceController = TextEditingController();
  final phoneController = TextEditingController();
  final locationController = TextEditingController();

  void _registerProvider() async {
    if (_formKey.currentState!.validate()) {
      final provider = ServiceProvider(
        name: nameController.text,
        service: serviceController.text,
        phone: phoneController.text,
        location: locationController.text,
      );
      try {
        await DatabaseHelper().insertProvider(provider);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Provider Registered")),
        );

        nameController.clear();
        serviceController.clear();
        phoneController.clear();
        locationController.clear();
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
      appBar: AppBar(title: Text("Register Provider")),
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
              controller: serviceController,
              decoration: InputDecoration(labelText: "Service (e.g., plumber)"),
              validator: (val) => val!.isEmpty ? "Enter service" : null,
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone"),
              keyboardType: TextInputType.phone,
              validator: (val) => val!.isEmpty ? "Enter phone" : null,
            ),
            TextFormField(
              controller: locationController,
              decoration: InputDecoration(labelText: "Location"),
              validator: (val) => val!.isEmpty ? "Enter location" : null,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _registerProvider, child: Text("Register")),
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
