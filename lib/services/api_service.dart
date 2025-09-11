import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "https://paam.learntoria.com/v1";

  // 🔑 Master API Key (required by server for all requests)
  static const String apiKey =
      "fsdgsdfsdfgv4vwewetvwev"; // <-- Paste API key here

  // Save token to SharedPreferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_token", token);
  }

  // Get saved token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("auth_token");
  }

  // Logout & clear token
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_token");
  }

  // Headers without token (for signup & login)
  static Map<String, String> _defaultHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": apiKey, // ✅ Add API key for login/register
    };
  }

  // Headers with token (for protected endpoints)
  static Future<Map<String, String>> _authHeaders() async {
    // final token = await getToken();
    return {
      "Content-Type": "application/json",
      "Authorization": apiKey,
      // "x-api-key": apiKey, // ✅ API key included everywhere
    };
  }

  // Register User
  static Future<Map<String, dynamic>> registerUser({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/user?endpoint=register");
    final response = await http.post(
      url,
      headers: _defaultHeaders(),
      body: jsonEncode({
        "firstname": firstName,
        "lastname": lastName,
        "email": email,
        "phone": phone,
        "password": password,
        "password2": password,
      }),
    );

    final data = jsonDecode(response.body);

    print("🔹 REGISTER URL: $url");
    print("🔹 REGISTER HEADERS: ${_defaultHeaders()}");
    print("🔹 REGISTER RESPONSE CODE: ${response.statusCode}");
    print("🔹 REGISTER RESPONSE BODY: ${response.body}");

    // Save token if returned (handle array structure in registration)
    if (response.statusCode == 200) {
      if (data['token'] != null) {
        await saveToken(data['token']);
      } else if (data['data'] != null && data['data'] is List && data['data'].isNotEmpty) {
        await saveToken(data['data'][0]['apikey']);
      }
    }

    return data;
  }

  // Login User
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/admin?endpoint=loginuser");
    final response = await http.post(
      url,
      headers: _defaultHeaders(),
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);
    print("🔹 LOGIN URL: $url");
    print("🔹 LOGIN HEADERS: ${_defaultHeaders()}");
    print(
      "🔹 LOGIN BODY: ${jsonEncode({"email": email, "password": password})}",
    );
    print("🔹 LOGIN RESPONSE CODE: ${response.statusCode}");
    print("🔹 LOGIN RESPONSE BODY: ${response.body}");

    // Save token if returned
    if (response.statusCode == 200 && data['token'] != null) {
      await saveToken(data['token']);
    }

    return data;
  }

  // Verify OTP (requires token)
  static Future<Map<String, dynamic>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final url = Uri.parse("$baseUrl/user?endpoint=validateemailotp");
    final response = await http.post(
      url,
      headers: await _authHeaders(),
      body: jsonEncode({"email": email, "otp": otp}),
    );
    return jsonDecode(response.body);
  }

  // Resend OTP (requires token)
  static Future<Map<String, dynamic>> resendOtp({required String email}) async {
    final url = Uri.parse("$baseUrl/user?endpoint=sendemailotp");
    final response = await http.post(
      url,
      headers: await _authHeaders(),
      body: jsonEncode({"email": email}),
    );
    return jsonDecode(response.body);
  }

  // Fetch dashboard stats (requires token)
  static Future<Map<String, dynamic>> fetchDashboardData() async {
    final url = Uri.parse("$baseUrl/dashboard");
    final response = await http.get(url, headers: await _authHeaders());
    return jsonDecode(response.body);
  }
}
