import 'package:flutter/material.dart';
import 'widget_maps.dart';
import 'widget_tracking_lbs.dart';

class BantuanPage extends StatelessWidget {
  const BantuanPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> faqList = const [
    {
      'question': 'Apa fungsi aplikasi ini?',
      'answer': 'Aplikasi ini berfungsi untuk menampilkan informasi tentang jenis-jenis bilangan dalam matematika dan daftar anggota kelompok.',
    },
    {
      'question': 'Bagaimana cara menggunakan aplikasi?',
      'answer': 'Gunakan menu navigasi di bagian bawah untuk berpindah antar halaman. Terdapat tiga halaman utama: Bilangan, Anggota, dan Bantuan.',
    },
    {
      'question': 'Apakah informasi dapat diperbarui?',
      'answer': 'Saat ini aplikasi masih dalam tahap pengembangan. Untuk pembaruan informasi, silakan hubungi administrator.',
    },
    {
      'question': 'Bagaimana jika saya menemukan kesalahan?',
      'answer': 'Jika Anda menemukan kesalahan atau bug, silakan laporkan kepada administrator melalui kontak yang tersedia di bawah halaman ini.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Text(
            'Pusat Bantuan',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Temukan jawaban atas pertanyaan umum tentang aplikasi ini.',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          
          // FAQ section
          Expanded(
            child: ListView.builder(
              itemCount: faqList.length,
              itemBuilder: (context, index) {
                final faq = faqList[index];
                return FaqItem(
                  question: faq['question'],
                  answer: faq['answer'],
                );
              },
            ),
          ),
          
          // --- Tombol untuk membuka TrackingPage ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.my_location),
                label: Text('Tracking Lokasi'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TrackingPage()),
                  );
                },
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.map),
                label: Text('Lihat Peta'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MapLibrePage()),
                  );
                },
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Contact section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.support_agent,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Butuh bantuan lebih lanjut?',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Hubungi admin kami di support@example.com',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  State<FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        trailing: Icon(
          _isExpanded ? Icons.remove : Icons.add,
          color: Theme.of(context).colorScheme.primary,
        ),
        onExpansionChanged: (expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              widget.answer,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}