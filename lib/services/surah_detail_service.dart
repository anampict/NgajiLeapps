import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm6aplikasiku/models/surah_detail_model.dart';
import 'package:sm6aplikasiku/utils/Constant.dart';

class SurahDetailService {
  Future<SurahDetail> fetchDetail(int nomor) async {
    try {
      final uri = Uri.parse('${AppConstant.surahEndpoint}/$nomor');
      final response = await http.get(uri).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Koneksi timeout, coba lagi'),
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> json =
              jsonDecode(response.body) as Map<String, dynamic>;
          return SurahDetail.fromJson(json);
        } catch (e) {
          throw Exception('Gagal memparse detail surah: $e');
        }
      } else {
        throw Exception(
            'Server merespons dengan status ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception('Gagal mengambil detail surah: $e');
    }
  }
}
