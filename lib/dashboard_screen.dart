import 'package:api_tutorial/home_screen.dart';
import 'package:api_tutorial/home_screen2.dart';
import 'package:api_tutorial/home_screen3.dart';
import 'package:api_tutorial/home_screen4.dart';
import 'package:api_tutorial/home_screen5.dart';
import 'package:api_tutorial/upload_image_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("API'S Tutorial"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome To API's Tutuorial",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 35),
                button(context, HomeScreen5(), "Complex API"),
                SizedBox(height: 20),
                button(context, HomeScreen4(), "Different way API"),
                SizedBox(height: 20),
                button(context, HomeScreen3(), "Users API"),
                SizedBox(height: 20),
                button(context, HomeScreen2(), "Photos API"),
                SizedBox(height: 20),
                button(context, HomeScreen(), "Posts API"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

button(BuildContext context, onpressed, text) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => onpressed));
    },
    child: Container(
      height: 80.0,
      width: double.infinity,
      color: Colors.teal[300],
      child: Center(
          child: Text(
        text,
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    ),
  );
}
