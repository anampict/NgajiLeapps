import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm6aplikasiku/models/surah.dart';
import 'package:sm6aplikasiku/utils/Constant.dart';

class SurahService {
  Future<List<Surah>> fetchDaftarSurah() async {
    try {
      final uri = Uri.parse(AppConstant.surahEndpoint);
      final response = await http.get(uri).timeout(
        const Duration(seconds: 15),
        onTimeout: () => throw Exception('Koneksi timeout, coba lagi'),
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> json =
              jsonDecode(response.body) as Map<String, dynamic>;
          final List<dynamic> data = json['data'] as List<dynamic>;
          return data
              .map((e) => Surah.fromJson(e as Map<String, dynamic>))
              .toList();
        } catch (e) {
          throw Exception('Gagal memparse data surah: $e');
        }
      } else {
        throw Exception(
            'Server merespons dengan status ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception('Gagal mengambil daftar surah: $e');
    }
  }
}
