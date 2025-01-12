 
import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error.dart';
import '../entites/last_weather_config.dart';
import '../repositories/weather_repository.dart';

class UseCaseSaveCity {
  final WeatherRepository repository;

  UseCaseSaveCity({required this.repository});
   
  
   void  saveCity({required LastWeatherConfig data}){
     repository.saveWeatherConfig(data);
  }
   Future<Either<Failure,List<LastWeatherConfig?>>> getCity(){
    return repository.getWeatherConfig();
  }
}