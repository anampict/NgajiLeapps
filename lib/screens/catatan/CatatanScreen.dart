import 'package:flutter/material.dart';

class Catatanscreen extends StatefulWidget {
  const Catatanscreen({super.key});

  @override
  State<Catatanscreen> createState() => _CatatanscreenState();
}

class _CatatanscreenState extends State<Catatanscreen> {
  List<TargetHarian> targets = [
    TargetHarian(
      id: 1,
      title: 'Baca 1 Lembat Al-Quran',
      subtitle: 'SELESAI • 06:10 WIB',
      isCompleted: true,
    ),
    TargetHarian(
      id: 2,
      title: 'Sholat Dhuha',
      subtitle: 'SUNNAH • 4 RAKAAT',
      isCompleted: false,
    ),
    TargetHarian(
      id: 3,
      title: 'Dzikir Pagi',
      subtitle: 'RUTINITAS HARIAN',
      isCompleted: false,
    ),
    TargetHarian(
      id: 4,
      title: 'Murottal 15 Menit',
      subtitle: 'TARGET PENDENGARAN',
      isCompleted: false,
    ),
  ];

  void _toggleTarget(int index) {
    setState(() {
      targets[index].isCompleted = !targets[index].isCompleted;
      if (targets[index].isCompleted) {
        final now = DateTime.now();
        targets[index].completedTime =
            '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WIB';
      } else {
        targets[index].completedTime = null;
      }
    });
  }

  void _addNewTarget() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Tambah Target Baru'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Nama Target',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: 'Deskripsi',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Target baru ditambahkan')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1CC95F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 245, 243, 243),
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                color: Colors.black,
                iconSize: 25,
              ),
            ),
            const SizedBox(width: 60),
            const Text(
              'Progres & Catatan',
              style: TextStyle(
                fontFamily: 'Primary',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Target Harian",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'Primary',
                    ),
                  ),
                  GestureDetector(
                    onTap: _addNewTarget,
                    child: Row(
                      children: [
                        const Text(
                          '+ ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1CC95F),
                          ),
                        ),
                        const Text(
                          'Tambah',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1CC95F),
                            fontFamily: 'Primary',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: targets.length,
                itemBuilder: (context, index) {
                  final target = targets[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => _toggleTarget(index),
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: target.isCompleted
                                      ? null
                                      : Border.all(
                                          color: Colors.grey.withOpacity(0.3),
                                          width: 2,
                                        ),
                                  color: target.isCompleted
                                      ? const Color(0xFF1CC95F)
                                      : Colors.transparent,
                                ),
                                child: target.isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    target.title,
                                    style: TextStyle(
                                      fontFamily: 'Primary',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                      decoration: target.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    target.isCompleted &&
                                            target.completedTime != null
                                        ? target.completedTime!
                                        : target.subtitle,
                                    style: TextStyle(
                                      fontFamily: 'Primary',
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: target.isCompleted
                                          ? const Color(0xFF1CC95F)
                                          : Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Menu untuk edit/hapus
                              },
                              child: Icon(
                                Icons.more_vert,
                                color: Colors.grey[400],
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      '""',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1CC95F),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '"Sebaik-baik manusia adalah yang paling\nbermanfaat bagi orang lain."',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'HADITS NABI SAW',
                      style: TextStyle(
                        fontFamily: 'Primary',
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class TargetHarian {
  int id;
  String title;
  String subtitle;
  bool isCompleted;
  String? completedTime;

  TargetHarian({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.completedTime,
  });
}
