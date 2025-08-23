import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF8E44AD),
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF3E5F5),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 700,
            padding: const EdgeInsets.all(20),
            child: Card(
              color: Colors.white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                 
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/eng.jpg',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),

                  
                    const Text(
                      "Khotchaporn Klaprom",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A148C),
                      ),
                    ),
                    const SizedBox(height: 8),

                    
                    const Text(
                      "Student ID: 650710665",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const Text(
                      "Major: Information Technology",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 16),

        
                    const Text(
                      "ชอบกินส้มตํา นํ้าพริกปลาร้า อาหารอีสาน เป็นคนตลก น่ารักสดใส ใจดี "
                      "รักสัตว์ รักนํ้า รักปลา รักธรรมชาติ รักศิลปากร :)",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Divider(height: 32, thickness: 1),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Contact",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple[900],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                 
                    Row(
                      children: const [
                        Icon(Icons.facebook, color: Colors.blue),
                        SizedBox(width: 8),
                        Text(
                          "facebook: khotchaporn klaprom",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    
                    Row(
                      children: const [
                        Icon(Icons.camera_alt, color: Colors.pink),
                        SizedBox(width: 8),
                        Text(
                          "IG: Khotchx",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
