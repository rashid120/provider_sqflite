import 'package:flutter/material.dart';
import 'package:provide_sqflite/providers/counter_provider.dart';
import 'package:provide_sqflite/providers/fetch_provider.dart';
import 'package:provide_sqflite/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main(){

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider(),),
        ChangeNotifierProvider(create: (context) => FetchProvider(),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}

