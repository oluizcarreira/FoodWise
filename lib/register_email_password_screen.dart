// Tela 3.3: Cadastro - E-mail e Senha
// Arquivo: register_email_password_screen.dart
import 'package:flutter/material.dart';

class RegisterEmailPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'E-mail',
                hintText: 'Digite seu e-mail',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Repita o e-mail',
                hintText: 'Repita o e-mail',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Crie uma senha',
              ),
              obscureText: true,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Repita sua senha',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
