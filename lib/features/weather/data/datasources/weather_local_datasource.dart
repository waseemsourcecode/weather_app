import 'package:hive/hive.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart';

class WeatherLocalDatasource {
    
final Box<LastWeatherConfig> weatherBox;

  WeatherLocalDatasource({required this.weatherBox});

  //WeatherLocalDatasource({required this.weatherBox});

  List<String>? getLastSearchCity(){
return weatherBox.values.toList() as List<String>;
  }
  
   void saveLastCity(LastWeatherConfig city){
  weatherBox.add(city);
  }

    
}