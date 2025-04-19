import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'globals.dart';
import 'no_animal_detection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (isFromDeepLink && globalAnimalName != null) {
        // 🐾 From SMS deep link — go to Home with animal name
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(animalName: globalAnimalName!),
          ),
        );
      } else {
        // 🧘‍♂️ Normal login, no animal detected
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NoAnimalDetection(),

          ),
        );
      }
    } else {
      // 🔐 Not logged in — go to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F4),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFEEF6F6),
          ),
          Positioned(
            top: -30,
            right: -60,
            child: Container(
              width: 360,
              height: 360,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF006D77).withOpacity(0.2),
              ),
              child: ClipOval(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 30),
                      child: Image.asset(
                        'assets/images/tiger.png',
                        fit: BoxFit.cover,
                        width: 340,
                        height: 340,
                      ),
                    ),
                    Container(
                      color: const Color(0xFF006D77).withOpacity(0.3),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 420,
            left: MediaQuery.of(context).size.width / 2 - 120,
            child: Text(
              'WildGuard AI',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w700,
                fontSize: 36,
                color: const Color(0xFF006D77),
                shadows: [
                  Shadow(
                    blurRadius: 4,
                    color: Colors.black26,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 470,
            left: MediaQuery.of(context).size.width / 2 - 170,
            child: SizedBox(
              width: 310,
              child: Text(
                'Protecting Nature, Ensuring Safety',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: const Color(0xFF023047),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
