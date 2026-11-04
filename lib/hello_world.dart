import 'package:flutter/material.dart';

class Helloworld extends StatelessWidget {
  const Helloworld({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Belajar Flutter"),
      ),
      body: const Center(
        child: Text("Hello World"),
      ),
    );
  }
}