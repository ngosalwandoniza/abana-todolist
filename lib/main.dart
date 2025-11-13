import 'package:flutter/material.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

// small app, not fancy, comments maybe bad english :) 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Todo',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  // list hold todos in memory, not persist
  final List<Todo> _todos = [];
  final TextEditingController _controller = TextEditingController();

  // add item simple
  void _addTodo() {
    final text = _controller.text.trim();
    if (text.isEmpty) return; // nothing
    final t = Todo(id: DateTime.now().microsecondsSinceEpoch.toString(), title: text);
    setState(() {
      _todos.insert(0, t);
      _controller.clear();
    });
  }

  // toggle done
  void _toggle(String id) {
    setState(() {
      final i = _todos.indexWhere((e) => e.id == id);
      if (i != -1) {
        _todos[i].done = !_todos[i].done;
      }
    });
  }

  // remove
  void _remove(String id) {
    setState(() {
      _todos.removeWhere((e) => e.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo - simple'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('todo_input'),
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'What do you need to do?',
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  key: const Key('add_button'),
                  onPressed: _addTodo,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _todos.isEmpty
                  ? const Center(child: Text('No todos yet. Add one please.'))
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final item = _todos[index];
                        return Dismissible(
                          key: Key(item.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (_) => _remove(item.id),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          child: CheckboxListTile(
                            title: Text(item.title),
                            value: item.done,
                            onChanged: (_) => _toggle(item.id),
                          ),
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
