import 'package:flutter/material.dart';

class kategori_page extends StatefulWidget {
  const kategori_page({Key? key}) : super(key: key);

  @override
  State<kategori_page> createState() => _kategori_pageState();
}

class _kategori_pageState extends State<kategori_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Kategori'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              openDialog();
            },
          ),
        ],
      ),
    );
  }

  Future<String?> openDialog() => showDialog<String?>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Buat Kategori'),
      content: const TextField(
        // controller: controller,
        autofocus: true,
        decoration: InputDecoration(
            hintText: 'Masukan Nama Kategori'
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: const Text('Simpan'),
        ),
      ],
    ),
  );
}