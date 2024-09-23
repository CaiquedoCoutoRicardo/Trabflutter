import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// StatelessWidget que inicia o app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListScreen(),
    );
  }
}

// StatefulWidget para gerenciar o estado da lista de tarefas
class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  // Lista que irá armazenar as tarefas
  List<TodoItem> _todoList = [];

  // Controlador para obter o texto da nova tarefa
  final TextEditingController _taskController = TextEditingController();

  // Função para adicionar uma nova tarefa
  void _addTask(String task) {
    setState(() {
      _todoList.add(TodoItem(task: task));
    });
    _taskController.clear();
  }

  // Função para alterar o estado da tarefa (checkbox)
  void _toggleTaskCompletion(int index, bool? isCompleted) {
    setState(() {
      _todoList[index].isCompleted = isCompleted ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Campo para inserir nova tarefa
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _taskController,
                    decoration: InputDecoration(
                      labelText: 'Nova tarefa',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (_taskController.text.isNotEmpty) {
                      _addTask(_taskController.text);
                    }
                  },
                )
              ],
            ),
            // Espaço para a lista de tarefas
            Expanded(
              child: ListView.builder(
                itemCount: _todoList.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(
                      _todoList[index].task,
                      style: TextStyle(
                        decoration: _todoList[index].isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    value: _todoList[index].isCompleted,
                    onChanged: (bool? value) {
                      _toggleTaskCompletion(index, value);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Modelo de item da lista de tarefas
class TodoItem {
  String task;
  bool isCompleted;

  TodoItem({required this.task, this.isCompleted = false});
}
