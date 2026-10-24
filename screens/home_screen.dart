import 'package:app_layout/screens/lista_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskFlow"), // ALTERADO: novo nome
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Seja bem-vindo ao TaskFlow"), // ALTERADO: novo nome
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // push abre a lista, que controla o cadastro das tarefas.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListaScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
