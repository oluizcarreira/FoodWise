// Tela 3.2: Cadastro - Gênero
// Arquivo: register_gender_screen.dart
import 'package:flutter/material.dart';

class RegisterGenderScreen extends StatelessWidget {
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
              'Qual o seu gênero?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            DropdownButtonFormField<String>(
              items: [
                DropdownMenuItem(value: 'Masculino', child: Text('Masculino')),
                DropdownMenuItem(value: 'Feminino', child: Text('Feminino')),
                DropdownMenuItem(value: 'Outro', child: Text('Outro')),
              ],
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Escolha uma opção',
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
