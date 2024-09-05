import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('User Eligibility'),
            subtitle: const Text('The app is intended for individuals aged 18 and above. Users must provide accurate personal information during registration.'),
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            subtitle: const Text('User data will be collected and stored securely. Personal information will not be shared with third parties without consent, except as required by law.'),
          ),
          ListTile(
            title: const Text('Emergency Services'),
            subtitle: const Text('The app provides a feature to contact emergency services. Users must ensure that their location services are enabled for accurate assistance.'),
          ),
          ListTile(
            title: const Text('User Conduct'),
            subtitle: const Text('Users are expected to use the app responsibly and not engage in any form of harassment or abuse towards others.'),
          ),
          ListTile(
            title: const Text('Liability Disclaimer'),
            subtitle: const Text('The app developers are not liable for any incidents that occur while using the app. Users are encouraged to take personal safety precautions.'),
          ),
          ListTile(
            title: const Text('Updates and Modifications'),
            subtitle: const Text('The terms and conditions may be updated periodically. Users will be notified of significant changes.'),
          ),
          ListTile(
            title: const Text('Termination of Service'),
            subtitle: const Text('The app reserves the right to suspend or terminate accounts that violate these terms.'),
          ),
        ],
      ),
    );
  }
}