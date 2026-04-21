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

  @override
  void onInit() {
    super.onInit();
    surah = Get.arguments as Surah;
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final data = await _service.fetchDetail(surah.nomor);
      surahDetail.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
