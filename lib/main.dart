import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivepractice/presentation/HomeScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //initializing Hive
 await Hive.initFlutter();

 //open the box
 var box = await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hive Demo',
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}
