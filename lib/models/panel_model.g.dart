// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panel_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PanelModelAdapter extends TypeAdapter<PanelModel> {
  @override
  final int typeId = 0;

  @override
  PanelModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PanelModel(
      items: (fields[0] as List).cast<TaskItem>(),
      time: fields[1] as String,
      isCompleted: fields[2] as bool?,
      isExpanded: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, PanelModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.items)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.isCompleted)
      ..writeByte(3)
      ..write(obj.isExpanded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanelModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskItemAdapter extends TypeAdapter<TaskItem> {
  @override
  final int typeId = 1;

  @override
  TaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskItem(
      description: fields[0] as String,
      isDone: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
