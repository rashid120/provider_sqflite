import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier{

  int value = 1;

  void increment(){
    value++;
    notifyListeners();
  }

  void decrement(){
    value--;
    notifyListeners();
  }
}