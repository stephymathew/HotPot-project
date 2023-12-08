// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsAdapter extends TypeAdapter<Products> {
  @override
  final int typeId = 1;

  @override
  Products read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Products(
      dishImage: fields[0] as String,
      dishName: fields[1] as String,
      dishPrice: fields[2] as String,
      dishId: fields[5] as String,
      id: fields[4] as int?,
      ordered: fields[6] as bool,
      dishQuantity: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Products obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.dishImage)
      ..writeByte(1)
      ..write(obj.dishName)
      ..writeByte(2)
      ..write(obj.dishPrice)
      ..writeByte(3)
      ..write(obj.dishQuantity)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.dishId)
      ..writeByte(6)
      ..write(obj.ordered);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
