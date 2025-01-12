import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/datasources/weather_local_datasource.dart';
import '../../data/datasources/weather_remote_ds.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/entites/last_weather_config.dart';
import '../../domain/repositories/weather_repository.dart';

final weatherLocalDataSourceProvider = Provider<WeatherLocalDatasource>((ref)  {
  final Box<LastWeatherConfig> lastWeatherConfig = Hive.box('weatherConfigBox');
     // await Hive.initFlutter();
  // // Open the peopleBox
    // final box = await Hive.openBox('weatherBox');
  return WeatherLocalDatasource(weatherBox: lastWeatherConfig);
});

final weatherRemoteDataSourceProvider = Provider<WeatherRemoteDataSource>((ref)  {
 
  return WeatherRemoteDataSource(apiKey: "7528cbc9b0cc206b9be53780e54e5f1d");
});


final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final localDataSource = ref.read(weatherLocalDataSourceProvider);
   final remoteDataSource = ref.read(weatherRemoteDataSourceProvider);
  return WeatherRepositoryImpl(localDataSource: localDataSource, remoteDataSource: remoteDataSource);
});
