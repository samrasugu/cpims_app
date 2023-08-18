import 'dart:convert';

import 'package:cpims_app/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// handle HTTP response errors from API request
// provides appropriate user feedback within the application. 
// It allows for efficient error handling based on the HTTP status code of the response, 
// displaying relevant error messages or executing a success callback function.
void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['detail']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
