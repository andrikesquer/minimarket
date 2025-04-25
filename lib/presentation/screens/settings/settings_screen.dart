import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              context.go('/:email');
            },
          ),
          title: Text(
            'Ajustes',
            style: TextStyle(fontSize: 24, decoration: TextDecoration.none),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                context.go('/:email');
              },
            ),
          ],
        ),
      ),
    );
  }
}
