import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';
import 'package:http/http.dart' as http;
class WeatherService {
   final forecast = "https://api.openweathermap.org/data/2.5/forecast";
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;
//https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}
  WeatherService({required this.apiKey});
  Future<dynamic> getFourDayForecast(Position pos) async {
    print("starting");
  final response = await http.get(Uri.parse('$forecast?lat=${pos.latitude}&lon=${pos.longitude}&appid=$apiKey'));
  print("here");
  print(response.body);
  return null;
//  if (response.statusCode == 200){
//   final obj =  WeatherModel.fromJson(jsonDecode( response.body));
 
//   return obj;
//  }else{
//   throw Exception('Faild to load weather data');
//  }
  }
  Future<WeatherModel> getWeather(String cityName) async {
    final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
  print(response.body);
 if (response.statusCode == 200){
  final obj =  WeatherModel.fromJson(jsonDecode( response.body));
 
  return obj;
 }else{
  throw Exception('Faild to load weather data');
 }
  }
Future<Position> getCurrentLatLng() async {
   Position  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
return position;
}
  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator
    .checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
    //fetch current pos
    Position  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//convet to object

List<Placemark> placemark = await placemarkFromCoordinates(position.latitude,position.longitude);
//extract the city

String? city = placemark[0].locality;
return city ?? "No city founded";

  }
  
}






class GradientContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  const GradientContainer({super.key, required this.color, required this.child}) : assert(color != null, child != null);
        

  // const GradientContainer({
  //   Key key,
  //   @required this.color,
  //   @required this.child,
  // })  : assert(color != null, child != null),
  //       super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0, 1.0],
          colors: [
            color[800]!,
            color[400]!,
          ],
        ),
      ),
      child: child,
    );
  }
}