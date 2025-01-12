  
import 'package:flutter_riverpod/flutter_riverpod.dart';
import   'package:weather_app/services/weather_service.dart'; 
import '../../domain/entites/fourday_weather.dart';
import '../../domain/usecases/usecase_get_fourday_weather.dart';
import 'weather_repo_provider.dart'; 

  
 

final getFourDayWeatherProvider = FutureProvider<UsecaseGetFourDayWeather>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return UsecaseGetFourDayWeather(repository: repository);
});

 
  
// This provider will manage fetching trips from the repository.
final stateFourDayWeatherNotifierProvider = StateNotifierProvider<FourDayWeatherNotifier,AsyncValue<List<FourDayWeather>>>((ref) {
 
  final getFourDayWeather = ref.read(getFourDayWeatherProvider);
  return FourDayWeatherNotifier( getFourDayWeather);
});
//final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');

class FourDayWeatherNotifier extends StateNotifier<AsyncValue<List<FourDayWeather>>> {
  final AsyncValue<UsecaseGetFourDayWeather> _getFourDayWeather;
  
  FourDayWeatherNotifier(this._getFourDayWeather) : super(const AsyncValue.data([]));

  // Load trips from the repository and update the state.
  Future<void> loadFourDayWeather() async {
     final ser = WeatherService(apiKey: "");
//final city = await ser.getCurrentCity();
 state = const AsyncValue.loading();
final pos = await ser.getCurrentLatLng();
   
    try {
      final data = await _getFourDayWeather.value?.call( pos: pos);
      data!.fold((error){
        state = AsyncValue.error(error,StackTrace.fromString("Failed to fetch four day weather"));
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