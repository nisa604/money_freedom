import 'package:cloud_firestore/cloud_firestore.dart';

class DataPemasukanService {
  final CollectionReference _pemasukanRef =
      FirebaseFirestore.instance.collection('dataPemasukan');

  // Menambahkan data pemasukan baru ke Firebase Firestore
  Future<void> tambahPemasukan(
      num jumlahPemasukan,
      String kategoriPemasukan,
      Timestamp tanggalPemasukan,
      String catatanPemasukan,
      String fotoUrlPemasukan,
  ) async {
    await _pemasukanRef.add({
      'jumlahPemasukan': jumlahPemasukan,
      'kategoriPemasukan': kategoriPemasukan,
      'tanggalPemasukan': tanggalPemasukan,
      'catatanPemasukan': catatanPemasukan,
      'fotoUrlPemasukan': fotoUrlPemasukan,
    });
  }

  // Mendapatkan semua data pemasukan dari Firebase Firestore
  Stream<QuerySnapshot> get dataPemasukanStream =>
      _pemasukanRef.snapshots();

  // Menghapus data pemasukan dari Firebase Firestore
  Future<void> hapusPemasukan(String pemasukanId) async {
    await _pemasukanRef.doc(pemasukanId).delete();
  }

  // Mengupdate data pemasukan di Firebase Firestore
  Future<void> updatePemasukan(
      String pemasukanId,
      num jumlahPemasukan,
      String kategoriPemasukan,
      Timestamp tanggalPemasukan,
      String catatanPemasukan,
      String fotoUrlPemasukan,
  ) async {
    await _pemasukanRef.doc(pemasukanId).update({
      'jumlahPemasukan': jumlahPemasukan,
      'kategoriPemasukan': kategoriPemasukan,
      'tanggalPemasukan': tanggalPemasukan,
      'catatanPemasukan': catatanPemasukan,
      'fotoUrlPemasukan': fotoUrlPemasukan,
    });
  }
}
