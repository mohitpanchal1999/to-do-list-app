// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskListDataModelAdapter extends TypeAdapter<TaskListDataModel> {
  @override
  final int typeId = 0;

  @override
  TaskListDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskListDataModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      creationDateTime: fields[3] as DateTime?,
      dateTimeOfCompletion: fields[4] as DateTime?,
      completed: fields[5] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, TaskListDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.creationDateTime)
      ..writeByte(4)
      ..write(obj.dateTimeOfCompletion)
      ..writeByte(5)
      ..write(obj.completed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskListDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
