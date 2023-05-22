// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DataPengeluaranService {
  final CollectionReference _pengeluaranRef =
      FirebaseFirestore.instance.collection('dataPengeluaran');

  // Menambahkan data pengeluaran baru ke Firebase Firestore
  Future<void> tambahPengeluaran(num jumlah, String kategori, Timestamp tanggal,
      String catatan, String foto) async {
    await _pengeluaranRef.add({
      'jumlah': jumlah,
      'kategori': kategori,
      'tanggal': tanggal,
      'catatan': catatan,
      'foto': foto,
    });
  }

  // Mendapatkan semua data pengeluaran dari Firebase Firestore
  Stream<QuerySnapshot> get dataPengeluaranStream =>
      _pengeluaranRef.snapshots();

  // Menghapus data pengeluaran dari Firebase Firestore
  Future<void> hapusPengeluaran(String pengeluaranId) async {
    await _pengeluaranRef.doc(pengeluaranId).delete();
  }

  Stream<int> get totalJumlahPengeluaranStream {
    return _pengeluaranRef.snapshots().map((querySnapshot) {
      int total = 0;
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          final jumlah = data['jumlah'] as int;
          total += jumlah;
        }
      }
      return total;
    });
  }

  Future<void> ambilTanggalPengeluaran(String pengeluaranId) async {
    final DocumentSnapshot snapshot =
        await _pengeluaranRef.doc(pengeluaranId).get();

    if (snapshot.exists) {
      final data = snapshot.data();
      if (data is Map<String, dynamic>) {
        final Timestamp tanggal = data['tanggal'] as Timestamp;
        final DateTime dateTime = tanggal.toDate();
        final int year = dateTime.year;
        final int month = dateTime.month;
        final int day = dateTime.day;
        final String tanggalString = '$year-$month-$day';

        // Lakukan apa pun yang ingin kamu lakukan dengan tanggalString
        print(tanggalString);
      }
    } else {
      print('Data pengeluaran tidak ditemukan.');
    }
  }

  // Mengupdate data pengeluaran di Firebase Firestore
  Future<void> updatePengeluaran(String pengeluaranId, num jumlah,
      String kategori, Timestamp tanggal, String catatan, String foto) async {
    await _pengeluaranRef.doc(pengeluaranId).update({
      'jumlah': jumlah,
      'kategori': kategori,
      'tanggal': tanggal,
      'catatan': catatan,
      'foto': foto,
    });
  }
}
