import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final int score;
  const SummaryPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange, 
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white), 
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: Container(
        color: Colors.orange, 
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 220, 
                    height: 220, 
                    child: CircularProgressIndicator(
                      value: score / 16,
                      strokeWidth: 28,
                      strokeCap: StrokeCap.round,
                      backgroundColor: Colors.white, 
                      valueColor: AlwaysStoppedAnimation<Color>(
                        const Color.fromARGB(255, 129, 198, 255),
                      ), 
                    ),
                  ),
                  Text(
                    "$score",
                    style: TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, 
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(109, 72, 255, 1), 
                ),
                onPressed: () {
                  // Add your button action here
                },
                child: Text(
                  "Well Done",
                  style: TextStyle(fontSize: 40, color: Colors.white), 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}