import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/weather/domain/entites/fourday_weather.dart'; 
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/error.dart';

class UsecaseGetFourDayWeather {
  final WeatherRepository repository;

  UsecaseGetFourDayWeather({required this.repository});
  
  Future<Either<Failure,List<FourDayWeather>>> call({ required Position pos}){
    return repository.getFourDayWeather(pos);
  }
}