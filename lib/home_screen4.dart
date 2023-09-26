import 'dart:convert';
import 'package:api_tutorial/home_screen3.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen4 extends StatefulWidget {
  const HomeScreen4({super.key});

  @override
  State<HomeScreen4> createState() => _HomeScreen4State();
}

class _HomeScreen4State extends State<HomeScreen4> {
  var data;
  Future<void> getApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("API'S Tutorial"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: getApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.teal),
                  );
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: "Name", value: data[index]['name']),
                              ReusableRow(
                                  title: "Username",
                                  value: data[index]['username']),
                              ReusableRow(
                                  title: "Email", value: data[index]['email']),
                              ReusableRow(
                                  title: "Address",
                                  value: data[index]['address']['city']),
                              ReusableRow(
                                  title: "Geo",
                                  value:
                                      data[index]['address']['geo'].toString()),
                              ReusableRow(
                                  title: "Company",
                                  value: data[index]['company']['name'])
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
