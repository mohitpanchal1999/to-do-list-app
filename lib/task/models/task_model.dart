class TaskModel {
  String id;
  String title;
  String description;
  DateTime? creationDateTime;
  DateTime? dateTimeOfCompletion;
  bool completed;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.creationDateTime,
    this.dateTimeOfCompletion,
    this.completed = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed,
      'creationDateTime': creationDateTime?.toIso8601String(),
      'dateTimeOfCompletion': dateTimeOfCompletion?.toIso8601String(),
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      creationDateTime: json['creationDateTime']!=null?DateTime.parse(json['creationDateTime']):null,
      dateTimeOfCompletion: json['dateTimeOfCompletion']!=null?DateTime.parse(json['dateTimeOfCompletion']):null,
    );
  }

  @override
  String toString() {
    return 'TaskModel{id: $id, title: $title, description: $description, '
        'creationDateTime: $creationDateTime, dateTimeOfCompletion: $dateTimeOfCompletion, '
        'completed: $completed}';
  }
}