import 'package:belajar_sqflite/database/database_instance.dart';
import 'package:belajar_sqflite/database/productmodel_instance.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final ProductModel? productModel;
  const UpdateScreen({Key? key, this.productModel}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  DatabaseInstance databaseInstance = DatabaseInstance();
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    print(widget.productModel!.id!);
    databaseInstance.database();
    nameController.text = widget.productModel!.name ?? '';
    categoryController.text = widget.productModel!.category ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Edit Data'),
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
                fillColor: const Color.fromARGB(255, 11, 182, 204),
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
                fillColor: const Color.fromARGB(255, 11, 182, 204),
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
                await databaseInstance.update(widget.productModel!.id!,{
                  'name': nameController.text,
                  'category': categoryController.text,
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
