import 'package:app_layout/models/tarefa.dart';
import 'package:app_layout/screens/form_tarefa_screen.dart';
import 'package:flutter/material.dart';

class ListaScreen extends StatefulWidget {
  const ListaScreen({super.key});

  @override
  State<ListaScreen> createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
  // Fica fora de build para não ser recriada a cada atualização da tela.
  final List<Tarefa> listaDeTarefas = [];

  Future<void> adicionarTarefa() async {
    // push abre o formulário e aguarda a tarefa devolvida por pop.
    final tarefa = await Navigator.push<Tarefa>(
      context,
      MaterialPageRoute(builder: (context) => const FormTarefaScreen()),
    );

    if (!mounted || tarefa == null) return;

    // setState informa ao Flutter que a lista mudou e deve ser redesenhada.
    setState(() {
      listaDeTarefas.add(tarefa);
    });
  }

  // ALTERADO: novo método que abre o formulário já preenchido
  // e substitui a tarefa na mesma posição da lista.
  Future<void> editarTarefa(int index) async {
    final tarefaEditada = await Navigator.push<Tarefa>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FormTarefaScreen(tarefa: listaDeTarefas[index]),
      ),
    );

    if (!mounted || tarefaEditada == null) return;

    setState(() {
      listaDeTarefas[index] = tarefaEditada;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TaskFlow"), // ALTERADO: novo nome
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(listaDeTarefas[index].nome),
              subtitle: Text(listaDeTarefas[index].descricao),
              // ALTERADO: Row com dois ícones (editar + lixeira).
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => editarTarefa(index),
                    icon: const Icon(Icons.edit),
                    color: Colors.blue,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        listaDeTarefas.removeAt(index);
                      });
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: listaDeTarefas.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: adicionarTarefa,
        child: const Icon(Icons.add),
      ),
    );
  }
}
