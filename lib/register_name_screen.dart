// Tela 3.1: Cadastro - Nome do Perfil
// Arquivo: register_name_screen.dart
import 'package:flutter/material.dart';

class RegisterNameScreen extends StatelessWidget {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Como deseja ser chamado(a)?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Nome',
                hintText: 'Digite como queira ser chamado',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800),
              child: Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}
