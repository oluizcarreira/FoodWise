import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecipeDetailsScreen extends StatelessWidget {
  final String recipeId; // ID da receita
  final Map<String, dynamic> recipeData; // Dados da receita

  RecipeDetailsScreen({required this.recipeId, required this.recipeData});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(recipeData['title'] ?? 'Detalhes da Receita'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem da Receita
            recipeData['image_url'] != null
                ? Image.network(
                    recipeData['image_url'],
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.image, size: 50)),
                  ),
            SizedBox(height: 16),
            // Título
            Text(
              recipeData['title'] ?? 'Sem título',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Ingredientes
            Text(
              'Ingredientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(recipeData['ingredients'].join(', ')),
            SizedBox(height: 16),
            // Modo de Preparo
            Text(
              'Modo de Preparo:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(recipeData['steps'] ?? 'Sem descrição'),
            SizedBox(height: 24),
            // Botão de Excluir (somente para o criador da receita)
            if (recipeData['user_id'] == currentUser?.uid)
              ElevatedButton.icon(
                onPressed: () async {
                  final confirmation = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Confirmar Exclusão'),
                      content: Text('Tem certeza de que deseja excluir esta receita?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          child: Text('Excluir'),
                        ),
                      ],
                    ),
                  );

                  if (confirmation == true) {
                    await FirebaseFirestore.instance.collection('recipes').doc(recipeId).delete();
                    Navigator.of(context).pop(); // Retorna para a tela inicial
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Receita excluída com sucesso!')),
                    );
                  }
                },
                icon: Icon(Icons.delete),
                label: Text('Excluir Receita'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
