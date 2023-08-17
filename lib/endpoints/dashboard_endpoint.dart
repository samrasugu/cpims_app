import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchDashboardData({
  required BuildContext context,
  required String accessToken,
}) async {
  String? url = dotenv.env['endpointUrl'];

  http.Response response = await http.get(
    Uri.parse('$url/dashboard'),
    headers: {
      'Authorization': 'Bearer $accessToken',
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    return responseData;
  } else {
    throw Exception('Failed to fetch dashboard data');
  }
}
