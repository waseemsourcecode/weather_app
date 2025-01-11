import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/weather_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open your box.
  // await Hive.initFlutter((await getApplicationDocumentsDirectory()).path);
  // Hive.registerAdapter(TripModelAdapter());
  // await Hive.openBox<TripModel>('trips');
  //this should be embbed
  //  await Hive.initFlutter();
  // // Open the peopleBox
  // final box = await Hive.openBox('HADITBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherPage());
    }
}
       