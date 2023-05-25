// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ProfilServices {
//   final CollectionReference _profilRef =
//   FirebaseFirestore.instance.collection('Profil');
//
//   Stream<QuerySnapshot> get profilStream =>
//       _pemasukanRef.snapshots();
// }

// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilService {
  final CollectionReference _profilRef =
  FirebaseFirestore.instance.collection('Profil');

  Future<Object> getProfil(String ProfilId) async {
    DocumentSnapshot snapshot =
    await _profilRef.doc(ProfilId).get();
    if (snapshot.exists) {
      String profil =
      (snapshot.data() as Map<String, dynamic>)['Profil'];
      return profil;
    } else {
      // Dokumen tidak ditemukan
      return Exception('Tidak Ditemukan');
    }
  }

  // Menambahkan data profil baru ke Firebase Firestore
  Future<void> tambahProfil(String namaProfil,
      String kodeAvatar) async {
    await _profilRef.add({
      'namaProfil': namaProfil,
      'kodeAvatar': kodeAvatar,
    });
  }

  // Mendapatkan semua data Profil dari Firebase Firestore
  Stream<QuerySnapshot> get ProfilStream =>
      _profilRef.snapshots();

  // Menghapus data pengeluaran dari Firebase Firestore
  Future<void> hapusProfil(String ProfilId) async {
    await _profilRef.doc(ProfilId).delete();
  }

}
