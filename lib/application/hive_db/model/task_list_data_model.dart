import 'package:hive/hive.dart';
part 'task_list_data_model.g.dart';

@HiveType(typeId: 0)
class TaskListDataModel {

  TaskListDataModel({required this.id, required this.title,this.description,this.creationDateTime,this.dateTimeOfCompletion,this.completed});

  @HiveField(0)
  String id = "";

  @HiveField(1)
  String title = "";

  @HiveField(2)
  String? description;

  @HiveField(3)
  DateTime? creationDateTime;

  @HiveField(4)
  DateTime? dateTimeOfCompletion;

  @HiveField(5)
  bool? completed = false;



  factory TaskListDataModel.fromJson(Map<String, dynamic> json) {
    return TaskListDataModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      completed: json['completed'],
      creationDateTime: json['creationDateTime']!=null?DateTime.parse(json['creationDateTime']):null,
      dateTimeOfCompletion: json['dateTimeOfCompletion']!=null?DateTime.parse(json['dateTimeOfCompletion']):null,
    );
  }

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
}
