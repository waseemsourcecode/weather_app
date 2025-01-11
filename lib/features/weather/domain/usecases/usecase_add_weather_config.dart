 
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart'; 
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
 
class UsecaseAddWeatherConfig {
  final WeatherRepository repository;

  UsecaseAddWeatherConfig({required this.repository});
  
void call({required LastWeatherConfig data}){
      repository.saveWeatherConfig(data);
  }
}