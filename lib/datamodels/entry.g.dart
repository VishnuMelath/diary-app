// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EntryAdapter extends TypeAdapter<Entry> {
  @override
  final int typeId = 2;

  @override
  Entry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Entry(
      title: fields[0] as String,
      entry: fields[1] as String,
      date: fields[2] as DateTime,
      images: (fields[3] as List).cast<String>(),
      fav: fields[4] as bool,
      category: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Entry obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.entry)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.images)
      ..writeByte(4)
      ..write(obj.fav)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
