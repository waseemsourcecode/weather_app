import 'package:advanced_search/advanced_search.dart'; 
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:toggle_switch/toggle_switch.dart'; 
import 'package:weather_app/features/weather/presentation/providers/four_day_forcast_provider.dart';
import 'package:weather_app/features/weather/presentation/providers/temp_toggler.dart';
import 'package:weather_app/features/weather/presentation/providers/weather_provider.dart';
import 'package:weather_app/services/weather_service.dart'; 
import '../providers/city_provider.dart';
import '../widgets/gradient_colors.dart';

class ScreenWeather extends ConsumerWidget {
  const ScreenWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WeatherService().checkPermission();
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 133, 132, 132),
      body: SafeArea(
        child: WeatherView(),
      ),
    );
  }
}

class WeatherView extends ConsumerWidget {
  const WeatherView({
    super.key,
    //  required this.todayWeatherReport,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final temToggler = ref.watch(conditionalProvider);
    // var loading = false;
    var asyncWatcher = ref.watch(stateWeatherNotifierProvider);
    var asyncFourDayWatcher = ref.watch(stateFourDayWeatherNotifierProvider);
    ref.watch(stateCityNotfierProvider.notifier).loadCities();
    var bgColor = Colors.lightBlue;

    return GradientContainer(
      color: bgColor,
      // height: double.infinity,
      child: Stack(
        children: [
          Wrap(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
//citylist
                  const SearchOverlay(),
                  asyncWatcher.when(
                      data: (weatherReport) {
                        //ref.read(stateTempTogglerNotifierProvider.notifier).toggleTemp(weatherReport?.temperature.round().toString(), 0);

                        if (weatherReport != null) {
                          //ref.read(userNameProvider.notifier).state ="14";
                          // "${weatherReport.temperature.round()}°c";
                          //  = "11";
                          switch (weatherReport.weatherMood) {
                            case "clear":
                              bgColor = Colors.yellow;

                              break;
                            default:
                              bgColor = Colors.blue;
                          }
                        }
                        return weatherReport == null
                            ? const Padding(
                                padding: EdgeInsets.only(top: 50.0),
                                child: Text(
                                  "Please Search Your City",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        //"name",
                                        weatherReport.city,
                                        style: const TextStyle(
                                          fontSize: 40,
                                          color:
                                              Color.fromARGB(255, 23, 23, 23),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        temToggler.isEmpty
                                            ? "${weatherReport!.temperature.round()}°c"
                                            : temToggler,
                                      style: const TextStyle(
                                          fontSize: 60,
                                          color:
                                              Color.fromARGB(255, 18, 18, 18),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //toggle
                                  ToggleSwitch(
                                    minWidth: 90.0,
                                    initialLabelIndex:
                                        temToggler.contains("F") ? 1 : 0,
                                    cornerRadius: 20.0,
                                    activeFgColor: Colors.white,
                                    inactiveBgColor: Colors.grey,
                                    inactiveFgColor: Colors.white,
                                    totalSwitches: 2,
                                    labels: const ['°C', '(°F)'],
                                    icons: const [Icons.snowing, Icons.snowing],
                                    activeBgColors: const [
                                      [Colors.green],
                                      [Colors.green]
                                    ],
                                    onToggle: (index) {
                                    //  print('switched to: $index');
                                      final temp =
                                          weatherReport.temperature.toString();
                                      if (index! == 1) {
                                        try {
                                          final celsius = double.parse(temp);
                                          final fahrenheit =
                                              (celsius * 9 / 5) + 32;
                                          ref
                                              .read(userNameProvider.notifier)
                                              .state = "${fahrenheit.round()}°F";
                                        } catch (e) {
                                          // Handle invalid input
                                          ref
                                              .read(userNameProvider.notifier)
                                              .state = "$temp°C";
                                        }
                                      } else {
                                        ref
                                            .read(userNameProvider.notifier)
                                            .state = "$temp°C";
                                      }

                                      //   ref.read(stateTempTogglerNotifierProvider.notifier).toggleTemp(weatherReport.temperature.round().toString(), index!);
                                    },
                                  ),
                                  // animation
                                  SizedBox(
                                      height: 180,
                                      child: Lottie.asset(
                                          weatherReport.animationJson)),
                                  Text(
                                    //"cloudy",
                                    "Seem there is a ${weatherReport.weatherMood} day.",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                  Text(
                                    "Humidity: ${weatherReport?.humidity.toString()}",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ],
                              );

                        //end
                      },
                      error: (err, stack) {
                        return const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Text("Please check your connection and phone location permission",textAlign: TextAlign.center, style: TextStyle(fontSize: 20,color: Colors.white)),
                        );
                      },
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ))
                  //end
                  //Four day forecast
                  ,
                ],
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: asyncFourDayWatcher.when(
                data: (fourDayWeather) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children:
                              List.generate(fourDayWeather.length, (index) {
                        final fourDayData = fourDayWeather[index];
                        return Column(
                          children: [
                            SizedBox(
                              height: 80,
                              // color: Colors.red,
                              width: 100,
                              child: Lottie.asset(fourDayData.animationJson),
                            ),
                            Center(
                              child: Text(fourDayData.dayName),
                            ),
                            Text(fourDayData.weatherMood),
                            Text("Temp: ${fourDayData.temperature.round()}"),
                            Text("Humid: ${fourDayData.humidity}"),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        );
                      })));
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) {
               return const Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Center(child: Text("",textAlign: TextAlign.center, style: TextStyle( fontSize: 20,color: Colors.white))),
                        );
                },
              )),
        ],
      ),
    );
  }
}

class SearchOverlay extends ConsumerWidget {
  const SearchOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchWatcher = ref.watch(stateCityNotfierProvider);
    List<String> searchSuggestion = [];
    searchWatcher.forEach((da) {
      searchSuggestion.add(da!.city);
    });
    // final searchWatcher = ref.watch(saveCityProvider).g;
    //  ref.read(stateCityNotfierProvider.notifier).loadCities();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AdvancedSearch(
        // This is basically an Input Text Field
        hintText: "Search your city here",
        searchItems: searchSuggestion,
        maxElementsToDisplay: searchWatcher.length,
        onItemTap: (index, value) {
          if(value.isNotEmpty){
FocusManager.instance.primaryFocus?.unfocus();
          ref.read(stateWeatherNotifierProvider.notifier).loadWeather(value);
          ref
              .read(stateFourDayWeatherNotifierProvider.notifier)
              .loadFourDayWeather();
          }
          
        },
        onSearchClear: () {
          // may be display the full list? or Nothing? it's your call
        },
        onSubmitted: (value, value2) {
          if (value.isNotEmpty){
ref.read(stateCityNotfierProvider.notifier).saveCity(
              cityName: value,
              tempTypeIndex: 1); //(userName.contains("°F") ? 1 : 0));
          // FocusManager.instance.primaryFocus?.unfocus();
          ref.read(stateWeatherNotifierProvider.notifier).loadWeather(value);
          ref
              .read(stateFourDayWeatherNotifierProvider.notifier)
              .loadFourDayWeather();
          }
          
        },
        onEditingProgress: (value, value2) {
          // user is trying to lookup something, may be you want to help him?
        },
      ),
    )  ;
  }
}
