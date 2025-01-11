import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';

import '../../../../core/error.dart';

abstract class WeatherRepository {
  Future<Either<Failure,TodayWeather>> getTodayWeather();
}