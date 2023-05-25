// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class Profil {
//   final String namaProfil;
//   final String kodeAvatar;
//
//
//   Map<String, dynamic> toJson() {
//     return {
//       'namaProfil': namaProfil,
//       'kodeAvatar': kodeAvatar,
//     };
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class DataProfil {
  final String namaProfil;
  final String kodeAvatar;

  DataProfil({
    required this.namaProfil,
    required this.kodeAvatar,
  });

  Map<String, dynamic> toJson() {
    return {
      'namaProfil': namaProfil,
      'kodeAvatar': kodeAvatar,
    };
  }

  factory DataProfil.fromJson(Map<String, dynamic> json) {
    return DataProfil(
      namaProfil: json['namaProfil'],
      kodeAvatar: json['kodeAvatar'],
    );
  }
}
