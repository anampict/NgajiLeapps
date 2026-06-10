import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/models/bookmark_model.dart';
import 'package:sm6aplikasiku/models/surah.dart';
import 'package:sm6aplikasiku/services/bookmark_service.dart';

class BookmarkController extends GetxController {
  final BookmarkService _service = BookmarkService();

  final RxList<BookmarkModel> bookmarks = <BookmarkModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxSet<int> bookmarkedSurahNumbers = <int>{}.obs;

  StreamSubscription<List<BookmarkModel>>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _listenToBookmarks();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  /// Mendengarkan perubahan realtime dari Firestore
  void _listenToBookmarks() {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      _subscription = _service.getBookmarksStream().listen(
        (data) {
          bookmarks.value = data;
          bookmarkedSurahNumbers.assignAll(
              data.map((b) => b.nomorSurah).toSet());
          isLoading.value = false;
        },
        onError: (e) {
          errorMessage.value = 'Gagal memuat bookmark: ${e.toString()}';
          isLoading.value = false;
        },
      );
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: ${e.toString()}';
      isLoading.value = false;
    }
  }

  /// Toggle bookmark: tambah jika belum ada, hapus jika sudah ada
  Future<void> toggleBookmark(Surah surah) async {
    try {
      final isAlreadyBookmarked = bookmarkedSurahNumbers.contains(surah.nomor);

      if (isAlreadyBookmarked) {
        await _service.removeBookmarkBySurahNumber(surah.nomor);
        Get.snackbar(
          'Bookmark Dihapus',
          '${surah.namaLatin} dihapus dari bookmark',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFFF5252),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
      } else {
        final bookmark = BookmarkModel(
          id: '',
          nomorSurah: surah.nomor,
          namaLatin: surah.namaLatin,
          namaArab: surah.namaArab,
          jumlahAyat: surah.jumlahAyat,
          jenis: surah.jenis,
          createdAt: DateTime.now(),
        );
        await _service.addBookmark(bookmark);
        Get.snackbar(
          'Bookmark Ditambahkan',
          '${surah.namaLatin} disimpan ke bookmark',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1B9B6C),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF5252),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  /// Hapus bookmark berdasarkan document ID
  Future<void> removeBookmark(String id, String namaLatin) async {
    try {
      await _service.removeBookmarkById(id);
      Get.snackbar(
        'Bookmark Dihapus',
        '$namaLatin dihapus dari bookmark',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF5252),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Terjadi kesalahan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFF5252),
        colorText: const Color(0xFFFFFFFF),
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
    }
  }

  /// Cek apakah surah tertentu sudah di-bookmark
  bool isSurahBookmarked(int nomorSurah) {
    return bookmarkedSurahNumbers.contains(nomorSurah);
  }
}
