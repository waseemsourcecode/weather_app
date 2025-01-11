 
import 'package:hive/hive.dart';
import 'package:weather_app/features/weather/data/datasources/weather_local_datasource.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/data/datasources/weather_remote_ds.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/usecase_add_weather_config.dart';
import 'package:weather_app/features/weather/domain/usecases/usecase_get_weather.dart';
import   'package:weather_app/services/weather_service.dart'; 
import '../../domain/entites/last_weather_config.dart';

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

 

final getWeatherProvider = Provider<UsecaseGetWeather>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return UsecaseGetWeather(repository: repository);
});

final addWeatherConfigProvider = Provider<UsecaseAddWeatherConfig>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return UsecaseAddWeatherConfig(repository: repository);
});

  
// This provider will manage fetching trips from the repository.
final stateWeatherNotifierProvider = StateNotifierProvider<WeatherNotifier, TodayWeather?>((ref) {
  final getWeather = ref.read(getWeatherProvider);
  return WeatherNotifier(getWeather);
});
//final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');

class WeatherNotifier extends StateNotifier<TodayWeather?> {
  final UsecaseGetWeather _getWeather;
  
  WeatherNotifier(this._getWeather) : super(null);

  // Load trips from the repository and update the state.
  Future<void> loadWeather(String city) async {
    final ser = WeatherService(apiKey: "");
//final city = await ser.getCurrentCity();
final pos = await ser.getCurrentLatLng();
    final tripsOrFailure = await _getWeather(city: city,pos: pos);
    tripsOrFailure.fold((error) => state = null, (trips) => state = trips);
  }
 
}