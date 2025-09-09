import 'package:flutter/material.dart';

class ThankYouScreen extends StatelessWidget {
  final String amount;

  ThankYouScreen({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thank You'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Thank you for your contribution!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text('Your generous donation of $amount has been successfully processed.'),
            SizedBox(height: 20),
            Text('Contribution Type: Donation'),
            Text('Transaction ID: 9876543210'), // Sample transaction ID
            Text('Date: ${DateTime.now().toLocal().toString().split(' ')[0]}'), // Current date
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}