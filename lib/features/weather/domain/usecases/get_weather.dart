import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

import '../../../../core/error.dart';

class GetWeather {
  final WeatherRepository repository;

  GetWeather({required this.repository});
  
  Future<Either<Failure,TodayWeather>> call(){
    return repository.getTodayWeather();
  }
}