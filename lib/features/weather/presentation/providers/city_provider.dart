 import 'package:dartz/dartz.dart';
import  'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart'; 
import '../../../../core/error.dart';
import '../../domain/usecases/usecase_city.dart';
import 'weather_repo_provider.dart';

 
final getUserProvider = FutureProvider<Either<Failure, List<LastWeatherConfig?>>>((ref) async {
   final repository = ref.read(weatherRepositoryProvider);
  final response = UseCaseSaveCity(repository: repository).getCity();
  return response;
});


final saveCityProvider = Provider<UseCaseSaveCity>((ref) {
  final repository = ref.read(weatherRepositoryProvider);
  return UseCaseSaveCity(repository: repository);
});

 
  
// This provider will manage fetching trips from the repository.
final stateCityNotfierProvider = StateNotifierProvider<CitySaverNotifier,List<LastWeatherConfig?>>((ref) {
 
  final setCity = ref.read(saveCityProvider);
  return CitySaverNotifier( setCity);
});
//final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');

class CitySaverNotifier extends StateNotifier<List<LastWeatherConfig?>> {
  final UseCaseSaveCity _setCity;
  
  CitySaverNotifier(this._setCity) : super(const []);

Future<void> saveCity({required String cityName, required int tempTypeIndex})async{
print("HERE city ${cityName}");
  // Load trips from the repository and update the state.
  var obj = LastWeatherConfig(city: cityName);
   try {
      final data = _setCity.saveCity(data: obj);
      // data!.fold((error){
      //   state = AsyncValue.error(error,StackTrace.fromString("Failed to fetch weather"));
      // }, (fineData){
      //   state = AsyncData(fineData);
      // });
     // state = AsyncValue.data(data!.getOrElse(dflt));
    } catch (e) {
      //state = AsyncValue.error(e,StackTrace.fromString("Failed to fetch weather"));
    }
}
  Future<void> loadCities() async { 
//final city = await ser.getCurrentCity();
 //state = const AsyncValue.loading(); 
    
   
    final tripsOrFailure = await  _setCity.getCity();
     tripsOrFailure.fold((error) => state = [], (trips) => state = trips);
  }
 
}