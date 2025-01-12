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
      city: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LastWeatherConfig obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.city);
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
