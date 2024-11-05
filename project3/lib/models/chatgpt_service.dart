import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String _apiKey =
      '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';
  final String _url = 'https://api.openai.com/v1/chat/completions';

  Future<String> sendMessage(String message) async {
    try {
      final response = await http
          .post(
            Uri.parse(_url),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $_apiKey',
            },
            body: jsonEncode({
              'model': 'gpt-3.5-turbo', // Use 'gpt-4' if available and needed
              'messages': [
                {'role': 'system', 'content': 'You are a helpful assistant.'},
                {'role': 'user', 'content': message},
              ],
              'max_tokens': 100,
            }),
          )
          .timeout(const Duration(seconds: 10)); // Adding a timeout

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String reply = data['choices'][0]['message']['content'].trim();
        return reply;
      } else {
        // Detailed error message for non-200 responses
        return 'Error: ${response.statusCode} - ${response.reasonPhrase}';
      }
    } catch (e) {
      // Detailed error message for exceptions
      return 'Exception: $e';
    }
  }
}
