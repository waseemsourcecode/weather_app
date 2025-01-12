import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/error.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_ds.dart';
import 'package:weather_app/features/weather/domain/entites/fourday_weather.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherLocalDatasource localDataSource;
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, TodayWeather>> getTodayWeather(
      String city, Position pos) async {
    try {
      final weather =
          await remoteDataSource.getTodayWeather(cityName: city, pos: pos);
      if (weather != null) {
        final res = weather.toEntity(_getWeatherAnimation(weather
            .weather?[0].main)); // .map((model) => model.toEntity()).toList();
        return Right(res);
      }
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }

  @override
  void saveWeatherConfig(LastWeatherConfig data) {
    localDataSource.addCities(data);
  }

  String _getNextDay(String whatsToday) {
    switch (whatsToday.toLowerCase()) {
      case 'sun':
        return 'Mon';
      case 'mon':
        return 'Tue';
      case 'tue':
        return 'Wed';
      case 'wed':
        return 'Thus';
      case 'thus':
        return 'Fri';
      case 'fri':
        return 'Sat';
      case 'sat':
        return 'Sun';
      default:
        return 'Mon';
    }
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

  @override
  Future<Either<Failure, List<FourDayWeather>>> getFourDayWeather(
      Position pos) async {
    try {
      List<FourDayWeather> bucket = [];
      final weather = await remoteDataSource.getFourDayWeather(pos: pos);
      if (weather != null) {
        final fourDay = weather.list;
        var limit = 3;
        if (fourDay != null) {
          var counter = 0;
          var today = DateFormat('EE').format(DateTime.now());
          for (var data in fourDay) {
            if (counter > limit) {
              break;
            }
            var whatDay = _getNextDay(today);
            today = whatDay;
            final res = weather.toEntity(
                _getWeatherAnimation(data.weather?[0].main), counter, whatDay);
            bucket.add(res);
            counter++;
          }
        }
        // .map((model) => model.toEntity()).toList();
        return Right(bucket);
      }
      return Left(SomeSpecificError("Unable to fetch"));
    } catch (error) {
      return Left(SomeSpecificError(error.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<LastWeatherConfig?>>> getWeatherConfig()async {
     try {
      final cities =  localDataSource.getCities();
      return Right(cities);
     } catch (e) {
     return Left(SomeSpecificError("Unable to fetch"));
     }
  }

   
}
