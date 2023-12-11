// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentAppAdapter extends TypeAdapter<StudentApp> {
  @override
  final int typeId = 1;

  @override
  StudentApp read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentApp(
      name: fields[0] as String,
      age: fields[2] as String,
      cls: fields[1] as String,
      contact: fields[3] as String,
      email: fields[4] as String,
      image: fields[5] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, StudentApp obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cls)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.contact)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentAppAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
