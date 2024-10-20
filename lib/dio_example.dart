
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {

  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  Dio dio = Dio();
  List<dynamic> listData = [];

  void getData() async {
    try {
      Response data = await dio.get("https://jsonplaceholder.typicode.com/posts");

      if(data.statusCode == 200) {
        setState(() {
          listData = data.data as List;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void addPost() async {
    try {
      Response data = await dio.post("https://jsonplaceholder.typicode.com/posts", data: {
        "title": "lolololo",
        "body": "lolololol",
        "userId": 3000
      });

        print(data.data);
        setState(() {
          listData.add(data.data);
        });
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return Card(
                surfaceTintColor: Colors.amber.shade50,
                child: ListTile(
                  leading: ClipRRect(child: Image.network("https://picsum.photos/400/300", fit: BoxFit.fill, width: 50, height: 50,), borderRadius: BorderRadius.all(Radius.circular(50)), ),
                  title: Text(listData[index]['title']),
                  subtitle: Text(listData[index]["body"]),
                ),
              );
            }, itemCount: listData.isEmpty ? 0 : listData.length,),
          ),
          ElevatedButton(onPressed: addPost, child: Text("Add new post"))
          ],
        ),
      ),
    );
  }
}