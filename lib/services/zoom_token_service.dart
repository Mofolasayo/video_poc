import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:video_poc/config/app_config.dart';

class ZoomTokenService {
  Future<String> fetchToken({
    required String sessionName,
    required String userId,
    int role = 1,
  }) async {
    final uri = Uri.parse('${AppConfig.apiBaseUrl}/video-sdk/token');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'sessionName': sessionName,
        'role': role,
        'userIdentity': userId,
        'expirationSeconds': 3600,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Token request failed: ${response.statusCode}');
    }

    final body = jsonDecode(response.body);
    if (body is Map && body['token'] is String) {
      return body['token'] as String;
    }
    throw Exception('Token missing in response');
  }
}
