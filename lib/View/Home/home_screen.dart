import 'package:flutter/material.dart';
import 'package:gazapay/View/Auth/register_screen.dart';

class HomeScreen extends StatelessWidget {
  static String id = "homeScreen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("الرئيسية"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, RegisterScreen.id);
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "مرحبا بك في غزة باي",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
