import 'dart:convert';

import 'package:api_tutorial/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class HomeScreen5 extends StatefulWidget {
  const HomeScreen5({super.key});

  @override
  State<HomeScreen5> createState() => _HomeScreen5State();
}

class _HomeScreen5State extends State<HomeScreen5> {
  List<ProductModel> productList = [];
  Future<List<ProductModel>> productapi() async {
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/products'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        productList.add(ProductModel.fromJson(i));
      }
      return productList;
    } else {
      return productList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("API'S Tutorial"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: productapi(),
            builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.teal),
                );
              } else {
                return ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(snapshot
                                    .data![index].category!.image
                                    .toString()))),
                      ),
                      // leading: CircleAvatar(
                      //   backgroundImage:
                      //       NetworkImage(snapshot.data![index].images![0]),
                      // ),
                      title: Text(snapshot.data![index].title.toString()),
                      subtitle:
                          Text(snapshot.data![index].category!.name.toString()),
                    );
                  },
                );
              }
            },
          ))
        ],
      ),
    );
  }
}
