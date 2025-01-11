import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:uuid/uuid.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:weather_app/weather_model.dart';

import 'package:http/http.dart' as http;
 //https://medium.com/flutter-community/flutter-weather-app-using-provider-c168d59af837
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherState();
}

class _WeatherState extends State<WeatherPage> {
  var _controller = TextEditingController();
  var uuid =   Uuid();
  String? _sessionToken;
  List<dynamic> _placeList = [];



// api key

  final _weatherService = WeatherService(apiKey: "7528cbc9b0cc206b9be53780e54e5f1d");
  WeatherModel? _weather;

// fetch weather

  _fetchWeather() async {
    // get weather current city
    String cityName = await _weatherService.getCurrentCity();

    // get weather for city

    try {
      final weather = await _weatherService.getWeather(currentCity);
      setState(() {
        _weather = weather;
      });
    }

    // any errors
    catch (e) {
      print(e);
    }
  }

// weather animations

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/showe.json';
      case 'thunder':
        return 'assets/storm.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';
    }
  }
  String currentCity = "";
  _onChanged() {
    // if (_sessionToken == null) {
    //   setState(() {
    //     _sessionToken = uuid.v4();
    //   });
    // }
    // getSuggestion(_controller.text);
    currentCity = _controller.text;
  }
  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "YOUR_API_KEY";
    String type = '(regions)';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

// initial state
  @override
  void initState() async{
    super.initState();

    // fetch weather
    final pos = await  _weatherService.getCurrentLatLng();
_weatherService.getFourDayForecast(pos);
   // _fetchWeather();
     _controller.addListener(() {
      _onChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 133, 132, 132),
        body: SafeArea(
          child: GradientContainer(color: Colors.lightBlue,child: 
           Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //auto search
                Align(
                  alignment: Alignment.topCenter,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: _controller,
                    onEditingComplete: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                       _fetchWeather();
                    },
                    decoration: InputDecoration(
                      hintText: "Seek your location here",
                      focusColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(Icons.cloud),
                    
                      suffixIcon: IconButton(
                        onPressed: () {
                         _controller.text = "";
                         currentCity = "";
                        },
                        icon: Icon(Icons.cancel),
                      ),
                    ),
                  ),
                ),
                // ListView.builder(
                //   physics: NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   itemCount: _placeList.length,
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       title: Text(_placeList[index]["description"]),
                //     );
                //   },
                // ),
                  //end
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                         Text(
                    _weather?.name ?? "loading city...",
                    style: const TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 23, 23, 23),
                    ),
                  ),
                  SizedBox(width: 10,),
                     Text( _weather == null ? "":
                    '${_weather?.main?.tempMax?.round()}°C',
                    style: const TextStyle(
                      fontSize: 60,
                      color: Color.fromARGB(255, 18, 18, 18),
                    ),
                  ),
                  ],)
                 ,
                        
                  // animation
                  Lottie.asset(getWeatherAnimation(_weather?.weather?[0].main)),
                        
                 
                        
                  // weather condition
                  Text(
                    "Seem there is a ${_weather?.weather?[0].main}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text( _weather == null ? "Loading" :
                    "Humidity: ${_weather?.main?.humidity?.toString()}",
                    style: const TextStyle(
                      fontSize: 40,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          )
          ),
        )
        );
  }
}





