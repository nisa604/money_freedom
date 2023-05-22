import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyfreedom/Screens/kategori_pengeluaran.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneyfreedom/database/DataPengeluaranService.dart';
import 'package:moneyfreedom/database/kategoriPengeluaran.dart';
import 'create_transaction_pemasukan.dart';
import 'menu_button.dart';

class CreateTransactionPengeluaran extends StatefulWidget {
  const CreateTransactionPengeluaran({Key? key}) : super(key: key);

  @override
  State<CreateTransactionPengeluaran> createState() =>
      _CreateTransactionPengeluaranState();
}

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat('#,###');
    String newText = formatter.format(value);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}

class _CreateTransactionPengeluaranState
    extends State<CreateTransactionPengeluaran> {
  TextEditingController dateController = TextEditingController();
  TextEditingController _jumlahController = TextEditingController();
  TextEditingController _catatanController = TextEditingController();
  TextEditingController _kategoriController = TextEditingController();

  final firebase_storage.Reference storageReference =
      firebase_storage.FirebaseStorage.instance.ref().child('Pengeluaran');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // List<String> list = ['Makanan', 'Transportasi','Uang Kost'];
  // late String dropDownValue = list.first;
  String SelectedKategori = "0";

  DataPengeluaranService _dataPengeluaranService = DataPengeluaranService();

  File? image;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {});
  }

  Future getCamera() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.camera);
    image = File(imagePicked!.path);
    setState(() {});
  }

  Future<String?> uploadFile(File file) async {
    try {
      firebase_storage.TaskSnapshot taskSnapshot =
          await storageReference.child('nama_file').putFile(file);

      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (error) {
      print(error);
      return null;
    }
  }

  void _saveDataToFirestore() async {
    // Mengambil inputan dari form
    num jumlah = num.tryParse(_jumlahController.text.replaceAll(',', '')) ?? 0;
    String kategori = SelectedKategori;
    DateTime dateTime = DateTime.parse(dateController.text);
    Timestamp tanggal = Timestamp.fromDate(dateTime);
    String catatan = _catatanController.text;
    String fotoUrl = "";
    if (image != null) {
      fotoUrl = await uploadFile(image!).toString();
    }

    // Membuat objek data pengeluaran
    Map<String, dynamic> data = {
      "jumlah": jumlah,
      "kategori": kategori,
      "tanggal": tanggal,
      "catatan": catatan,
      "fotoUrl": fotoUrl,
    };

    // Menyimpan data ke Firestore
    await _dataPengeluaranService.tambahPengeluaran(
        jumlah, kategori, tanggal, catatan, fotoUrl);
  }

  @override
  void initState() {
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Transaksi'),
        leading: BackButton(
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MenuButton())),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: 400,
                height: 40,
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.blue.shade500,
                        minimumSize: const Size(185, 40),
                      ),
                      child: const Text(
                        "Pengeluaran",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                const CreateTransactionPemasukan()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(5),
                                topRight: Radius.circular(5))),
                        backgroundColor: Colors.grey.shade300,
                        minimumSize: const Size(185, 40),
                      ),
                      child: const Text(
                        "Pemasukan",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextFormField(
                        controller: _jumlahController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter()
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Jumlah',
                          hintText: 'Masukan Jumlah Uang',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('KategoriPengeluaran')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  List<DropdownMenuItem> kategoriItems = [];
                                  if (!snapshot.hasData) {
                                    const CircularProgressIndicator();
                                  } else {
                                    final kategoriPengeluaran =
                                        snapshot.data?.docs.reversed.toList();
                                    kategoriItems.add(
                                      const DropdownMenuItem(
                                        value: "0",
                                        child: Text('Pilih Kategori'),
                                      ),
                                    );
                                    for (var kategori in kategoriPengeluaran!) {
                                      kategoriItems.add(
                                        DropdownMenuItem(
                                            value: kategori.id,
                                            child: Text(kategori['kategori'])),
                                      );
                                    }
                                  }
                                  return DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    items: kategoriItems,
                                    onChanged: (kategoriValue) {
                                      setState(() {
                                        SelectedKategori = kategoriValue;
                                      });
                                      print(kategoriValue);
                                    },
                                    value: SelectedKategori,
                                    isExpanded: true,
                                  );
                                }),
                          ),
                          Expanded(
                            child: IconButton(
                                onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const kategori_pengeluaran())),
                                icon: const Icon(
                                  Icons.create_outlined,
                                  size: 28,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: Icon(Icons.calendar_month),
                          labelText: "Pilih Tanggal",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat("yyyy-MM-dd").format(pickedDate);
                            setState(() {
                              dateController.text = formattedDate.toString();
                            });
                          } else {
                            print("Belum Dipilih");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
                      child: TextFormField(
                        controller: _catatanController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Catatan',
                          hintText: 'Masukan Catatan',
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SingleChildScrollView(
                        child: Row(
                          children: [
                            image != null
                                ? Expanded(
                                    child: SizedBox(
                                      height: 200,
                                      child:
                                          Image.file(image!, fit: BoxFit.cover),
                                    ),
                                  )
                                : Container(),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  ),
                                  border: Border.all(
                                      width: 1, color: Colors.black26),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    await getImage();
                                  },
                                  icon: const Icon(
                                    Icons.crop_original_outlined,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  border: Border.all(
                                      width: 1, color: Colors.black26),
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    await getCamera();
                                  },
                                  icon: const Icon(
                                    Icons.photo_camera,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _saveDataToFirestore();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const MenuButton()));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        backgroundColor: Colors.blue.shade500,
                      ),
                      child: const Text(
                        "Simpan",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
