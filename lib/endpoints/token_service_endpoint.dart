import 'dart:convert';

import 'package:cpims_app/helpers/http_response_handler.dart';
import 'package:cpims_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

// function to make API call to token endpoint and retrieve the access token
// @param - username
// @param - password
// @return - the access token if the API call is successful
// else - throw an error
Future<void> logIn({
  required BuildContext context,
  required String userName,
  required String password,
}) async {
  String? url = dotenv.env['endpointUrl'];
  // String accessToken = '';
  http.Response response = await http.post(
    Uri.parse('$url/token/'),
    body: {
      'username': userName,
      'password': password,
    },
  );

  if (context.mounted) {
    httpErrorHandle(
      response: response,
      context: context,
      onSuccess: () {
        final responseData = json.decode(response.body);
        final accessToken = responseData['access'];
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                accessToken: accessToken,
              ),
            ),
          );
        }
      },
    );
  }
}
