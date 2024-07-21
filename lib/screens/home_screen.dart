
import 'package:flutter/material.dart';
import 'package:provide_sqflite/providers/fetch_provider.dart';
import 'package:provide_sqflite/screens/counter_screen.dart';
import 'package:provide_sqflite/sqflite_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getData();
    // print(getData().toString());
  }

  Future<void> getData() async{

    await Provider.of<FetchProvider>(context, listen: false).fetchDataP();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(leading: InkWell(child: const Icon(Icons.countertops_rounded), onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CounterPage(),));
      },),backgroundColor: Colors.blueGrey, actions: [
        InkWell(child: const Text('Log Out'),onTap: () async {

        SharedPreferences loginDetails = await SharedPreferences.getInstance();
        loginDetails.clear();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));

      },),
        const SizedBox(width: 15,),
      ],),

      body: Consumer<FetchProvider>(builder: (BuildContext context, value, child) {
        if(value.data.isEmpty){

          return const Center(child: CircularProgressIndicator());
        }
          return ListView.builder(
            itemCount: value.data.length ,
            itemBuilder: (context, index) {
              return Card(
              child: Column(
                children: [
                  Container(
                    width: size.width * 1.0,
                    margin: const EdgeInsets.all(10),
                    child: Card(
                      color: Colors.blueGrey.shade200,
                      shadowColor: Colors.green,
                      child: Consumer<FetchProvider>(
                        builder: (BuildContext context, value, Widget? child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Welcome ${value.data[index][SqfliteHelper.columnName]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Name : ${value.data[index][SqfliteHelper.columnName]}", style: const TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis),
                                  Text("Email : ${value.data[index][SqfliteHelper.columnEmail]}", style: const TextStyle(fontSize: 15), overflow: TextOverflow.ellipsis,),
                                  Text("Phone : ${value.data[index][SqfliteHelper.columnNumber]}", style: const TextStyle(fontSize: 15)),
                                  Text("Gender : ${value.data[index][SqfliteHelper.columnGender]}", style: const TextStyle(fontSize: 15)),
                                ],
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },);
        }
      ,),
    );
  }
}
