import 'package:dartz/dartz.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:weather_app/core/error.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_ds.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';


class WeatherRepositoryImpl implements WeatherRepository {
final WeatherLocalDatasource localDataSource;
final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, TodayWeather>> getTodayWeather(String city, Position pos) async {
    try {
      final weather = await remoteDataSource.getTodayWeather(cityName: city, pos: pos);
      if (weather != null){
         final res = weather.toEntity(_getWeatherAnimation(weather.weather?[0].main));// .map((model) => model.toEntity()).toList();
return Right(res);
      }
      return Left(SomeSpecificError("Unable to fetch")); 
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  void saveWeatherConfig(LastWeatherConfig data) {
    localDataSource.saveLastCity(data);
  }
  
  
   String _getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/showe.json';
      case 'thunder':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }

   
}