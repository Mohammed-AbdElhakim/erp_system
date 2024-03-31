// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_module.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListModuleAdapter extends TypeAdapter<ListModule> {
  @override
  final int typeId = 1;

  @override
  ListModule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListModule(
      moduleID: fields[0] as int,
      moduleKey: fields[1] as String,
      moduleNameAr: fields[2] as String,
      moduleNameEn: fields[3] as String,
      pages: (fields[4] as List).cast<Pages>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListModule obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.moduleID)
      ..writeByte(1)
      ..write(obj.moduleKey)
      ..writeByte(2)
      ..write(obj.moduleNameAr)
      ..writeByte(3)
      ..write(obj.moduleNameEn)
      ..writeByte(4)
      ..write(obj.pages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListModuleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
