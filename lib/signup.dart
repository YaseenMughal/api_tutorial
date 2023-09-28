import 'dart:convert';

import 'package:api_tutorial/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  void login(email, password) async {
    try {
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
          body: {'email': email, 'password': password});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("Account Created Successfully");
        if (response.body == '') {
          print("required email & password");
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ));
        }
      } else {
        print("Failed to load");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("SIGN-UP"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 25, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "WELCOME TO OUR\n     API TUTORIAL",
                style: TextStyle(fontSize: 32.0, color: Colors.teal),
              ),
              SizedBox(height: 35),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: passwordlController,
                decoration: InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
              ),
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  login(emailController.text.toString(),
                      passwordlController.text.toString());
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text("SIGN-UP",
                          style:
                              TextStyle(fontSize: 20.0, color: Colors.white))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
