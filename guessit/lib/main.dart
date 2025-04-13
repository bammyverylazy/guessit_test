import 'package:flutter/material.dart';
import 'package:guessit/subject.dart';


void main() {
  runApp(MaterialApp(
    title: "Guessit",
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: const Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[200], 
                  image: DecorationImage(
                    image: AssetImage("assets/images/noobyzom.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Title text - GUESSIT
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.2,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    'GUESSIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 74,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              
              // Tagline text
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.151,
                left: 33,
                right: 33,
                child: Center(
                  child: Text(
                    'Turning Passive Learning into Active Engagement',
                    style: TextStyle(
                      color: const Color.fromARGB(221, 16, 10, 4),
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              
              // Sign Up and Log In buttons
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.08,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SIGN UP text button
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up page
                      },
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 15),
                    
                    // LOG IN button
                    SizedBox(
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to login page
                          //ตอนนีเป็น subject ไปก่อน
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Subject()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF5D5FEF), // Purple button
                          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}