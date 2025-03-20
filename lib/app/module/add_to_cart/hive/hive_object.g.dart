// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AddToCartItemAdapter extends TypeAdapter<AddToCartItem> {
  @override
  final int typeId = 0;

  @override
  AddToCartItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AddToCartItem(
      id: fields[0] as int,
      name: fields[1] as String,
      price: fields[2] as String,
      time: fields[3] as String,
      img: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AddToCartItem obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.img);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddToCartItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
