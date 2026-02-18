import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 🔹 Base URL (for Android emulator)
  static const String baseUrl =
      "https://campus-management-system-1-8uyc.onrender.com";

  /* =========================
     STUDENT REGISTER
  ========================= */
  static Future<http.Response> register(
    String rollNumber,
    String name,
    String password,
  ) async {
    final url = Uri.parse("$baseUrl/api/auth/register");

    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "rollNumber": rollNumber,
        "name": name,
        "password": password,
      }),
    );
  }

  /* =========================
     STUDENT / ADMIN LOGIN
  ========================= */
  static Future<http.Response> login(String rollNumber, String password) async {
    final url = Uri.parse("$baseUrl/api/auth/login");

    return await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"rollNumber": rollNumber, "password": password}),
    );
  }
}
