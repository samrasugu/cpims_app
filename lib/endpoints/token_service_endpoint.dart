import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<String> logIn({
  required BuildContext context,
  required String userName,
  required String password,
  required void Function()? onError,
}) async {
  String? url = dotenv.env['endpointUrl'];
  http.Response response = await http.post(
    Uri.parse('$url/token/'),
    body: {
      'username': userName,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final accessToken = responseData['access'];
    print(accessToken);
    return accessToken;
  } else {
    onError?.call();
    throw Exception('Failed to login');
  }
}
