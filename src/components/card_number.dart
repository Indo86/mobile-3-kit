import 'package:flutter/material.dart';

class CardNumbers extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final IconData icon;
  final Color color;
  final String contoh;

  const CardNumbers({
    Key? key,
    required this.judul,
    required this.deskripsi,
    required this.icon,
    required this.color,
    required this.contoh,
  }) : super(key: key);

  @override
  State<CardNumbers> createState() => _CardNumbersState();
}

class _CardNumbersState extends State<CardNumbers> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.color.withAlpha(50),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, size: 30, color: widget.color),
              ),
              title: Text(
                widget.judul,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                widget.deskripsi,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: Icon(
                _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(),
                    const Text(
                      'Contoh:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(widget.contoh),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}