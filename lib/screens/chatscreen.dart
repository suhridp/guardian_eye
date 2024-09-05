import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _faqData = [
    {"question": "What is GuardianEye", "answer": "GuardianEye is an app designed to help women choose safer routes based on previous incident data and real-time updates."},
    {"question": "How to use", "answer": "First you need to click on the walk with me option and then enter your current location and destination and then it will show you whether your path is secure or not."},
    {"question": "How does it work", "answer": "The app uses machine learning to analyze CCTV footage, identifying potential threats based on crowd composition, environmental conditions, and past safety incidents in an area. The app suggests alternate routes to avoid dangerous zones."},
    {"question": "Is my location and personal data safe", "answer": "Yes, GuardianEye prioritizes user privacy and security. We only use your location to provide real-time route suggestions and safety alerts."},
    {"question": "Can men also use GuardianEye", "answer": "Absolutely! Although GuardianEye is designed with a focus on women's safety, anyone concerned about their safety can use the app to choose secure routes and receive real-time alerts about potentially dangerous areas."},
    {"question": "How does the app determine if an area is dangerous", "answer": "The app considers multiple factors, including historical crime data, the ratio of men to women in the area, time of day, environmental conditions, and reports of suspicious activities. Using these factors, the app assigns safety ratings to areas and highlights potential risks."},
    {"question": "What should I do if GuardianEye suggests a dangerous route", "answer": "If GuardianEye identifies a risky area on your route, it will suggest safer alternatives. You can review the recommendations and choose the best path to avoid potentially dangerous zones."},
    {"question": "Does GuardianEye work everywhere", "answer": "GuardianEye works in areas where it has access to data from local authorities and CCTV footage. We are continuously expanding our coverage to more cities and regions. You can check the app to see if it is available in your area."},
    {"question": "How does GuardianEye use machine learning to improve safety", "answer": "The app's machine learning model learns from historical data, live CCTV footage, and user inputs to identify patterns that indicate potential danger. Over time, as more data is gathered, the model becomes more accurate in predicting unsafe areas and situations."},
    {"question": "How is the safety data in GuardianEye kept up to date", "answer": "GuardianEye updates data continuously by integrating incident reports from local authorities and analyzing live CCTV footage. The app combines these data sources to provide users with real-time updates on potentially dangerous areas."},
    {"question": "How does it detect threats in real time", "answer": "The app uses an advanced machine learning algorithm to analyze live footage from CCTV cameras. It detects potential threats by examining various factors, such as the ratio of men to women, crowd behavior, and environmental conditions. If the algorithm identifies a risky situation, it marks the area as dangerous, and users are notified in real time."}
    // Add more FAQs here
  ];
  final List<Map<String, String>> _messages = [];

  void _handleSubmitted(String text) {
    if (text.isEmpty) return;
    setState(() {
      _messages.add({"user": text});
      _controller.clear();
    });

    String answer = _findAnswer(text);
    if (answer.isNotEmpty) {
      setState(() {
        _messages.add({"bot": answer});
      });
    }
  }

  String _findAnswer(String question) {
    for (var faq in _faqData) {
      if (faq["question"]!.toLowerCase() == question.toLowerCase()) {
        return faq["answer"]!;
      }
    }
    return "Sorry, I don't understand the question.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ Chatbot'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.containsKey("user") ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: message.containsKey("user") ? Colors.blue : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        message.containsKey("user") ? message["user"]! : message["bot"]!,
                        style: TextStyle(color: message.containsKey("user") ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Ask a question...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
