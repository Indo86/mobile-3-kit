import 'package:flutter/material.dart';
import 'dart:async';
import '../components/card_number.dart'; 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Status for number generation
  bool isGenerating = false;
  String currentNumberType = '';
  List<String> generatedNumbers = [];
  Timer? numberGeneratorTimer;
  int currentNumber = 0;
  double currentDecimal = 0.0;
  int primeCheckNumber = 2;

  // Daftar jenis bilangan beserta deskripsinya
  final List<Map<String, dynamic>> jenisBilangan = const [
    {
      'judul': 'Bilangan Prima',
      'deskripsi': 'Bilangan yang hanya memiliki dua faktor, 1 dan dirinya sendiri.',
      'icon': Icons.filter_1,
      'color': Colors.red,
      'contoh': '2, 3, 5, 7, 11, 13, 17, 19, 23, ...',
    },
    {
      'judul': 'Bilangan Desimal',
      'deskripsi': 'Bilangan yang memiliki angka setelah koma.',
      'icon': Icons.filter_2,
      'color': Colors.blue,
      'contoh': '0.5, 3.14, 2.718, 1.618, ...',
    },
    {
      'judul': 'Bilangan Bulat',
      'deskripsi': 'Bilangan bulat non-negatif dan negatif.',
      'icon': Icons.filter_3,
      'color': Colors.green,
      'contoh': '..., -3, -2, -1, 0, 1, 2, 3, ...',
    },
    {
      'judul': 'Bilangan Cacah',
      'deskripsi': 'Bilangan bulat non-negatif (0, 1, 2, ...).',
      'icon': Icons.filter_4,
      'color': Colors.orange,
      'contoh': '0, 1, 2, 3, 4, 5, ...',
    },
  ];

  @override
  void dispose() {
    stopNumberGeneration();
    super.dispose();
  }

  // Function to check if a number is prime
  bool isPrime(int number) {
    if (number <= 1) return false;
    if (number <= 3) return true;
    if (number % 2 == 0 || number % 3 == 0) return false;
    
    int i = 5;
    while (i * i <= number) {
      if (number % i == 0 || number % (i + 2) == 0) return false;
      i += 6;
    }
    return true;
  }

  // Generate the next prime number
  int getNextPrime() {
    while (!isPrime(primeCheckNumber)) {
      primeCheckNumber++;
    }
    int result = primeCheckNumber;
    primeCheckNumber++;
    return result;
  }

  // Start number generation based on type
void startNumberGeneration(String type) {
  if (isGenerating) {
    // Show error dialog if already generating
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Peringatan'),
          content: const Text(
              'Silakan hentikan generasi angka saat ini sebelum memulai yang baru.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
    return;
  }

  setState(() {
    isGenerating = true;
    currentNumberType = type;
    generatedNumbers.clear();
    
    // Add infinity symbol as the first element for Bulat and Desimal
    if (type == 'Bulat') {
      generatedNumbers.add('−∞');  // Negative infinity symbol
    } else if (type == 'Desimal') {
      generatedNumbers.add('−∞');  // Negative infinity symbol for decimals too
    }
    
    // Reset counters based on type
    switch(type) {
      case 'Prima':
        primeCheckNumber = 2;
        break;
      case 'Desimal':
        currentDecimal = -5.0;  // Start with negative decimal
        break;
      case 'Bulat':
        currentNumber = -10;  // Start with negative numbers
        break;
      case 'Cacah':
        currentNumber = 0;
        break;
    }
  });

  // Add delay before starting the real sequence (to give time to see the infinity symbol)
  Future.delayed(const Duration(milliseconds: 1000), () {
    // Only start if we're still generating (user might have pressed stop)
    if (isGenerating) {
      // Start timer to generate numbers
      numberGeneratorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
        setState(() {
          switch(type) {
            case 'Prima':
              generatedNumbers.add(getNextPrime().toString());
              break;
            case 'Desimal':
              generatedNumbers.add(currentDecimal.toStringAsFixed(1));
              currentDecimal += 0.5;
              break;
            case 'Bulat':
              generatedNumbers.add(currentNumber.toString());
              currentNumber++;

              break;
            case 'Cacah':
              generatedNumbers.add(currentNumber.toString());
              currentNumber++;
              
              break;
          }
          
          // Limit displayed numbers to prevent memory issues
          if (generatedNumbers.length > 100) {
            generatedNumbers.removeAt(0);
          }
        });
      });
    }
  });
}

  // Stop number generation
  void stopNumberGeneration() {
    numberGeneratorTimer?.cancel();
    setState(() {
      isGenerating = false;
      currentNumberType = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Number Generator Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),   
              child: Text(
                'Generator Bilangan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ),
          
          // Number Generator Controls with improved symmetry
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('Prima', Colors.red),
                    const SizedBox(width: 16),
                    _buildNumberButton('Desimal', Colors.blue),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildNumberButton('Bulat', Colors.green),
                    const SizedBox(width: 16),
                    _buildNumberButton('Cacah', Colors.orange),
                  ],
                ),
                
                // Stop button (only shown when generating)
                if (isGenerating) 
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton.icon(
                      onPressed: stopNumberGeneration,
                      icon: const Icon(Icons.stop_circle, color: Colors.white),
                      label: const Text('Berhenti', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Number Display Box - centered
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Container(
                height: 150,
                width: double.infinity, // Full width for better appearance
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(15),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        isGenerating 
                            ? 'Menampilkan Bilangan $currentNumberType:' 
                            : 'Tekan tombol untuk menampilkan bilangan',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: 8,
                          runSpacing: 8,
                          children: generatedNumbers.map((number) => 
                            Chip(
                              label: Text(number),
                              backgroundColor: _getColorForNumberType(currentNumberType),
                              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                            )
                          ).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Section Title for Theory
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12.0),
            child: Text(
              'Teori Bilangan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          
          // Theory Cards in Expandable List
          Expanded(
            child: ListView.builder(
              itemCount: jenisBilangan.length,
              itemBuilder: (context, index) {
                final item = jenisBilangan[index];
                return CardNumbers(
                  judul: item['judul'],
                  deskripsi: item['deskripsi'],
                  icon: item['icon'],
                  color: item['color'],
                  contoh: item['contoh'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build uniform number generator buttons
  Widget _buildNumberButton(String type, Color color) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: isGenerating ? null : () => startNumberGeneration(type),
        icon: Icon(
          _getIconForType(type),
          color: isGenerating ? Colors.grey : Colors.white,
        ),
        label: Text(
          'Bilangan $type',
          style: TextStyle(color: isGenerating ? Colors.grey : Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isGenerating ? color.withAlpha(100) : color,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
  
  // Helper method to get icon for each number type
  IconData _getIconForType(String type) {
    switch(type) {
      case 'Prima':
        return Icons.filter_1;
      case 'Desimal':
        return Icons.filter_2;
      case 'Bulat':
        return Icons.filter_3;
      case 'Cacah':
        return Icons.filter_4;
      default:
        return Icons.numbers;
    }
  }
  
  Color _getColorForNumberType(String type) {
    switch(type) {
      case 'Prima':
        return Colors.red.withAlpha(50);
      case 'Desimal':
        return Colors.blue.withAlpha(50);
      case 'Bulat':
        return Colors.green.withAlpha(50);
      case 'Cacah':
        return Colors.orange.withAlpha(50);
      default:
        return Colors.grey.withAlpha(50);
    }
  }
}