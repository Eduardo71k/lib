import 'package:app_layout/models/tarefa.dart';
import 'package:flutter/material.dart';

// ALTERADO: virou StatefulWidget para criar os controllers uma única vez
// e preenchê-los com os dados da tarefa quando for edição.
class FormTarefaScreen extends StatefulWidget {
  // ALTERADO: tarefa opcional. null = nova tarefa; preenchida = edição.
  final Tarefa? tarefa;

  const FormTarefaScreen({super.key, this.tarefa});

  @override
  State<FormTarefaScreen> createState() => _FormTarefaScreenState();
}

class _FormTarefaScreenState extends State<FormTarefaScreen> {
  late final TextEditingController nomeController;
  late final TextEditingController descricaoController;

  @override
  void initState() {
    super.initState();
    // ALTERADO: se veio uma tarefa, os campos já abrem preenchidos.
    nomeController = TextEditingController(text: widget.tarefa?.nome ?? "");
    descricaoController =
        TextEditingController(text: widget.tarefa?.descricao ?? "");
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ALTERADO: o título muda conforme o modo (novo ou edição).
    final bool editando = widget.tarefa != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(editando ? "TaskFlow - Editar" : "TaskFlow - Nova"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              child: TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Nome",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: descricaoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Descrição",
              ),
            ),
          ),
          SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                var nomeDaTarefa = nomeController.text;
                var descricaoDaTarefa = descricaoController.text;

                // pop fecha o formulário e devolve a tarefa (nova ou editada).
                Navigator.pop(context, Tarefa(nomeDaTarefa, descricaoDaTarefa));
              },
              // ALTERADO: texto do botão conforme o modo.
              child: Text(editando ? "Atualizar" : "Salvar"),
            ),
          ),
        ],
      ),
    );
  }
}
