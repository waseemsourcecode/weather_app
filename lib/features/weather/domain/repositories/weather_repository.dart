import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/weather/domain/entites/fourday_weather.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';

import '../../../../core/error.dart';

abstract class WeatherRepository {
  Future<Either<Failure,TodayWeather>> getTodayWeather(String city,Position pos);
  Future<Either<Failure, List<FourDayWeather>>> getFourDayWeather(Position pos);
 void saveWeatherConfig(LastWeatherConfig data);
 Future<Either<Failure, List<LastWeatherConfig?>>>  getWeatherConfig();
}