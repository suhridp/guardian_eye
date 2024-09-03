import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guardian_eye/screens/change_password_page.dart';
import 'package:guardian_eye/screens/notification_settings_page.dart';
import 'package:guardian_eye/screens/settings_page.dart';

import 'screens/home_page.dart';
import 'screens/login_page.dart';
import 'screens/emergency_numbers_page.dart'; // Import the emergency numbers page
import 'screens/walk_with_me_page.dart'; // Import the Walk with Me page
import 'screens/check_safety_page.dart'; // Import the Check Safety page
import 'screens/safety_techniques_page.dart'; // Import the Safety Techniques page

import 'screens/register_page.dart';
import 'screens/blog_page.dart';
import 'screens/edit_profile_page.dart';
import 'screens/new_blog_post.dart';
import 'services/blog_service.dart';
import 'screens/splash_screen.dart'; // Import the splash screen
// import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Initialize Firebase App Check
  // await FirebaseAppCheck.instance.activate(
  //   webRecaptchaSiteKey: 'your-site-key', // Only needed for web
  // );
  runApp(GuardianEyeApp());
}

class GuardianEyeApp extends StatelessWidget {
  final BlogService blogService = BlogService();

  GuardianEyeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuardianEye',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      // Set the splash screen as the initial route
      routes: {
        '/splash': (context) => const SplashScreen(), // Splash screen route
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/blog': (context) => const BlogPage(),
        '/edit-profile': (context) => const EditProfilePage(),
        '/settings': (context) => const SettingsPage(),
        '/change-password': (context) => ChangePasswordPage(),
        '/notification-settings': (context) => const NotificationSettingsPage(),
        '/new-blog-post': (context) =>
            NewBlogPostPage(blogService: blogService),
        '/emergency-numbers': (context) =>
            const EmergencyNumbersPage(), // Emergency Numbers route
        '/walk-with-me': (context) =>
            const WalkWithMePage(), // Walk with Me route
        '/check-safety': (context) =>
            const CheckSafetyPage(), // Check Safety route
        '/safety-techniques': (context) =>
            SafetyTechniquesPage(), // Safety Techniques route
      },
    );
  }
}
