import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneyfreedom/Screens/kategori_pengeluaran.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:moneyfreedom/database/DataPengeluaranService.dart';
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

  get image => null;

  Future<void> getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Upload foto ke Firebase Storage
      await uploadImageToFirebase(pickedFile.path);
    }
  }

  ImagePicker imagePicker = ImagePicker();

  Future<void> getCamera() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Upload foto ke Firebase Storage
      await uploadImageToFirebase(pickedFile.path);
    }
  }

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadImageToFirebase(String imagePath) async {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    // Mendapatkan referensi storage di Firebase
    Reference storageRef =
    storage.ref().child('Pengeluaran').child(formattedDate + '.jpg');

    // Mengunggah file ke Firebase Storage
    UploadTask uploadTask = storageRef.putFile(File(imagePath));

    // Mendapatkan URL download file setelah selesai diunggah
    String downloadURL = await (await uploadTask).ref.getDownloadURL();

    // Melakukan sesuatu dengan URL download, misalnya menyimpan ke database atau menampilkan di aplikasi
    print('URL Download: $downloadURL');
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
      fotoUrl = await uploadImageToFirebase(image!).toString();
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
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.47,
                            40
                        ),
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
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.47,
                            40
                        ),
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
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 15,
                              bottom: 5
                          ),
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.74,
                          ),
                          child: const Text(
                            "Jumlah",
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 15,
                            left: 15,
                          ),
                          child: TextFormField(
                            controller: _jumlahController,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CurrencyInputFormatter()
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              filled: true, // Mengaktifkan latar belakang terisi
                              fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              bottom: 5,
                            ),
                            width: 100,
                            margin: EdgeInsets.only(
                              right: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: const Text(
                              "Kategori",
                              style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Row(
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
                                          filled: true, // Mengaktifkan latar belakang terisi
                                          fillColor: Colors.white70,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
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
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.74,
                          ),
                          child: const Text(
                            "Tanggal",
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15,
                              right: 15,
                              left: 15
                          ),
                          child: TextField(
                            controller: dateController,
                            decoration: InputDecoration(
                              filled: true, // Mengaktifkan latar belakang terisi
                              fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: Icon(Icons.calendar_month),
                              hintText: "Pilih Tanggal",
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
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 5,
                              bottom: 5
                          ),
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.74,
                          ),
                          child: const Text(
                            "Catatan",
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 15,
                              right: 15,
                              left: 15
                          ),
                          child: TextFormField(
                            controller: _catatanController,
                            decoration: InputDecoration(
                              filled: true, // Mengaktifkan latar belakang terisi
                              fillColor: Colors.white70,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelStyle: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              bottom: 5,
                              top: 5
                          ),
                          margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.74,
                          ),
                          child: const Text(
                            "Gambar",
                            style: TextStyle(
                              fontSize: 15,
                              // fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              bottom: 15,
                              right: 15,
                              left: 15
                          ),
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
                                      color: Colors.white60,
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
                                      color: Colors.white60,
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
                      ],
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