import 'package:get/get.dart';
import 'package:sm6aplikasiku/models/surah.dart';
import 'package:sm6aplikasiku/services/surah_service.dart';

class SurahController extends GetxController {
  final SurahService _service = SurahService();

  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final daftarSurah = <Surah>[].obs;
  final filteredSurah = <Surah>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSurah();
  }

  Future<void> fetchSurah() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _service.fetchDaftarSurah();
      daftarSurah.assignAll(data);
      filteredSurah.assignAll(data);
    } on Exception catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan tidak terduga: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    try {
      if (query.isEmpty) {
        filteredSurah.assignAll(daftarSurah);
        return;
      }
      filteredSurah.assignAll(
        daftarSurah.where(
          (s) =>
              s.namaLatin.toLowerCase().contains(query.toLowerCase()) ||
              s.nomor.toString().contains(query),
        ),
      );
    } catch (e) {
      // Pencarian gagal, tampilkan semua
      filteredSurah.assignAll(daftarSurah);
    }
  }
}
