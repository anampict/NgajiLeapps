import 'package:get/get.dart';
import 'package:sm6aplikasiku/models/surah.dart';
import 'package:sm6aplikasiku/models/surah_detail_model.dart';
import 'package:sm6aplikasiku/services/surah_detail_service.dart';

class SurahDetailController extends GetxController {
  final SurahDetailService _service = SurahDetailService();

  final isLoading = true.obs;
  final errorMessage = ''.obs;
  final surahDetail = Rxn<SurahDetail>();

  late final Surah surah;

  // function utama untuk mengambil data detail surah berdasarkan nomor surah yang diterima dari halaman sebelumnya
  @override
  void onInit() {
    super.onInit();
    try {
      surah = Get.arguments as Surah;
      fetchDetail();
    } catch (e) {
      errorMessage.value = 'Gagal memuat argumen surah: $e';
      isLoading.value = false;
    }
  }

  Future<void> fetchDetail() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final data = await _service.fetchDetail(surah.nomor);
      surahDetail.value = data;
    } on Exception catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan pada fetchDetail: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
