import 'dart:convert';
import 'package:api_tutorial/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen5 extends StatefulWidget {
  const HomeScreen5({super.key});

  @override
  State<HomeScreen5> createState() => _HomeScreen5State();
}

class _HomeScreen5State extends State<HomeScreen5> {
  List<ProductModel> productList = [];
  Future<List<ProductModel>> getProduct() async {
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        ProductModel products = ProductModel(
          title: i['title'],
          price:
              (i['price'] is int) ? (i['price'] as int).toDouble() : i['price'],
          // price: i['price'],
          description: i['description'],
          category: i['category'],
          url: i['image'],
          id: i['id'],
          // rating:
          //     Rating(rate: i['rating']['rate'], count: i['rating']['count'])
        );
        productList.add(products);
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
        title: Text("API TUTORIAL"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: getProduct(),
              builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.teal),
                  );
                } else {
                  return ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Image.network(
                                      snapshot.data![index].url.toString(),
                                      height: 200,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Product :- ${snapshot.data![index].title}",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromARGB(255, 63, 83, 93)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Description :- ${snapshot.data![index].description}",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          color: Color.fromARGB(
                                              255, 86, 145, 174)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Price :- \$ ${snapshot.data![index].price}",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          color:
                                              Color.fromARGB(255, 2, 16, 23)),
                                    ),
                                  ],
                                ))
                          ],
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
