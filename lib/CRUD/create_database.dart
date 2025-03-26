import 'package:belajar_sqflite/database/database_instance.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    databaseInstance.database();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Create Data'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama Produk'),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Nama Produk',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 15),
            Text('Kategori Produk'),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blueGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Kategori Produk',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () async {
                await databaseInstance.insert({
                  'name': nameController.text,
                  'category': categoryController.text,
                  'created_at': DateTime.now().toString(),
                  'updated_at': DateTime.now().toString(),
                });
                Navigator.pop(context);

              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
