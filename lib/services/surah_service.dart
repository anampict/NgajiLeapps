import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm6aplikasiku/models/surah.dart';
import 'package:sm6aplikasiku/utils/Constant.dart';

class SurahService {
  Future<List<Surah>> fetchDaftarSurah() async {
    final uri = Uri.parse(AppConstant.surahEndpoint);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      final List<dynamic> data = json['data'] as List<dynamic>;
      return data
          .map((e) => Surah.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Gagal mengambil daftar surah: ${response.statusCode}');
    }
  }
}
