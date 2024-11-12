// Tela 2: Tela Inicial
// Arquivo: welcome_screen.dart
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo_verde.png', height: 100),
                    SizedBox(width: 10),
                    Image.asset('assets/images/logo_nome.png', height: 80),
                  ],
                ),
                SizedBox(height: 50),
                Text(
                  'Ótimo dia!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Como deseja acessar?',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/register_name');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade800),
                  child: Text('Registre-se'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text('Entrar', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ));
  }
}
