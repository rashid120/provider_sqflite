
import 'package:flutter/material.dart';
import 'package:provide_sqflite/components/edit_text.dart';
import 'package:provide_sqflite/components/round_bottom.dart';
import 'package:provide_sqflite/screens/home_screen.dart';
import 'package:provide_sqflite/screens/register_screen.dart';
import 'package:provide_sqflite/sqflite_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.blueGrey, title: const Text('Login page'),),
      body: SingleChildScrollView(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(height: size.height * 0.04,),
            const Text("Login your account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: size.height * 0.04,),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: size.width * 1.0,
              child: Column(

                children: [

                  TextFieldCl(labelText: 'Your email', hintText: 'Enter your email', icon: Icons.email, controller: emailController,),
                  TextFieldCl(labelText: 'Your password', hintText: 'Enter your password', icon: Icons.password, controller: passwordController,),
                  const SizedBox(height: 10,),

                  RoundBottom(onPress: () async {

                    await SqfliteHelper().database();
                    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {

                      bool status = await SqfliteHelper().loginAccount(emailController.text, passwordController.text);
                      if (status) {

                        SharedPreferences loginDetails = await SharedPreferences.getInstance();
                        loginDetails.setBool('status', true);
                        loginDetails.setString('email', emailController.text);
                        loginDetails.setString('password', passwordController.text);

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong information')));
                      }
                    }

                  }, text: 'Login now', bgColor: Colors.blueGrey, txColor: Colors.white,),
                  const SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [

                        const Text("Don't have an account "),
                         InkWell(child: const Text("Register", style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),),onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
                         },),
                    ],
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
