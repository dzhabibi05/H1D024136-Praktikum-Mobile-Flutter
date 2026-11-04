import 'package:flutter/material.dart';
import 'package:flutter_application_1/sidemenu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _namaUser;

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  // Fungsi untuk mengambil username yang tersimpan di Local Storage
  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _namaUser = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(child: Text('Ini adalah halaman User $_namaUser')),
      drawer: const Sidemenu(),
    );
  }
}
