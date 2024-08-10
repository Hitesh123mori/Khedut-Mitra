import 'dart:convert'; // For JSON encoding/decoding
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> postTextAndFetchJson(String baseUrl, String disease) async {
    // Construct the URL with the disease parameter
    final url = Uri.parse('$baseUrl/generate?disease=$disease');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        // No body is needed if the parameters are in the URL
        body: json.encode({}),
      );

      // Check if the response status code is 200 (OK)
      if (response.statusCode == 200) {
        // Decode the JSON response and return it
        return json.decode(response.body);
      } else {
        // Throw an exception if the response status code is not OK
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Failed to load data: $e');
    }
  }
}
