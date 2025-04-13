import 'package:flutter/material.dart';
import 'topic.dart'; // Import the TopicPage class

void main() {
  runApp(MaterialApp(
    title: "Subject Page",
    debugShowCheckedModeBanner: false,
    home: Subject(),
  ));
}

class Subject extends StatelessWidget {
  const Subject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Hinted search text', style: TextStyle(color: Color.fromARGB(255, 116, 116, 116))),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 20,
          children: [
            SubjectItem(
              imageProvider: AssetImage('assets/images/bioicon.png'),
              title: 'BIOLOGY',
              progress: 1.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TopicPage()),
                );
              },
            ),
            SubjectItem(
              imageProvider: NetworkImage('https://cdn-icons-png.flaticon.com/512/5205/5205156.png'),
              title: 'CHEMISTRY',
              progress: 0.75,
              onPressed: () {},
            ),
            SubjectItem(
              imageProvider: NetworkImage('https://cdn-icons-png.flaticon.com/512/197/197452.png'),
              title: 'THAI',
              progress: 0.3,
              onPressed: () {},
            ),
            SubjectItem(
              imageProvider: NetworkImage('https://cdn-icons-png.flaticon.com/512/197/197374.png'),
              title: 'ENGLISH',
              progress: 0.0,
              onPressed: () {},
            ),
            SubjectItem(
              imageProvider: NetworkImage('https://cdn-icons-png.flaticon.com/512/814/814513.png'),
              title: 'GEOGRAPHY',
              progress: 0.75,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SubjectItem extends StatelessWidget {
  final ImageProvider imageProvider;
  final String title;
  final double progress;
  final VoidCallback onPressed;

  const SubjectItem({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.progress,
    required this.onPressed,
  });

  int getStarCount() {
    if (progress >= 1.0) return 3;
    if (progress >= 0.75) return 2;
    if (progress >= 0.3) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int stars = getStarCount();

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((Colors.grey.a * 0.5).round()),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 132,
              height: 132,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Progress Circle
                  SizedBox(
                    width: 108.5,
                    height: 108.5,
                    child: CircularProgressIndicator(
                      value: progress,
                          strokeCap: StrokeCap.round, 
                      strokeWidth: 14, // Reduced stroke width for a thinner progress circle
                      backgroundColor: Color.fromARGB(255, 220, 220, 220), // Semi-transparent background
                      valueColor: AlwaysStoppedAnimation<Color>(const Color.fromARGB(255, 255, 220, 116)),
                    ),
                  ),

                  // Circular Background
                  ClipOval(
                    child: Container(
                      width: 94,
                      height: 94,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withAlpha((Colors.grey.a * 0.5).round()),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 47,
                        backgroundImage: imageProvider,
                      ),
                    ),
                  ),

                  // Star Rating
                  Positioned(
                    bottom: -4.5, // Adjusted to align stars precisely
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Icon(
                            Icons.star_rounded,
                            size: 33,
                            color: index < stars ? Colors.amber : const Color.fromARGB(255, 68, 68, 68),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Subject Title
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}