import 'package:hive/hive.dart';

part 'last_weather_config.g.dart';

@HiveType(typeId: 0)
class  LastWeatherConfig {
  @HiveField(0)
  final String city;
  // @HiveField(1)
  // final int tempType;

  LastWeatherConfig({required this.city});
  
}