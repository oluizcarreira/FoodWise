// Tela 1: Tela de Carregamento
// Arquivo: loading_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Aguarde 3 segundos e então navegue para a tela de boas-vindas.
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/welcome');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_branco.png', height: 100),
            SizedBox(height: 20),
            Image.asset('assets/images/logo_nome.png', height: 50)
          ],
        ),
      ),
    );
  }
}