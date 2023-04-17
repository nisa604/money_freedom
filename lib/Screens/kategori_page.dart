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


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// class kategori_page extends StatefulWidget {
//   const kategori_page({Key? key}) : super(key: key);
//
//   @override
//   State<kategori_page> createState() => _kategori_pageState();
// }
//
// class _kategori_pageState extends State<kategori_page> {
//   final CollectionReference _kategoriPengeluaran =
//       FirebaseFirestore.instance.collection('kategoriPengeluaran');
//
//   final TextEditingController _namaController = TextEditingController();
//   Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
//     if (documentSnapshot != null) {
//       _namaController.text = documentSnapshot['nama'];
//     }
//
//     Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
//       if (documentSnapshot != null) {
//         _namaController.text = documentSnapshot['nama'];
//       }
//
//       await showModalBottomSheet(
//           isScrollControlled: true,
//           context: context,
//           builder: (BuildContext ctx) {
//             return Padding(
//               padding: EdgeInsets.only(
//                   top: 20,
//                   left: 20,
//                   right: 20,
//                   bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextField(
//                     controller: _namaController,
//                     decoration: InputDecoration(labelText: 'Nama'),
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   ElevatedButton(
//                     child: const Text('update'),
//                     onPressed: () async {
//                       final String name = _namaController.text;
//                       // await _kategoriPengeluaran
//                       // .doc(documentSnapshot!.id)
//                       // .update({"nama": name});
//                       // _namaController.text = '';
//                     },
//                   )
//                 ],
//               ),
//             );
//           });
//     }
//
//     @override
//     Widget build(BuildContext context) {
//       return Scaffold(
//         backgroundColor: Colors.grey.shade200,
//         appBar: AppBar(
//           title: const Text('Kategori'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.add),
//               onPressed: () {
//                 openDialog();
//               },
//             ),
//           ],
//         ),
//         body: StreamBuilder(
//           stream: _kategoriPengeluaran.snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//             if (streamSnapshot.hasData) {
//               return ListView.builder(
//                 itemCount: streamSnapshot.data!.docs.length,
//                 itemBuilder: (context, index) {
//                   final DocumentSnapshot documentSnapshot =
//                       streamSnapshot.data!.docs[index];
//                   return Card(
//                     margin: EdgeInsets.all(10),
//                     child: ListTile(
//                       title: Text(documentSnapshot['nama']),
//                       trailing: SizedBox(
//                         width: 100,
//                         child: Row(children: [
//                           IconButton(
//                               onPressed: () => _update(documentSnapshot),
//                               icon: Icon(Icons.edit)),
//                         ]),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       );
//     }
//   }
//
//   Future<String?> openDialog() => showDialog<String?>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Buat Kategori'),
//           content: const TextField(
//             // controller: _namaController,
//             autofocus: true,
//             decoration: InputDecoration(hintText: 'Masukan Nama Kategori'),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Batal'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text('Simpan'),
//             ),
//           ],
//         ),
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }
