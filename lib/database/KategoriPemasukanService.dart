// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class KategoriPemasukanService {
  final CollectionReference _kategori_pemasukanRef =
  FirebaseFirestore.instance.collection('KategoriPemasukan');

  // Menambahkan data pengeluaran baru ke Firebase Firestore
  Future<void> tambahKategoriPemasukan(String fotoKategoriIn,
      String namaKategoriIn, Timestamp tanggalDibuat) async {
    await _kategori_pemasukanRef.add({
      'foto': fotoKategoriIn,
      'kategori': namaKategoriIn,
      'tanggal': tanggalDibuat,
    });
  }

  // Mendapatkan semua data pengeluaran dari Firebase Firestore
  Stream<QuerySnapshot> get KategoriPemasukanStream =>
      _kategori_pemasukanRef.snapshots();

  // Menghapus data pengeluaran dari Firebase Firestore
  Future<void> hapusKategoriPemasukan(String kategoriPengeluaranId) async {
    await _kategori_pemasukanRef.doc(kategoriPengeluaranId).delete();
  }

}
