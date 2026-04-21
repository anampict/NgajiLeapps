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
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final data = await _service.fetchDaftarSurah();
      daftarSurah.assignAll(data);
      filteredSurah.assignAll(data);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredSurah.assignAll(daftarSurah);
    } else {
      filteredSurah.assignAll(
        daftarSurah.where(
          (s) =>
              s.namaLatin.toLowerCase().contains(query.toLowerCase()) ||
              s.nomor.toString().contains(query),
        ),
      );
    }
  }
}
