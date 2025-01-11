import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/error.dart';

class UsecaseGetWeather {
  final WeatherRepository repository;

  UsecaseGetWeather({required this.repository});
  
  Future<Either<Failure,TodayWeather>> call({required String city, required Position pos}){
    return repository.getTodayWeather(city, pos);
  }
}