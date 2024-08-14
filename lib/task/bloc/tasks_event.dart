part of 'tasks_bloc.dart';


@immutable
sealed class TasksEvent {}

class AddNewTaskEvent extends TasksEvent {
  final TaskModel taskModel;

  AddNewTaskEvent({required this.taskModel});
}

class FetchTaskEvent extends TasksEvent {}

class SortTaskEvent extends TasksEvent {
  final int sortOption;

  SortTaskEvent({required this.sortOption});
}

class UpdateTaskEvent extends TasksEvent {
  final TaskModel taskModel;
  final TaskStatusTyp? taskStatusTyp;
  UpdateTaskEvent({required this.taskModel,this.taskStatusTyp = TaskStatusTyp.updateStatus});
}

class DeleteTaskEvent extends TasksEvent {
  final TaskModel taskModel;

  DeleteTaskEvent({required this.taskModel});
}

class SearchTaskEvent extends TasksEvent{
  final String keywords;

  SearchTaskEvent({required this.keywords});
}