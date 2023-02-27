import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneyfreedom/list/MonthList.dart';
import 'package:filter_list/filter_list.dart';

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

              // text transaksi Bulan
              // DecoratedBox(
              //     decoration: BoxDecoration(color: Colors.transparent),
              //     child: Padding(
              //       padding: EdgeInsets.only(left: 15),
              //       child: DropdownButton<String>(
              //         value: selectedItem,
              //         items: Bulan.map((month) => DropdownMenuItem<String>(
              //               value: month,
              //               child: Text(month, style: TextStyle(fontSize: 18)),
              //             )).toList(),
              //         onChanged: (Bulan) => setState(() => selectedItem = Bulan),
              //         icon: Padding(
              //             padding: EdgeInsets.zero, child: Icon(Icons.list)),
              //       ),
              //     )),

              //pilihan bulan atau harian
              // DecoratedBox(
              //     decoration: BoxDecoration(color: Colors.transparent),
              //     child: Padding(
              //       padding: EdgeInsets.only(left: 15),
              //       child: DropdownButton<String>(
              //         value: selected,
              //         items: Pilihan.map((pilih) => DropdownMenuItem<String>(
              //               value: pilih,
              //               child: Text(pilih),
              //             )).toList(),
              //         onChanged: (Pilihan) => setState(() => selected = Pilihan),
              //         icon: Padding(
              //             padding: EdgeInsets.zero, child: Icon(Icons.list)),
              //       ),
              //     )),

              // Padding(
              // padding: const EdgeInsets.symmetric(horizontal: 8),
              // child: Card(
              //     elevation: 8,
              //     child: ListTile(
              //       trailing: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         children: [
              //           IconButton(
              //               // alignment: AlignmentDirectional.centerStart,
              //               onPressed: () {
              //                 // Route menu ke halaman utama
              //                 //   Navigator.pushReplacement(
              //                 //       context,
              //                 //       MaterialPageRoute(
              //                 //           builder: (context) => const monthlist()));
              //               },
              //               icon: Icon(Icons.list)),
              //           DropdownButton<String>(
              //             value: selectedItem,
              //             items: Bulan.map((month) => DropdownMenuItem<String>(
              //                   value: month,
              //                   child: Text(month, style: TextStyle(fontSize: 8)),
              //                 )).toList(),
              //             onChanged: (Bulan) =>
              //                 setState(() => selectedItem = Bulan),
              //           )
              //           // SizedBox(width: 5)
              //         ],
              //       ),
              //       title: Text(
              //         "Februari",
              //         style: GoogleFonts.montserrat(),
              //       ),
              //     )),
              // ),

              //list transaksi
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      ],
                    ),
                    title: Text("Rp 2.000.000"),
                    subtitle: Text("Bayar kos"),
                    leading: Container(
                      child: Icon(Icons.upload, color: Colors.red),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),

              //list uang masuk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  elevation: 10,
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
                        // SizedBox(
                        //   width: 10,
                        // ),
                        IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      ],
                    ),
                    title: Text("Rp 5.000.000"),
                    subtitle: Text("Uang jajan"),
                    leading: Container(
                      child: Icon(Icons.download, color: Colors.green),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              )
            ],
          )),
    );

    // return Scaffold(
    //   backgroundColor: Colors.grey.shade200,
    //   appBar: AppBar(
    //     title: const Text('MoneyFreedom'),
    //   ),
    //   drawer: const DrawerNavigation(
    //       width: 100,
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => Navigator.of(context)
    //       .push(MaterialPageRoute(builder: (context)=>CreateTransaction())),
    //     child : Icon(Icons.add),
    //   ),
    // );
  }
}
