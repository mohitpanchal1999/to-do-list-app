import 'package:to_do_list_app/application/enums/app_enum.dart';
import 'package:to_do_list_app/application/enums/hive_db_enum.dart';
import 'package:to_do_list_app/global_repository/task_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/task_model.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc(this.taskRepository) : super(FetchTasksSuccess(tasks: const [])) {
    on<AddNewTaskEvent>(_addNewTask);
    on<FetchTaskEvent>(_fetchTasks);
    on<UpdateTaskEvent>(_updateTask);
    on<DeleteTaskEvent>(_deleteTask);
    on<SortTaskEvent>(_sortTasks);
    on<SearchTaskEvent>(_searchTasks);
  }

  /// Create new task
  _addNewTask(AddNewTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      if (event.taskModel.title.trim().isEmpty) {
        return emit(AddTaskFailure(error: 'Task title cannot be blank'));
      }
      if (event.taskModel.description.trim().isEmpty) {
        return emit(AddTaskFailure(error: 'Task description cannot be blank'));
      }
      if (event.taskModel.creationDateTime == null) {
        return emit(AddTaskFailure(error: 'Missing task start date'));
      }
      await taskRepository.createNewTask(event.taskModel);
      emit(AddTasksSuccess());
      final tasks = await taskRepository.getTasks();
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(AddTaskFailure(error: exception.toString()));
    }
  }

  /// Get Saved task list from local
  void _fetchTasks(FetchTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await taskRepository.getTasks();
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(LoadTaskFailure(error: exception.toString()));
    }
  }

  /// Update task status and details
  _updateTask(UpdateTaskEvent event, Emitter<TasksState> emit) async {
    try {
      if (event.taskModel.title.trim().isEmpty) {
        return emit(UpdateTaskFailure(error: 'Task title cannot be blank'));
      }
      if (event.taskModel.description.trim().isEmpty) {
        return emit(
            UpdateTaskFailure(error: 'Task description cannot be blank'));
      }
      if (event.taskModel.creationDateTime == null) {
        return emit(UpdateTaskFailure(error: 'Missing task create date'));
      }
      emit(TasksLoading());
      final tasks = await taskRepository.updateTask(event.taskModel);
      emit(UpdateTaskSuccess(taskStatusTyp:event.taskStatusTyp));
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(UpdateTaskFailure(error: exception.toString()));
    }
  }

  /// Delete task from local and DB
  _deleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await taskRepository.deleteTask(event.taskModel);
      emit(DeleteTaskSuccess());
      return emit(FetchTasksSuccess(tasks: tasks));
    } catch (exception) {
      emit(LoadTaskFailure(error: exception.toString()));
    }
  }

  /// Sort task according to selected option
  _sortTasks(SortTaskEvent event, Emitter<TasksState> emit) async {
    final tasks = await taskRepository.sortTasks(event.sortOption);
    return emit(FetchTasksSuccess(tasks: tasks));
  }

  /// Call function to search any text from the added task
  _searchTasks(SearchTaskEvent event, Emitter<TasksState> emit) async {
    final tasks = await taskRepository.searchTasks(event.keywords);
    return emit(FetchTasksSuccess(tasks: tasks, isSearching: true));
  }
}