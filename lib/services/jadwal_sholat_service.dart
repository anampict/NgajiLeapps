import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm6aplikasiku/models/jadwal_sholat_model.dart';
import 'package:sm6aplikasiku/utils/Constant.dart';

class JadwalSholatService {
  Future<JadwalSholatBulanan> fetchJadwal({
    required int tahun,
    required int bulan,
  }) async {
    try {
      final uri = Uri.parse(AppConstant.shalatEndpoint);
      final response = await http
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'provinsi': AppConstant.provinsi,
              'kabkota': AppConstant.kabkota,
              'tahun': tahun,
              'bulan': bulan,
            }),
          )
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () => throw Exception('Koneksi timeout, coba lagi'),
          );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> json =
              jsonDecode(response.body) as Map<String, dynamic>;
          return JadwalSholatBulanan.fromJson(json);
        } catch (e) {
          throw Exception('Gagal memparse data jadwal sholat: $e');
        }
      } else {
        throw Exception(
            'Server merespons dengan status ${response.statusCode}');
      }
    } on Exception {
      rethrow;
    } catch (e) {
      throw Exception('Gagal mengambil jadwal sholat: $e');
    }
  }
}
