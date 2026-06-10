import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sm6aplikasiku/models/bookmark_model.dart';

class BookmarkService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'bookmarks';

  /// Mendapatkan stream semua bookmark, diurutkan dari terbaru
  Stream<List<BookmarkModel>> getBookmarksStream() {
    try {
      return _firestore
          .collection(_collection)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
            try {
              // Mengubah setiap document Firestore menjadi objek BookmarkModel
              return snapshot.docs
                  .map((doc) => BookmarkModel.fromFirestore(doc))
                  .toList();
            } catch (e) {
              throw Exception('Gagal memparse data bookmark: $e');
            }
          });
    } on FirebaseException catch (e) {
      throw Exception('Firebase error [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Gagal memuat stream bookmark: $e');
    }
  }

  /// Menambahkan bookmark baru (cek duplikat sebelum insert)
  Future<void> addBookmark(BookmarkModel bookmark) async {
    try {
      // mengecek apakah nomor surah sudah pernah dibookmark
      final existing = await _firestore
          .collection(_collection)
          .where('nomorSurah', isEqualTo: bookmark.nomorSurah)
          .get();

      // Jika belum ada, simpan bookmark baru

      if (existing.docs.isEmpty) {
        await _firestore.collection(_collection).add(bookmark.toFirestore());
      }
    } on FirebaseException catch (e) {
      throw Exception('Firebase error [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Gagal menambahkan bookmark: $e');
    }
  }

  /// Menghapus bookmark berdasarkan nomor surah
  Future<void> removeBookmarkBySurahNumber(int nomorSurah) async {
    try {
      // cek seluruh dokumen yang memiliki nomor surah yang sama
      final snapshot = await _firestore
          .collection(_collection)
          .where('nomorSurah', isEqualTo: nomorSurah)
          .get();

      if (snapshot.docs.isEmpty) return;

      // Menghapus seluruh dokumen yang ditemukan

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw Exception('Firebase error [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Gagal menghapus bookmark: $e');
    }
  }

  /// Menghapus bookmark berdasarkan document ID
  Future<void> removeBookmarkById(String id) async {
    try {
      // Validasi agar ID dokumen tidak kosong
      if (id.isEmpty) throw Exception('ID dokumen tidak boleh kosong');
      await _firestore.collection(_collection).doc(id).delete();
    } on FirebaseException catch (e) {
      throw Exception('Firebase error [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Gagal menghapus bookmark: $e');
    }
  }

  /// Mengecek apakah surah sudah ada di bookmark
  Future<bool> isBookmarked(int nomorSurah) async {
    try {
      // Mencari data bookmark berdasarkan nomor surah
      final snapshot = await _firestore
          .collection(_collection)
          .where('nomorSurah', isEqualTo: nomorSurah)
          .get();
      // Mengembalikan true jika data ditemukan
      return snapshot.docs.isNotEmpty;
    } on FirebaseException catch (e) {
      throw Exception('Firebase error [${e.code}]: ${e.message}');
    } catch (e) {
      throw Exception('Gagal memeriksa status bookmark: $e');
    }
  }
}
