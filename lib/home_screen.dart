// Tela 5: Página Inicial
// Arquivo: home_screen.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add_recipe_screen.dart'; // Import da tela de cadastro
import 'recipe_details_screen.dart'; // Import da nova tela

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.restaurant_menu, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'FOOD WISE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green[800],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Nenhuma receita cadastrada ainda.'));
          }

          final recipes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index].data() as Map<String, dynamic>;
              final recipeId = recipes[index].id;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailsScreen(
                        recipeId: recipeId,
                        recipeData: recipe,
                      ),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Imagem
                      recipe['image_url'] != null
                          ? Image.network(
                              recipe['image_url'],
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              height: 150,
                              color: Colors.grey[300],
                              child: Center(child: Icon(Icons.image, size: 50)),
                            ),
                      // Detalhes
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          recipe['title'] ?? 'Sem título',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                )),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () {
                    // Ação do botão "Início"
                  },
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Ação do botão "Pesquisar"
                  },
                ),
                SizedBox(width: 40), // Espaço para o botão central
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    // Ação do botão "Notificações"
                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    // Ação do botão "Perfil"
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: FloatingActionButton(
              backgroundColor: Colors.green[800],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddRecipeScreen()),
                );
              },
              child: Icon(Icons.add, size: 30, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
