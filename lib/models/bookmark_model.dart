import 'package:cloud_firestore/cloud_firestore.dart';

class BookmarkModel {
  final String id; // Firestore document ID
  final int nomorSurah;
  final String namaLatin;
  final String namaArab;
  final int jumlahAyat;
  final String jenis;
  final DateTime createdAt;

  BookmarkModel({
    required this.id,
    required this.nomorSurah,
    required this.namaLatin,
    required this.namaArab,
    required this.jumlahAyat,
    required this.jenis,
    required this.createdAt,
  });

  factory BookmarkModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return BookmarkModel(
      id: doc.id,
      nomorSurah: data['nomorSurah'] as int? ?? 0,
      namaLatin: data['namaLatin'] as String? ?? '',
      namaArab: data['namaArab'] as String? ?? '',
      jumlahAyat: data['jumlahAyat'] as int? ?? 0,
      jenis: data['jenis'] as String? ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Mengubah objek BookmarkModel menjadi format Map yang bisa disimpan ke Firebase Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      'nomorSurah': nomorSurah,
      'namaLatin': namaLatin,
      'namaArab': namaArab,
      'jumlahAyat': jumlahAyat,
      'jenis': jenis,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
