class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      priority: json['priority'] as int,
      isDone: json['is_done'] as bool?,
    );
  }

  int? id;
  String title;
  String description;
  int priority;
  bool? isDone;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'is_done': isDone ?? false,
    };
  }
}
