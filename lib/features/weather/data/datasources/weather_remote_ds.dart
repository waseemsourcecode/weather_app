
import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';

class WeatherRemoteDataSource {
    final String apiKey;

    WeatherRemoteDataSource({required this.apiKey});
  final _BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  
  Future<WeatherModel?> getTodayWeather({required String cityName, required Position pos})async{
 final response = await http.get(Uri.parse('$_BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
  print(response.body);
   
 if (response.statusCode == 200){
  final obj =  WeatherModel.fromJson(jsonDecode( response.body));
 //WeatherModel.toEntity
  return obj;
 }else{
  throw Exception('Faild to load weather data');
 }  
  }
   
}