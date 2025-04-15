import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wildguard/splash_screen.dart';
import 'package:wildguard/home_screen.dart';
import 'package:wildguard/login_screen.dart';
import 'package:app_links/app_links.dart';
import 'firebase_options.dart';
import 'globals.dart'; // import it
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();

  @override
  void initState() {
    super.initState();

    // Cold start (e.g., app opened from SMS link when closed)
    _appLinks.getInitialLink().then(_handleDeepLink);

    // Warm start (app already running)
    _appLinks.uriLinkStream.listen(_handleDeepLink);
  }

  void _handleDeepLink(Uri? uri) {
    if (uri != null && uri.path == "/animal") {
      final animalName = uri.queryParameters["name"] ?? "Unknown";
      globalAnimalName = animalName;

      debugPrint("🐾 Deep link detected: animal = $animalName");
      // Do not navigate to HomeScreen here — wait for login screen to handle it!
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WildGuard AI',
      theme: ThemeData(primarySwatch: Colors.teal),
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
