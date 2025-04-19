import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wildguard/splash_screen.dart';
import 'package:app_links/app_links.dart';
import 'firebase_options.dart';
import 'globals.dart'; // 🧠 Contains globalAnimalName and isFromDeepLink

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

    // ✅ Cold start — when app opened via deep link
    _appLinks.getInitialLink().then(_handleDeepLink);

    // ✅ Warm start — already running app
    _appLinks.uriLinkStream.listen(_handleDeepLink);
  }

  void _handleDeepLink(Uri? uri) {
    if (uri != null && uri.path == "/animal") {
      final animalName = uri.queryParameters["name"] ?? "Unknown";
      globalAnimalName = animalName;
      isFromDeepLink = true;

      debugPrint("🐾 Deep link detected: animal = $animalName");
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
