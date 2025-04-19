import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Bilangan',
              tooltip: 'Halaman Utama',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Anggota',
              tooltip: 'Daftar Anggota',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_outline),
              label: 'Bantuan',
              tooltip: 'Bantuan',
            ),
          ],
          elevation: 10,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}