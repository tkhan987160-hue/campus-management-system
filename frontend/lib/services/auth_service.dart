
class AuthService {
  // Temporary testing API (JSONPlaceholder)
  
  // Login function (Demo - will validate any email/password for now)
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Simulating API call
      await Future.delayed(Duration(seconds: 1));
      
      // Demo validation: accept any non-empty values
      if (email.isEmpty || password.isEmpty) {
        return {
          'success': false,
          'message': 'Please fill all fields'
        };
      }
      
      if (!email.contains('@')) {
        return {
          'success': false,
          'message': 'Invalid email format'
        };
      }
      
      if (password.length < 6) {
        return {
          'success': false,
          'message': 'Password must be at least 6 characters'
        };
      }
      
      // Success response
      return {
        'success': true,
        'message': 'Login successful!',
        'user': {
          'email': email,
          'name': email.split('@')[0],
          'token': 'demo_token_${DateTime.now().millisecondsSinceEpoch}'
        }
      };
      
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e'
      };
    }
  }
}
