import 'package:flutter/material.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _faqData = [
    {"question": "What is Flutter?", "answer": "Flutter is an open-source UI toolkit created by Google."},
    {"question": "How do I install Flutter?", "answer": "You can install Flutter from the official website: https://flutter.dev"},
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
