import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    title: "Guessit",
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: const FlashcardPage(),
    ),
  ));
}

// Flashcard Data Model
class Flashcard {
  final String question;
  final String answer;
  Flashcard({required this.question, required this.answer});
}

// Helper function to get default flashcards
List<Flashcard> getFlashcards() {
  return [
    Flashcard(question: "Aorta", answer: "เป็นหลอดเลือดที่นำเลือดแดงไปเลี้ยngอวัยวะสำคัญต่าง ๆ ในร่างกาย"),
    Flashcard(question: "W", answer: "4"),
    Flashcard(question: "Wh", answer: "Leonardo da Vinci"),
    Flashcard(question: "j", answer: "Jupiter"),
    Flashcard(question: "Wh", answer: "Au"),
  ];
}

class FlashcardPage extends StatefulWidget {
  final List<Flashcard>? flashcards;
  const FlashcardPage({super.key, this.flashcards});

  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  List<Flashcard> _flashcards = [];
  int _currentIndex = 0;
  int _score = 0;
  int _remainingTime = 300; // 5 minutes in seconds
  Timer? _timer;

  // Initialize flashcards and start timer
  @override
  void initState() {
    super.initState();
    _initializeFlashcards();
    _startTimer();
  }

  // Dispose timer when widget is removed from tree
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Initialize flashcards (use default if none provided)
  void _initializeFlashcards() {
    if (widget.flashcards != null && widget.flashcards!.isNotEmpty) {
      _flashcards = widget.flashcards!;
    } else {
      _flashcards = getFlashcards();
    }
  }

  // Start the countdown timer
  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });
      if (_remainingTime <= 0) {
        _timer?.cancel();
        _navigateToSummaryPage();
      }
    });
  }

  // Navigate to Summary Page
  void _navigateToSummaryPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(score: _score),
      ),
    );
  }

  // Move to the next flashcard
  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _flashcards.length;
    });
  }

  // Skip the current flashcard
  void _skipWord() {
    _nextCard();
  }

  // Proceed to the next flashcard after marking it as correct
  void _proceedWord() {
    setState(() {
      _score++;
      _nextCard();
    });
  }

  // Show hint dialog with the answer
  void _showHint() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hint"),
          content: Text(_flashcards[_currentIndex].answer),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  // Format remaining time as MM:SS
  String _formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    if (_flashcards.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text(
            'No flashcards available.',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Colors.yellow[600],
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer yellow background
              Container(
                width: 350,
                height: 800,
                decoration: BoxDecoration(
                  color: Colors.yellow[600],
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              // Inner orange card
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                         IconButton(
                          icon: Icon(Icons.skip_next, color: Colors.white, size: 50),
                          onPressed: _skipWord,),
                          Transform.rotate(
                            angle: 90 * 3.14159 / 180, // Rotate 90 degrees clockwise
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 100),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Center(
                              child: Text(
                                _flashcards[_currentIndex].question,
                                style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                                  SizedBox(height: 10),
                                  LinearProgressIndicator(
                                    value: _remainingTime / 300,
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.yellow[800]!,
                                    ),
                                    minHeight: 10,
                                  ),
                                  Text(
                                    _formatTime(_remainingTime),
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                         IconButton(
                        icon: Icon(Icons.check, color: Colors.white, size: 50),
                        onPressed: _proceedWord,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Arrow at top-right
              Positioned(
                top: 28,
                right: 28,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Quit the Game?"),
                          content: Text("Are you sure you want to quit the game?"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text("Resume Game"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.pop(context); // Exit the FlashcardPage
                              },
                              child: Text("Quit"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
              // Lightbulb at bottom-right
              Positioned(
                bottom: 28,
                right: 28,
                child: Transform.rotate(
                  angle: 90 * 3.14159 / 180, // 90 degrees in radians
                  child: IconButton(
                    icon: Icon(
                      Icons.lightbulb,
                      color: Colors.yellow[100],
                      size: 55,
                    ),
                    onPressed: _showHint,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Summary Page to display the score
class SummaryPage extends StatelessWidget {
  final int score;
  const SummaryPage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back arrow icon
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Overall Score:",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              "$score",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}