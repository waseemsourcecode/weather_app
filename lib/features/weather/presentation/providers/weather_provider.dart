 import  'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import  'package:weather_app/features/weather/domain/usecases/usecase_add_weather_config.dart';
import 'package:weather_app/features/weather/domain/usecases/usecase_get_weather.dart';
import   'package:weather_app/services/weather_service.dart';  
import 'weather_repo_provider.dart';

 

final getWeatherProvider = FutureProvider<UsecaseGetWeather>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return UsecaseGetWeather(repository: repository);
});

final addWeatherConfigProvider = Provider<UsecaseAddWeatherConfig>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return UsecaseAddWeatherConfig(repository: repository);
});

  
// This provider will manage fetching trips from the repository.
final stateWeatherNotifierProvider = StateNotifierProvider<WeatherNotifier,AsyncValue<TodayWeather?>>((ref) {
 
  final getWeather = ref.read(getWeatherProvider);
  return WeatherNotifier( getWeather);
});
//final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');

class WeatherNotifier extends StateNotifier<AsyncValue<TodayWeather?>> {
  final AsyncValue<UsecaseGetWeather> _getWeather;
  
  WeatherNotifier(this._getWeather) : super(const AsyncValue.data(null));

  // Load trips from the repository and update the state.
  Future<void> loadWeather(String city) async {
     final ser = WeatherService(apiKey: "");
//final city = await ser.getCurrentCity();
 state = const AsyncValue.loading();
final pos = await ser.getCurrentLatLng();
   
    try {
      final data = await _getWeather.value?.call(city: city, pos: pos);
      data!.fold((error){
        state = AsyncValue.error(error,StackTrace.fromString("Failed to fetch weather"));
      }, (fineData){
        state = AsyncData(fineData);
      });
     // state = AsyncValue.data(data!.getOrElse(dflt));
    } catch (e) {
      state = AsyncValue.error(e,StackTrace.fromString("Failed to fetch weather"));
    }
   
    // final tripsOrFailure = await  _getWeather(city: city,pos: pos);
    // tripsOrFailure.fold((error) => state = const AsyncValue.data(null), (trips) => state = trips as AsyncValue<TodayWeather?>);
 
  }
 
}