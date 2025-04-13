import 'package:flutter/material.dart';
import 'package:guessit/flashcard.dart';

void main() {
  runApp(MaterialApp(
    title: "Guessit",
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: const TopicPage(),
    ),
  ));
}

class TopicPage extends StatelessWidget {
  const TopicPage({super.key});

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
        title: Text(
          'Hinted search text',
          style: TextStyle(color: Color.fromARGB(255, 116, 116, 116)),
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Topic Cards
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 1, // Number of topic cards
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Colors.grey.shade400, // Black outline
                        width: 1, // Outline width
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              'https://cdn.mos.cms.futurecdn.net/DxhwcnJpwLPUW7izf6uYVa-800-80.jpg',
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16),

                          // Title
                          Text(
                            'CIRCULATORY SYSTEM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),

                          // Description
                          Text(
                            'The circulatory system, also known as the cardiovascular system, is a network of organs, including the heart and blood vessels, that transports blood, oxygen, nutrients, and hormones throughout the body, while also removing waste products. ',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 16),
                          // Play Button
                          OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FlashcardPage(),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[300], // Gray background
                              foregroundColor: Colors.black, // Black text
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                              ),
                              side: BorderSide(
                                color: Colors.grey[500]!, // Thin gray outline
                                width: 1.0, // Thin border width
                              ),
                            ),
                            child: Text('PLAY'),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}