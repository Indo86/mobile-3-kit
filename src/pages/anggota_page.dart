import 'package:flutter/material.dart';

class AnggotaPage extends StatelessWidget {
  const AnggotaPage({Key? key}) : super(key: key);

  // Data anggota contoh
  final List<Map<String, String>> anggotaList = const [
    {
'nama': 'Arrafi Nuristiawan', 'nim': '123220141',
      'jurusan': 'Teknik Informatika',
      'image': 'https://via.placeholder.com/150'
    },
    {
'nama': 'Yedhit Trisakti Tamma', 'nim': '123220160',
      'jurusan': 'Teknik Informatika',
      'image': 'https://via.placeholder.com/150'
    },
    {
'nama': 'Deni Norman Zaky', 'nim': '123220165',
      'jurusan': 'Teknik Informatika',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'nama': 'Royan Aditya', 'nim': '123220174', 
      'jurusan': 'Teknik Informatika',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          // Search bar
          Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari anggota...',
                prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          // Anggota list
          Expanded(
            child: ListView.builder(
              itemCount: anggotaList.length,
              itemBuilder: (context, index) {
                final anggota = anggotaList[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Show detail dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Text(anggota['nama']!),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(anggota['image']!),
                                  radius: 50,
                                ),
                                const SizedBox(height: 16),
                                DetailRow(label: 'NIM', value: anggota['nim']!),
                                DetailRow(label: 'Jurusan', value: anggota['jurusan']!),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Tutup'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Hero(
                            tag: anggota['nim']!,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(anggota['image']!),
                              radius: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  anggota['nama']!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'NIM: ${anggota['nim']}',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  anggota['jurusan']!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const DetailRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Text(value),
        ],
      ),
    );
  }
}