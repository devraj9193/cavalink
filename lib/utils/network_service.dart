import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'app_config.dart';

class NetworkService {
  static final _prefs = AppConfig().preferences;

  static String? getHeaderToken() {
    if (_prefs != null) {
      final token = _prefs?.getString(AppConfig.isToken);
      if (token != null && token.isNotEmpty) {
        return "Bearer $token";
      }
    }
    return null;  // No token available
  }

  /// GET request with optional token
  static Future<dynamic> get(String url, {bool useToken = true}) async {
    try {
      debugPrint("GET TOKEN: ${getHeaderToken()}");
      debugPrint("GET URL: $url");

      final token = getHeaderToken();
      final headers = {
        'Content-Type': 'application/json',
        if (useToken && token != null) 'Authorization': token,
      };


      final response = await http.get(Uri.parse(url), headers: headers);

      debugPrint("GET Response: ${response.body}");

      if (response.statusCode == 200) {
        debugPrint("GET Status: ${response.statusCode}");
        return jsonDecode(response.body);
      } else {
        throw Exception('GET request failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("GET error: $e");
    }
  }

  /// POST request with optional token
  static Future<dynamic> post(String url, Map<String, dynamic> body, {bool useToken = true}) async {
    try {
      debugPrint("POST TOKEN: ${getHeaderToken()}");
      debugPrint("POST URL: $url");
      debugPrint("POST Body: $body");

      final token = getHeaderToken();
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        if (useToken && token != null) 'Authorization': token,
      };

      final client = http.Client();

      final request = http.Request('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..body = jsonEncode(body);

      final streamedResponse = await client.send(request);

      // Check if it was redirected
      if (streamedResponse.statusCode == 302 || streamedResponse.isRedirect) {
        throw Exception("Received redirect (302). Check API URL or server config.");
      }

      final response = await http.Response.fromStream(streamedResponse);

      debugPrint("POST Status: ${response.statusCode}");
      debugPrint("POST Response: ${response.body}");

      if (response.statusCode == 200  || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        throw Exception('POST request failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("POST error: $e");
    }
  }
}



// class NetworkService {
//   static Future<dynamic> get(String url) async {
//     try {
//       final response = await http.get(Uri.parse(url));
//       debugPrint("GET $url");
//       debugPrint("Status: ${response.statusCode}");
//       debugPrint("Response: ${response.body}");
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('GET request failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception("GET error: $e");
//     }
//   }
//
//   static Future<dynamic> post(String url, Map<String, dynamic> body) async {
//     try {
//       debugPrint("POST $url");
//       debugPrint("Body: $body");
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(body),
//       );
//
//       debugPrint("Status: ${response.statusCode}");
//       debugPrint("Response: ${response.body}");
//
//       if (response.statusCode == 200) {
//         return jsonDecode(response.body);
//       } else {
//         throw Exception('POST request failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception("POST error: $e");
//     }
//   }
// }
