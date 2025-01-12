import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; 
class WeatherService {
   final forecast = "https://api.openweathermap.org/data/2.5/forecast";
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey; 
  WeatherService({required this.apiKey});
   

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






