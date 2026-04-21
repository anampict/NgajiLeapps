import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sm6aplikasiku/models/jadwal_sholat_model.dart';
import 'package:sm6aplikasiku/utils/Constant.dart';

class JadwalSholatService {
  Future<JadwalSholatBulanan> fetchJadwal({
    required int tahun,
    required int bulan,
  }) async {
    final uri = Uri.parse(AppConstant.shalatEndpoint);
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'provinsi': AppConstant.provinsi,
        'kabkota': AppConstant.kabkota,
        'tahun': tahun,
        'bulan': bulan,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json =
          jsonDecode(response.body) as Map<String, dynamic>;
      return JadwalSholatBulanan.fromJson(json);
    } else {
      throw Exception('Gagal mengambil jadwal sholat: ${response.statusCode}');
    }
  }
}
