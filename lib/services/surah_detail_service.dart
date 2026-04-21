import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm6aplikasiku/models/surah_detail_model.dart';
import 'package:sm6aplikasiku/utils/Constant.dart';

class SurahDetailService {
  Future<SurahDetail> fetchDetail(int nomor) async {
    final uri = Uri.parse('${AppConstant.surahEndpoint}/$nomor');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return SurahDetail.fromJson(json);
    } else {
      throw Exception('Gagal mengambil detail surah: ${response.statusCode}');
    }
  }
}
