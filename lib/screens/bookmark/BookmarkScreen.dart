import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sm6aplikasiku/controller/BookmarkController.dart';
import 'package:sm6aplikasiku/models/bookmark_model.dart';
import 'package:sm6aplikasiku/routes/app_routes.dart';
import 'package:sm6aplikasiku/models/surah.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookmarkController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Bookmark',
          style: TextStyle(
            fontFamily: 'Primary',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Obx(() {
              final count = controller.bookmarks.length;
              return count > 0
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B9B6C).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '$count Surah',
                        style: const TextStyle(
                          fontFamily: 'Primary',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1B9B6C),
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF1B9B6C)),
          );
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF5252).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.wifi_off_rounded,
                      size: 40,
                      color: Color(0xFFFF5252),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Gagal Memuat Bookmark',
                    style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Primary',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (controller.bookmarks.isEmpty) {
          return _buildEmptyState();
        }

        return _buildBookmarkList(controller);
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFF1B9B6C).withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.bookmark_outline_rounded,
                size: 50,
                color: Color(0xFF1B9B6C),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Belum Ada Bookmark',
              style: TextStyle(
                fontFamily: 'Primary',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tandai surah favorit Anda saat membaca\nagar mudah ditemukan kembali.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Primary',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Colors.grey[500],
                height: 1.6,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              onPressed: () => Get.find<BookmarkController>(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1B9B6C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              icon: const Icon(Icons.menu_book_rounded,
                  color: Colors.white, size: 18),
              label: const Text(
                'Buka Daftar Surah',
                style: TextStyle(
                  fontFamily: 'Primary',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmarkList(BookmarkController controller) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: controller.bookmarks.length,
      itemBuilder: (context, index) {
        final bookmark = controller.bookmarks[index];
        return _buildBookmarkCard(bookmark, controller, index);
      },
    );
  }

  Widget _buildBookmarkCard(
    BookmarkModel bookmark,
    BookmarkController controller,
    int index,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Dismissible(
        key: Key(bookmark.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFF5252),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline_rounded, color: Colors.white, size: 26),
              SizedBox(height: 4),
              Text(
                'Hapus',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Primary',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        confirmDismiss: (direction) async {
          return await Get.dialog<bool>(
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Hapus Bookmark?',
                style: TextStyle(
                  fontFamily: 'Primary',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              content: Text(
                'Hapus "${bookmark.namaLatin}" dari daftar bookmark?',
                style: const TextStyle(
                  fontFamily: 'Primary',
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(result: false),
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontFamily: 'Primary',
                      color: Colors.grey,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Get.back(result: true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5252),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Hapus',
                    style: TextStyle(
                      fontFamily: 'Primary',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          controller.removeBookmark(bookmark.id, bookmark.namaLatin);
        },
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            final surah = Surah(
              nomor: bookmark.nomorSurah,
              namaLatin: bookmark.namaLatin,
              namaArab: bookmark.namaArab,
              jumlahAyat: bookmark.jumlahAyat,
              jenis: bookmark.jenis,
            );
            Get.toNamed(AppRoutes.bacaSurah, arguments: surah);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Nomor Surah dengan border
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1B9B6C), Color(0xFF13EC80)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        bookmark.nomorSurah.toString(),
                        style: const TextStyle(
                          fontFamily: 'Primary',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Info Surah
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bookmark.namaLatin,
                          style: const TextStyle(
                            fontFamily: 'Primary',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${bookmark.jumlahAyat} Ayat • ${bookmark.jenis}',
                          style: TextStyle(
                            fontFamily: 'Primary',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Nama Arab + Icon bookmark
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        bookmark.namaArab,
                        style: const TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B9B6C),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Icon(
                        Icons.bookmark_rounded,
                        color: Color(0xFF1B9B6C),
                        size: 18,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
