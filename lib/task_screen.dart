// Importa pacotes essenciais do Flutter e para persistência local
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Importa o modelo Task para manipular tarefas
import 'task_model.dart';

// Widget com estado que representa a tela principal de tarefas
class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  // Controlador para o campo de texto onde o usuário digita a nova tarefa
  final TextEditingController _controller = TextEditingController();

  // Lista de tarefas que será exibida e manipulada na tela
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    // Carrega as tarefas salvas ao iniciar a tela
    _loadTasks();
  }

  // Método assíncrono que carrega as tarefas salvas no SharedPreferences
  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString('tasks'); // Busca a string JSON salva
    if (tasksJson != null) {
      final List<dynamic> decoded = jsonDecode(tasksJson); // Decodifica a string JSON em lista dinâmica
      setState(() {
        // Converte cada elemento da lista para um objeto Task e atualiza o estado
        _tasks = decoded.map((e) => Task.fromJson(e)).toList();
      });
    }
  }

  // Método assíncrono que salva a lista de tarefas no SharedPreferences
  Future<void> _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    // Converte a lista de tarefas para JSON e salva como string
    final String tasksJson =
        jsonEncode(_tasks.map((task) => task.toJson()).toList());
    await prefs.setString('tasks', tasksJson);
  }

  // Método que adiciona uma nova tarefa à lista
  void _addTask() {
    final title = _controller.text.trim(); // Pega o texto do campo e remove espaços
    if (title.isEmpty) return; // Não adiciona se o texto estiver vazio
    setState(() {
      _tasks.add(Task(title: title)); // Adiciona uma nova tarefa com status padrão 'pendente'
      _controller.clear(); // Limpa o campo de texto
    });
    _saveTasks(); // Salva as tarefas atualizadas
  }

  // Método que remove uma tarefa pelo índice
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Remove a tarefa da lista
    });
    _saveTasks(); // Salva as tarefas atualizadas
  }

  // Método que altera o status da tarefa, alternando entre os três estados
  void _changeStatus(int index) {
    setState(() {
      final task = _tasks[index];
      switch (task.status) {
        case 'em progresso':
          task.status = 'concluida'; // Se estava em progresso, passa a concluída
          break;
        case 'concluida':
          task.status = 'pendente'; // Se estava concluída, passa a pendente
          break;
        case 'pendente':
          task.status = 'em progresso'; // Se estava pendente, passa a em progresso
          break;
      }
    });
    _saveTasks(); // Salva as tarefas atualizadas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'), // Título da barra superior
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart),
            onPressed: () {
              // Navega para a tela de progresso, passando a lista de tarefas como argumento
              Navigator.pushNamed(context, '/progresso', arguments: _tasks);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0), // Espaçamento interno
            child: Row(
              children: [
                Expanded(
                  // Campo de texto para inserir nova tarefa
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(labelText: 'Nova tarefa'),
                  ),
                ),
                // Botão para adicionar nova tarefa
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            // Lista que exibe as tarefas criadas
            child: ListView.builder(
              itemCount: _tasks.length, // Número de tarefas
              itemBuilder: (_, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task.title), // Mostra o título da tarefa
                  subtitle: Text('Status: ${task.status}'), // Mostra o status
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Botão para mudar o status da tarefa
                      IconButton(
                        icon: const Icon(Icons.loop),
                        onPressed: () => _changeStatus(index),
                        tooltip: 'Mudar status',
                      ),
                      // Botão para apagar a tarefa
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _removeTask(index),
                        tooltip: 'Apagar',
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
