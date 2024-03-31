// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pages.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PagesAdapter extends TypeAdapter<Pages> {
  @override
  final int typeId = 2;

  @override
  Pages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pages(
      pageId: fields[0] as int,
      nameAr: fields[1] as String,
      nameEn: fields[2] as String,
      navigationKey: fields[3] as String,
      icon: fields[4] as String,
      isFastScreen: fields[5] as bool,
      moduleID: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Pages obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.pageId)
      ..writeByte(1)
      ..write(obj.nameAr)
      ..writeByte(2)
      ..write(obj.nameEn)
      ..writeByte(3)
      ..write(obj.navigationKey)
      ..writeByte(4)
      ..write(obj.icon)
      ..writeByte(5)
      ..write(obj.isFastScreen)
      ..writeByte(6)
      ..write(obj.moduleID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
