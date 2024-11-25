import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _stepsController = TextEditingController();
  File? _recipeImage;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _recipeImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadRecipe() async {
    if (_recipeImage != null &&
        _titleController.text.isNotEmpty &&
        _ingredientController.text.isNotEmpty &&
        _stepsController.text.isNotEmpty) {
      try {
        // Upload da imagem para o Firebase Storage
        String imageName = DateTime.now().millisecondsSinceEpoch.toString();
        UploadTask uploadTask = _storage
            .ref('recipes/$imageName')
            .putFile(_recipeImage!);

        TaskSnapshot snapshot = await uploadTask;
        String imageUrl = await snapshot.ref.getDownloadURL();

        // Salvar os dados no Firestore
        await _firestore.collection('recipes').add({
  'title': _titleController.text,
  'ingredients': _ingredientController.text.split(','),
  'steps': _stepsController.text,
  'image_url': imageUrl,
  'created_at': Timestamp.now(),
  'user_id': FirebaseAuth.instance.currentUser!.uid, // Salva o ID do usuário
});


        // Exibir mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Receita cadastrada com sucesso!')),
        );

        // Retornar para a tela inicial
        Navigator.of(context).pop();
      } catch (e) {
        // Exibir mensagem de erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar a receita: $e')),
        );
      }
    } else {
      // Exibir mensagem de erro se os campos estiverem vazios
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos e selecione uma imagem!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Receita'),
        backgroundColor: Colors.green[800],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Upload de Imagem
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.photo_library),
                          title: Text('Escolher da Galeria'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Tirar Foto'),
                          onTap: () {
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: _recipeImage == null
                  ? Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.grey[700],
                      ),
                    )
                  : Image.file(
                      _recipeImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 16),
            // Título da Receita
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título da Receita',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Ingredientes
            TextField(
              controller: _ingredientController,
              decoration: InputDecoration(
                labelText: 'Ingredientes (separe por vírgulas)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Passo a Passo
            TextField(
              controller: _stepsController,
              decoration: InputDecoration(
                labelText: 'Modo de Preparo',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botão de Cancelar
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.cancel),
                  label: Text('Cancelar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                // Botão de Confirmar
                ElevatedButton.icon(
                  onPressed: _uploadRecipe,
                  icon: Icon(Icons.check),
                  label: Text('Confirmar'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
