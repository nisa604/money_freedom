// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DataPengeluaranService {
  final CollectionReference _pengeluaranRef =
      FirebaseFirestore.instance.collection('dataPengeluaran');

  // Menambahkan data pengeluaran baru ke Firebase Firestore
  Future<void> tambahPengeluaran(num jumlah, String kategori, Timestamp tanggal,
      String catatan, String fotoUrl) async {
    await _pengeluaranRef.add({
      'jumlah': jumlah,
      'kategori': kategori,
      'tanggal': tanggal,
      'catatan': catatan,
      'foto': fotoUrl,
    });
  }

  // Mendapatkan semua data pengeluaran dari Firebase Firestore
  Stream<QuerySnapshot> get dataPengeluaranStream =>
      _pengeluaranRef.snapshots();

  // Menghapus data pengeluaran dari Firebase Firestore
  Future<void> hapusPengeluaran(String pengeluaranId) async {
    await _pengeluaranRef.doc(pengeluaranId).delete();
  }

  // Mengupdate data pengeluaran di Firebase Firestore
  Future<void> updatePengeluaran(String pengeluaranId, num jumlah,
      String kategori, Timestamp tanggal, String catatan, String fotoUrl) async {
    await _pengeluaranRef.doc(pengeluaranId).update({
      'jumlah': jumlah,
      'kategori': kategori,
      'tanggal': tanggal,
      'catatan': catatan,
      'foto': fotoUrl,
    });
  }
}
