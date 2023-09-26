import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;

class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                future: getPhotos(),
                builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: CircularProgressIndicator(color: Colors.teal));
                  } else {
                    return ListView.builder(
                      itemCount: photosList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2.0,
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: NetworkImage(
                                      snapshot.data![index].url.toString()),
                                ),
                                title: Text("Notes ID :- " +
                                    snapshot.data![index].id.toString()),
                                subtitle: Text(
                                    snapshot.data![index].title.toString()),
                              )),
                        );
                      },
                    );
                  }
                },
                // {
                //   return ListView.builder(
                //     itemCount: photosList.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(snapshot.data![index].title.toString()),
                //         subtitle: Text(snapshot.data![index].url.toString()),
                //       );
                //     },
                //   );
                // },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}
