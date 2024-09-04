import 'package:flutter/material.dart';
import 'package:guardian_eye/screens/chatscreen.dart';

class FAQChatbotApp extends StatelessWidget {
  const FAQChatbotApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'FAQ Chatbot',
      home: ChatScreen(),
    );
  }
}

