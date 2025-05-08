import 'package:belajar_sqflite/CRUD/create_database.dart';
import 'package:belajar_sqflite/CRUD/update_database.dart';
import 'package:belajar_sqflite/database/database_instance.dart';
import 'package:belajar_sqflite/database/productmodel_instance.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Aplikasi Pos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseInstance? databaseInstance;

  Future _refresh() async {
    setState(() {});
  }

  Future initDatabase() async {
    await databaseInstance!.database();
    setState(() {});
  }

  Future delete(int id) async {
    await databaseInstance!.delete(id);
    setState(() {
      
    });
  }

  @override
  void initState() {
    databaseInstance = DatabaseInstance();
    initDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return CreateScreen();
                  },
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child:
            databaseInstance != null
                ? FutureBuilder<List<ProductModel>>(
                  future: databaseInstance!.all(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return Center(child: Text('Data Kosong'));
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(snapshot.data![index].name ?? ''),
                            subtitle: Text(
                              snapshot.data![index].category ?? '',
                            ),
                            leading: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return UpdateScreen(
                                        productModel: snapshot.data![index],
                                      );
                                    },
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.edit),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                delete(snapshot.data![index].id!);
                              },
                              icon: Icon(Icons.delete),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      );
                    }
                  },
                )
                : Center(child: CircularProgressIndicator(color: Colors.blue)),
      ),
    );
  }
}
