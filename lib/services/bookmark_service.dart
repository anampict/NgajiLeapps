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
          .map((snapshot) =>
              snapshot.docs.map((doc) => BookmarkModel.fromFirestore(doc)).toList());
    } catch (e) {
      rethrow;
    }
  }

  /// Menambahkan bookmark baru
  Future<void> addBookmark(BookmarkModel bookmark) async {
    try {
      // Cek apakah surah ini sudah ada di bookmark
      final existing = await _firestore
          .collection(_collection)
          .where('nomorSurah', isEqualTo: bookmark.nomorSurah)
          .get();

      if (existing.docs.isEmpty) {
        await _firestore.collection(_collection).add(bookmark.toFirestore());
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Menghapus bookmark berdasarkan nomor surah
  Future<void> removeBookmarkBySurahNumber(int nomorSurah) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('nomorSurah', isEqualTo: nomorSurah)
          .get();

      for (final doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Menghapus bookmark berdasarkan document ID
  Future<void> removeBookmarkById(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  /// Mengecek apakah surah sudah ada di bookmark
  Future<bool> isBookmarked(int nomorSurah) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('nomorSurah', isEqualTo: nomorSurah)
          .get();
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
