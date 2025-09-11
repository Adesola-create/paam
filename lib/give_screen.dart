import 'package:flutter/material.dart';
import 'thank_you.dart';

class GiveScreen extends StatefulWidget {
  @override
  _GiveScreenState createState() => _GiveScreenState();
}

class _GiveScreenState extends State<GiveScreen> {
  String frequency = 'Select frequency';
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Give &\nSupport",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Support our mission and community through your generous giving. Choose to give once, regularly, or contribute to specific campaigns that make a difference.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Text('Give once', style: TextStyle(fontSize: 18)),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: '\$0',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Text('Give regularly', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: frequency == 'Select frequency' ? null : frequency,
              items: <String>['Weekly', 'Bi-weekly', 'Monthly'].map((
                String value,
              ) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  frequency = value!;
                });
              },
              hint: Text('Select frequency'),
            ),
            SizedBox(height: 20),
            Text('Give to a campaign', style: TextStyle(fontSize: 18)),
            ListTile(
              title: const Text('Water for All'),
              subtitle: const Text(
                'Support our mission to provide clean water',
              ),
              leading: Image.asset(
                'assets/slide2.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // Add functionality for giving
                String amount = amountController.text;
                // Navigate to Thank You screen after donation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThankYouScreen(amount: amount),
                  ),
                );
              },
              child: Text('Give'),
            ),
          ],
        ),
      ),
    );
  }
}
