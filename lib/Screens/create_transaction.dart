import 'dart:io';
import 'package:flutter/material.dart';
import 'package:moneyfreedom/Screens/kategori_page.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({Key? key}) : super(key: key);

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  TextEditingController dateController = TextEditingController();
  List<String> list = ['Makanan', 'Transportasi','Uang Kost'];
  late String dropDownValue = list.first;

  File? image;

  Future getImage() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
      await _picker.pickImage(source: ImageSource.gallery);
    image = File(imagePicked!.path);
    setState(() {
    });
  }

  Future getCamera() async{
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
    await _picker.pickImage(source: ImageSource.camera);
    image = File(imagePicked!.path);
    setState(() {
    });
  }


  @override
  void initState(){
    super.initState();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text('Transaksi'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(7, 15, 7, 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Jumlah',
                      hintText: 'Masukan Jumlah Uang'
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                  child: Row(
                    children: [
                        Expanded(flex: 8,child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          value: dropDownValue,
                          items: list.map<DropdownMenuItem<String>>((String value){
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: const Text('Kategori'),
                          onChanged: (String? value){
                          },
                          ),
                        ),
                      Expanded(
                        child: IconButton(
                            onPressed: () => Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context)=>kategori_page())),
                            icon: const Icon(Icons.create_outlined, size: 28,)
                        ),
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
                      labelText: "Pilih Tanggal"
                    ),
                    readOnly: true,
                    onTap: () async{
                      DateTime? pickedDate=await showDatePicker(context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );
                      if(pickedDate!=null){
                        String formattedDate=DateFormat("dd-MM-yyyy").format(pickedDate);
                        setState((){
                          dateController.text = formattedDate.toString();
                        });
                      }else{
                        print("Belum Dipilih");
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Catatan',
                        hintText: 'Masukan Catatan'
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(15, 5, 15, 20),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),child: Row(
                    children: [
                      image != null ? Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child: Image.file(image!, fit: BoxFit.cover)
                      ) : Container(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10)
                              ),
                              border: Border.all(
                                  width: 1,color: Colors.black26)
                          ),
                          child: IconButton(
                              onPressed: () async{
                                await getImage();
                              },
                              icon:const Icon(Icons.crop_original_outlined, size: 30,)
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10)
                              ),
                              border: Border.all(
                                  width: 1,color: Colors.black26)
                          ),
                          child: IconButton(
                              onPressed: () async{
                                await getCamera();
                              },
                              icon:const Icon(Icons.photo_camera, size: 28,)
                          ),
                        ),
                      ),
                  ],
                ),
                ),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    backgroundColor: Colors.blue.shade500,
                  ),
                  child: const Text("Simpan",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
