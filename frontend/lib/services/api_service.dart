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

  /* =========================
   GET ATTENDANCE STATS
========================= */
  static Future<http.Response> getAttendanceStats(String token) async {
    final url = Uri.parse("$baseUrl/api/attendance/stats");

    return await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }

  /* =========================
   GET SUBJECT-WISE ATTENDANCE
========================= */
  static Future<http.Response> getSubjectWise(String token) async {
    final url = Uri.parse("$baseUrl/api/attendance/subject-wise");

    return await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );
  }
}
