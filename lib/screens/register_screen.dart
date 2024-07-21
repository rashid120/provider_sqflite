
import 'package:flutter/material.dart';
import 'package:provide_sqflite/components/edit_text.dart';
import 'package:provide_sqflite/components/round_bottom.dart';
import 'package:provide_sqflite/screens/home_screen.dart';
import 'package:provide_sqflite/sqflite_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatelessWidget {
   RegisterPage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blueGrey, title: const Text('Register page')),
      body: SingleChildScrollView(

        child: Column(

          children: [
            SizedBox(height: size.height * 0.04,),
            const Text("Create account", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: size.height * 0.04,),

            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              width: size.width * 1.0,

              child: Card(
                shadowColor: Colors.blueGrey,
                elevation: 40.0,

                child: Column(
                  children: [

                    TextFieldCl(labelText: 'Your name', hintText: 'Enter your name', icon: Icons.person, controller: nameController,),
                    TextFieldCl(labelText: 'Your phone', hintText: 'Enter your phone', icon: Icons.phone_android, controller: phoneController,),
                    TextFieldCl(labelText: 'Your email', hintText: 'Enter your email', icon: Icons.email, controller: emailController,),

                    ListTile(title: const Text("Gender"), trailing: PopupMenuButton(itemBuilder: (context) {
                      return [
                        PopupMenuItem(value: 'Male',onTap: () {
                          gender = 'Male';
                          genderController.text = 'Male';
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Male')));
                        },child: const Text('Male'),),
                        PopupMenuItem(value: 'Female',onTap: () {
                          gender = 'Female';
                          genderController.text = 'Female';
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Female')));
                        },child: const Text('Female'), ),
                      ];
                    },enabled: true,),subtitle: Text(gender != null ? '$gender' : 'Select your gender'),),

                    TextFieldCl(labelText: 'Create password', hintText: 'Create your password', icon: Icons.password, controller: passwordController,),

                    const SizedBox(height: 10,),

                    RoundBottom(onPress: () async {

                      await SqfliteHelper().database();
                      if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && phoneController.text.isNotEmpty && genderController.text.isNotEmpty && passwordController.text.isNotEmpty ) {

                        await SqfliteHelper().insertData({

                          SqfliteHelper.columnName: nameController.text,
                          SqfliteHelper.columnNumber: phoneController.text,
                          SqfliteHelper.columnEmail: emailController.text,
                          SqfliteHelper.columnGender: genderController.text,
                          SqfliteHelper.columnPassword: passwordController.text,

                        });

                        SharedPreferences loginDetails = await SharedPreferences.getInstance();
                        loginDetails.setBool('status', true);
                        loginDetails.setString('email', emailController.text);
                        loginDetails.setString('password', passwordController.text);

                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Insert Successful")));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                      }
                    }, text: 'Register now', bgColor: Colors.blueGrey, txColor: Colors.white,),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
