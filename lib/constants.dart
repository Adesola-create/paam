import 'package:flutter/material.dart';

const Color primaryCol = Color.fromARGB(255, 6, 72, 122);
const Color primaryColor = Color(0xFFB8144A);
final Color primaryColorLight = primaryColor.withOpacity(
  0.4,
); // Lighter version

// Define button style
ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: primaryColor,
  foregroundColor: Colors.white,
  minimumSize: const Size(double.infinity, 55),
  padding: const EdgeInsets.symmetric(vertical: 20),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
);
// Define button style
ButtonStyle secondaryButtonStyle = OutlinedButton.styleFrom(
  side: const BorderSide(color: Color.fromARGB(255, 224, 214, 214), width: 2),
  foregroundColor: Colors.black,
  minimumSize: const Size(double.infinity, 55),
  padding: const EdgeInsets.symmetric(vertical: 20),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
);
ButtonStyle shortButtonStyle1 = ElevatedButton.styleFrom(
  backgroundColor: primaryColor,
  foregroundColor: Colors.white,
  minimumSize: const Size(double.infinity, 55),
  padding: const EdgeInsets.symmetric(vertical: 20),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
);
