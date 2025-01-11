import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/features/weather/domain/entites/last_weather_config.dart';
import 'package:weather_app/weather_page.dart';

import 'features/weather/presentation/providers/screen_weather.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open your box.
   await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
   Hive.registerAdapter(LastWeatherConfigAdapter());
   await Hive.openBox<LastWeatherConfig>('weatherConfigBox');
  //this should be embbed
  //  await Hive.initFlutter();
  // // Open the peopleBox
  // final box = await Hive.openBox('HADITBox');
 runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ScreenWeather());
    }
}
       