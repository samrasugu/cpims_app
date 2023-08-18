import 'dart:convert';

import 'package:cpims_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// function to make API call to dashboard endpoint and retrieve the dashboard data summary
// @param - accessToken - retrieved from the home screen state after login
//@return - a Map of the data from the dashboard enpoint if the API call is successful
// else - throw an error - shows a snackbar
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
    if (context.mounted) {
      showSnackBar(context, response.body);
    }
    throw Exception('Failed to fetch dashboard data');
  }
}
