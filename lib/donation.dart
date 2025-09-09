import 'package:flutter/material.dart';
import 'give_screen.dart';
//import 'thank_you.dart';

class DonationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giving History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  DonationTile(name: 'Charity Water', date: 'Jan 12, 2024', amount: '\$50'),
                  DonationTile(name: 'Red Cross', date: 'Dec 20, 2023', amount: '\$100'),
                  DonationTile(name: 'Doctors Without Borders', date: 'Nov 15, 2023', amount: '\$0'),
                  SizedBox(height: 20),
                  Text('Recurring Donations', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  RecurringDonationTile(name: 'Save the Children', amount: '\$25', frequency: 'Monthly'),
                  RecurringDonationTile(name: 'Habitat for Humanity', amount: '\$50', frequency: 'Quarterly'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GiveScreen()),
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

class DonationTile extends StatelessWidget {
  final String name;
  final String date;
  final String amount;

  DonationTile({required this.name, required this.date, required this.amount});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(date),
      trailing: Text(amount),
    );
  }
}

class RecurringDonationTile extends StatelessWidget {
  final String name;
  final String amount;
  final String frequency;

  RecurringDonationTile({required this.name, required this.amount, required this.frequency});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(frequency),
      trailing: Text(amount),
    );
  }
}