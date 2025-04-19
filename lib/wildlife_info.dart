import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import HomeScreen to navigate back
import 'login_screen.dart';
class WildlifeInfoScreen extends StatelessWidget {
  const WildlifeInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: const Text("Explore Wildlife"),
        backgroundColor: const Color(0xFF006D77),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('animal').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!"));
          }

          final animalDocs = snapshot.data!.docs;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Popular Wild Animals",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF006D77),
                  ),
                ),
                const SizedBox(height: 12),

                // Build a card for each animal fetched from Firestore
                ...animalDocs.map((doc) {
                  final name = doc['name'];
                  final info = doc['info'];
                  final dangerLevel = doc['dangerLevel'];
                  final imageUrl = doc['imageUrl'];
                  return _animalCard(
                    name: name,
                    imagePath: imageUrl,
                    info: info,
                    dangerLevel: dangerLevel,
                  );
                }).toList(),

                const SizedBox(height: 30),
                const Text(
                  "Did You Know?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF004F53),
                  ),
                ),
                const SizedBox(height: 10),
                _factTile("A tiger’s roar can be heard up to 3 km away."),
                _factTile("Elephants mourn their dead."),
                _factTile("Leopards can leap over 6 meters forward in one jump."),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _animalCard({
    required String name,
    required String imagePath,
    required String info,
    required String dangerLevel,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFFE0F7F6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.network(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.red),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                  width: 80,
                  height: 80,
                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF006D77),
                      )),
                  const SizedBox(height: 6),
                  Text(info,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF004F53),
                      )),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.warning_amber,
                          size: 18, color: Colors.red),
                      const SizedBox(width: 4),
                      Text("Danger: $dangerLevel",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          )),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _factTile(String fact) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(Icons.lightbulb, color: Color(0xFF00AFB9)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              fact,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF023047),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) async {
    // Handle the logout logic here, depending on your app's authentication flow
    // For instance, Firebase sign-out if you are using Firebase for authentication
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()), // Replace with your actual LoginScreen widget
          (route) => false,
    );
  }
}
