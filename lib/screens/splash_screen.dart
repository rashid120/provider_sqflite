import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provide_sqflite/screens/home_screen.dart';
import 'package:provide_sqflite/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool status = false;

  void loginCheck() async{
    SharedPreferences login = await SharedPreferences.getInstance();
    status = login.getBool('status')!;
  }

  @override
  void initState() {
    super.initState();

    loginCheck();
    Timer(const Duration(seconds: 3), () {
      if(status){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 7,child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network('https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
                SizedBox(height: size.height * 0.04,),
                const SizedBox(width: 25, height: 25,child: CircularProgressIndicator()),
              ],
            ),),
            Expanded(flex: 3,
              child: Container(),
            ),
            const Expanded(flex: 1-1, child: Text("Edugaon", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),)),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}
