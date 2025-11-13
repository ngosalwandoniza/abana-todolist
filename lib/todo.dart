// tiny todo model, simple
// sorry for bad english and lazy comments
class Todo {
  final String id;
  String title;
  bool done;
  DateTime createdAt;

  Todo({required this.id, required this.title, this.done = false, DateTime? createdAt}) :
    createdAt = createdAt ?? DateTime.now();
}
