import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart'; 
class WeatherService { 
   

Future<Position> getCurrentLatLng() async {
   Position  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
return position;
}
 void checkPermission()async {
      LocationPermission permission = await Geolocator
    .checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
    }
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






