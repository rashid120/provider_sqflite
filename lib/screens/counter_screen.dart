
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provide_sqflite/providers/counter_provider.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey, title: const Text('Counter page'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Center(child: Consumer<CounterProvider>(builder: (BuildContext context, value, Widget? child) {
            return Text("${value.value}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),);
          },))
          ),
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () {
                Provider.of<CounterProvider>(context, listen: false).decrement();
              },style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)), child: const Text('-', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
              ElevatedButton(onPressed: () {
                Provider.of<CounterProvider>(context, listen: false).increment();
              },style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)), child: const Text('+', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),)),
            ],
          )),
        ],
      ),
    );
  }
}
