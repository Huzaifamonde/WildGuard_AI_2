import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'wildlife_info.dart';
import 'globals.dart';
class NoAnimalDetection extends StatelessWidget {
  const NoAnimalDetection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFFAF5),
      body: SafeArea(
        child: Stack(
          children: [
            // 🍃 Background animated overlay
            Positioned.fill(
              child: Lottie.asset(
                'assets/animations/background.json',
                fit: BoxFit.cover,
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 🦋 Calm floating animation
                    Lottie.asset(
                      'assets/animations/calm.json',
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 20),

                    // 🌟 Glowing text
                    Text(
                      "You're All Clear!",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006D77),
                        shadows: [
                          Shadow(
                            blurRadius: 3,
                            color: Color(0xFF006D77),
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),

                    const Text(
                      "No animal activity detected around you.\nRoam freely and stay safe!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF004F53),
                      ),
                    ),
                    const SizedBox(height: 30),

                    ElevatedButton.icon(
                      onPressed: () {

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>WildlifeInfoScreen() ),
                          );
                      },
                      icon: const Icon(Icons.spa_rounded),
                      label: const Text("Explore Wildlife Info"),
                      style: ElevatedButton.styleFrom(

                        backgroundColor: const Color(0xFF00AFB9),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),

                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
