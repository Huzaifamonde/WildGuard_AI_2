import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lottie/lottie.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  final String animalName;

  const HomeScreen({super.key, required this.animalName});

  void _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayName = animalName.isNotEmpty ? animalName : "Wild Animal";

    return Scaffold(
     // backgroundColor: const Color(0xFFEEF6F6),
      backgroundColor: const Color(0xFFF0F4F4),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF006D77),
              ),
              child: Center(
                child: Text(
                  'WildGuard Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Color(0xFF006D77)),
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF006D77),
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text("WildGuard AI"),
        backgroundColor: const Color(0xFF006D77),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child:Image.asset(
                'assets/gifs/gifgreen.gif',
                width: 200,
                height: 180,
                fit: BoxFit.contain,
              )
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                displayName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006D77),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Center(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       _buildInfoColumn("00 KM", "Distance"),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFD6EFED),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "⚠️ The $displayName is away from you. Stay alert and stay safe!",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF004F53),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "🛡️ Safety Measures",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF006D77),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSafetyTip("Keep a safe distance."),
                _buildSafetyTip("Do not feed the animal."),
                _buildSafetyTip("Avoid sudden movements."),
                _buildSafetyTip("Stay calm and avoid eye contact."),
                _buildSafetyTip("If threatened, back away slowly."),
              ],
            ),

          ],
        ),
      ),
    );
  }

  static Widget _buildInfoColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF006D77),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF4A4A4A),
          ),
        ),
      ],
    );
  }

  static Widget _buildSafetyTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF006D77)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              tip,
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF333333),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
