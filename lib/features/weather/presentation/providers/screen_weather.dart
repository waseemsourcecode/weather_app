import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart'; 
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/features/weather/domain/entites/today_weather.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart';

class ScreenWeather  extends ConsumerWidget{
  const ScreenWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("Called build");
    // var  loading = "";
    //final todayWeatherReport = ref.watch(stateWeatherNotifierProvider.notifier).loadWeather();
  
    // TodayWeather? weather;
    //    ref.watch(tripListNotifierProvider.notifier).loadTrips();
    // final weatherReport = ref.watch(stateWeatherNotifierProvider);
    // final welcomeProvider = Provider((ref) => 'Welcome to Riverpod');
   // final weatherReport = ref.watch(getWeatherProvider);
    //todayWeatherReport.then(dd {})
   // final watcher = ref.watch(getWeatherProvider).call(city: city, pos: pos);
  
    ref.listen(stateWeatherNotifierProvider, (previous, next) {
     
       
      if(next == null){
    showDialog(context: context, builder: (_){
      return Center(child: CircularProgressIndicator(),);
    });
  }else{
   // Navigator.pop(context);
  }
    });
    return const Scaffold(
        backgroundColor: Color.fromARGB(255, 133, 132, 132),
        body: SafeArea(
          child: GradientContainer(color: Colors.lightBlue,child:
          
          // (weatherReport == null) ? CircularProgressIndicator() :
         // (loading.isEmpty ==  true) ? CircularProgressIndicator() : 
  WeatherView()

          
          ),
        )
        );
  
   }

}

class WeatherView extends ConsumerWidget {
  const WeatherView({
    super.key,
  //  required this.todayWeatherReport,
  });

  //final TodayWeather todayWeatherReport;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     var _controller = TextEditingController();
     var loading = false;
     var weatherReport = ref.watch(stateWeatherNotifierProvider);
     weatherReport.w
    //  ref.listen<AsyncValue<void>>(
    //   stateWeatherNotifierProvider,
    //   (_, state) => state.showSnackBarOnError(context),
    // );
    // final paymentState = ref.watch(paymentButtonControllerProvider);

    return  Center(
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
             //   _fetchWeather();
            // setEquals(a, b)
            loading = true;
             ref.watch(stateWeatherNotifierProvider.notifier).loadWeather(_controller.text);
             },
             decoration: InputDecoration(
               hintText: "Search your city here",
               focusColor: Colors.white,
               floatingLabelBehavior: FloatingLabelBehavior.never,
               prefixIcon: const Icon(Icons.cloud),
             
               suffixIcon: IconButton(
                 onPressed: () {
                //  _controller.text = "";
                 // currentCity = "";
                 },
                 icon: const Icon(Icons.cancel),
               ),
             ),
           ),
         ),
         loading ? 
          Center(
            child: CircularProgressIndicator(),
          ):
        

          Column(children: [
 Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
                  Text(
                   //"name",
             weatherReport?.city ?? "",
             style: const TextStyle(
               fontSize: 40,
               color: Color.fromARGB(255, 23, 23, 23),
             ),
           ),
           const SizedBox(width: 10,),
              Text(
               // _weather == null ? "":
             '${weatherReport?.temperature.round()}°C',
             style: const TextStyle(
               fontSize: 60,
               color: Color.fromARGB(255, 18, 18, 18),
             ),
           ),
           ],)
          ,
                 
           // animation
           weatherReport?.animationJson != null ? Lottie.asset(weatherReport!.animationJson) : Text(""),
            // weather condition
           weatherReport == null ? Text(""):
           Text(
             //"cloudy",
              "Seem there is a ${weatherReport?.weatherMood}",
             style: const TextStyle(
               fontSize: 20,
               color: Color.fromARGB(255, 0, 0, 0),
             ),
           ),
            weatherReport == null ? Text(""):
           Text(  
             
             "Humidity: ${weatherReport?.humidity.toString()}",
             style: const TextStyle(
               fontSize: 40,
               color: Color.fromARGB(255, 0, 0, 0),
             ),
           ),
         
          ],)
           //end
          
         ],
       ),
     ),
              );
  }
}