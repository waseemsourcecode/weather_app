// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_weather_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LastWeatherConfigAdapter extends TypeAdapter<LastWeatherConfig> {
  @override
  final int typeId = 0;

  @override
  LastWeatherConfig read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LastWeatherConfig(
      city: (fields[0] as List).cast<String>(),
      tempType: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, LastWeatherConfig obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.city)
      ..writeByte(1)
      ..write(obj.tempType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LastWeatherConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
