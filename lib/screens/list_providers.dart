import 'package:flutter/material.dart';
import '../../db/database_helper.dart';
import '../../models/service_provider.dart';

class ListProviders extends StatelessWidget {
  Future<List<ServiceProvider>> _fetchProviders() async {
    final db = await DatabaseHelper().db;
    final maps = await db.query('service_providers');

    return List.generate(maps.length, (i) {
      final map = maps[i];
      return ServiceProvider(
        id: map['id'] as int?,                          // cast to int?
        name: (map['name'] as String?) ?? '',           // cast to String?, default ''
        service: (map['service'] as String?) ?? '',
        phone: (map['phone'] as String?) ?? '',
        location: (map['location'] as String?) ?? '',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Available Providers")),
      body: FutureBuilder<List<ServiceProvider>>(
        future: _fetchProviders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final providers = snapshot.data!;
          return ListView.builder(
            itemCount: providers.length,
            itemBuilder: (context, index) {
              final sp = providers[index];
              return ListTile(
                title: Text(sp.name),
                subtitle: Text('${sp.service} • ${sp.phone} • ${sp.location}'),
              );
            },
          );
        },
      ),
    );
  }
}
