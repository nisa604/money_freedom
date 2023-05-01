import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:moneyfreedom/database/DataPengeluaranService.dart';
import 'package:moneyfreedom/database/DataPemasukanService.dart';
import 'create_transaction_pemasukan.dart';
import 'create_transaction_pengeluaran.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> Bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  String? selectedItem = 'Januari';
  List<String> Pilihan = ['Harian', 'Bulanan', 'Tahunan', 'Custom'];
  String? selected = '';

  DataPengeluaranService _dataPengeluaranService = DataPengeluaranService();
  DataPemasukanService _dataPemasukanService = DataPemasukanService();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //button pasif income
              Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 192, 192, 192
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Icon(
                                  Icons.download,
                                  color: Colors.green
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Pemasukan"),
                                //style: GoogleFonts.montserrat(Color: colors.white, fontsize: 12 ),
                                SizedBox(height: 10),
                                Text("Rp. 2.000.000"),
                                //style: GoogleFonts.montserrat(Color: colors.white, fontsize: 12 ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(Icons.upload, color: Colors.red),
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Pengeluaran"),
                                //style: GoogleFonts.montserrat(Color: colors.white, fontsize: 12 ),
                                SizedBox(height: 10),
                                Text("Rp. 2.000.000"),
                                //style: GoogleFonts.montserrat(Color: colors.white, fontsize: 12 ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )),
              //try row
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                          value: selectedItem,
                          items: Bulan.map((month) => DropdownMenuItem<String>(
                            value: month,
                            child:
                            Text(month, style: TextStyle(fontSize: 18)),
                          )).toList(),
                          onChanged: (Bulan) =>
                              setState(() => selectedItem = Bulan),
                          icon: const Icon(Icons.repeat)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                          onChanged: (Pilihan) => selected,
                          // value: selected,
                          items:
                          Pilihan.map((pilih) => DropdownMenuItem<String>(
                            value: pilih,
                            child: Text(pilih),
                          )).toList(),
                          // onChanged: (Pilihan) =>
                          //     setState(() => selected = Pilihan),
                          icon: const Icon(Icons.tune)),
                    )
                  ],
                ),
              ),
              //list transaksi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder<QuerySnapshot>(
                  stream: DataPengeluaranService().dataPengeluaranStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Terjadi kesalahan saat memuat data');
                    }
                    
                    if (!snapshot.hasData) {
                      return Text('Belum ada data pengeluaran');
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final pengeluaran = snapshot.data!.docs[index];

                        return Card(
                          elevation: 10,
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(onPressed: () async {
                                  await _dataPengeluaranService.hapusPengeluaran(pengeluaran.id); // menghapus data dari Firestore
                                  setState((){}); // memperbarui tampilan setelah data dihapus
                                }, icon: Icon(Icons.delete)),
                                IconButton(onPressed: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context)=>CreateTransactionPengeluaran())),
                                icon: Icon(Icons.edit)),
                              ],
                            ),
                            // title: Text("Rp ${pengeluaran['jumlah']}"),
                              title: Text("Rp ${NumberFormat.decimalPattern('id_ID').format(pengeluaran['jumlah'])}"),
                            subtitle: Text(pengeluaran['kategori']),
                            leading: Container(
                              child: Icon(Icons.upload, color: Colors.red),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              //list uang masuk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: StreamBuilder<QuerySnapshot>(
                  stream: DataPemasukanService().dataPemasukanStream,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Terjadi kesalahan saat memuat data');
                    }
                    
                    if (!snapshot.hasData) {
                      return Text('Belum ada data Pemasukan');
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Pemasukan = snapshot.data!.docs[index];

                        return Card(
                          elevation: 10,
                          child: ListTile(
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(onPressed: () async {
                                  await _dataPemasukanService.hapusPemasukan(Pemasukan.id); // menghapus data dari Firestore
                                  setState((){}); // memperbarui tampilan setelah data dihapus
                                }, icon: Icon(Icons.delete)),
                                IconButton(onPressed: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context)=>CreateTransactionPemasukan())),
                                icon: Icon(Icons.edit)),
                              ],
                            ),
                            // title: Text("Rp ${Pemasukan['jumlahPemasukan']}"),
                            title: Text("Rp ${NumberFormat.decimalPattern('id_ID').format(Pemasukan['jumlahPemasukan'])}"),
                            subtitle: Text(Pemasukan['kategoriPemasukan']),
                            leading: Container(
                              child: Icon(Icons.download, color: Colors.green),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
