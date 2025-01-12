import 'package:hive/hive.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart';

class WeatherLocalDatasource {
     final Box<LastWeatherConfig> weatherBox;
//final Box<LastWeatherConfig> weatherBox;

  WeatherLocalDatasource({required this.weatherBox});
 List<LastWeatherConfig> getCities(){
    return weatherBox.values.toList();
  }

  void addCities(LastWeatherConfig city) {
    weatherBox.add(city);
     print("city saved  ${city.city}");
    // final obj = weatherBox.values.toList();
    // obj.forEach((oo){
    //   print(oo.city);
    // });
  }
  //WeatherLocalDatasource({required this.weatherBox});

  

    
}