import 'dart:convert';

import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:weather_app/features/weather/data/models/fourday_weather_model.dart';

class WeatherRemoteDataSource {
  final String apiKey;

  WeatherRemoteDataSource({required this.apiKey});
  // ignore: non_constant_identifier_names
  final _BASE_URL = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherModel?> getTodayWeather(
      {required String cityName, required Position pos}) async {
    final response = await http
        .get(Uri.parse('$_BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
    print(response.body);

    if (response.statusCode == 200) {
      final obj = WeatherModel.fromJson(jsonDecode(response.body));
      //WeatherModel.toEntity
      return obj;
    } else {
      throw Exception('Faild to load weather data');
    }
  }
   Future<FourDayWeatherModel?> getFourDayWeather(
      { required Position pos}) async {
        //api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid={API key}
  const forecast = "https://api.openweathermap.org/data/2.5/forecast";
final response = await http.get(Uri.parse('$forecast?lat=${pos.latitude}&lon=${pos.longitude}&appid=$apiKey'));
  print("here Four day");
  print(response.body);
   

    if (response.statusCode == 200) {
      final obj = FourDayWeatherModel.fromJson(jsonDecode(response.body));
      //WeatherModel.toEntity
      return obj;
    } else {
      throw Exception('Faild to load weather data');
    }
  }
}
