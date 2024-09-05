import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'At GuardianEye, our mission is to provide seamless and intuitive digital experiences '
              'through innovative mobile applications that enrich the lives of our users.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Text(
              'Our Team',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We are a team of passionate developers, designers, and product managers '
              'dedicated to creating high-quality mobile applications. Our goal is to deliver '
              'excellent user experiences and continuous innovation.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
