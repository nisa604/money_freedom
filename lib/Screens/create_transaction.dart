import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateTransaction extends StatefulWidget {
  const CreateTransaction({Key? key}) : super(key: key);

  @override
  State<CreateTransaction> createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  TextEditingController dateController = TextEditingController();
  List<String> list = ['Makanan', 'Transportasi','Uang Kost'];
  late String dropDownValue = list.first;


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
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
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
            Padding(
              padding:  const EdgeInsets.all(10),
              child: DropdownButtonFormField(
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
      )
    );
  }
}
