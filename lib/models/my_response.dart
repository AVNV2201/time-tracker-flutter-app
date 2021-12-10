import 'package:flutter/material.dart';
import 'package:time_tracker/utils/constants.dart';

class MyResponse{
  final bool success;
  final String message;
  // response code will hold the error code if error response is an error
  // 0 by default => success; no error
  final int responseCode;

  const MyResponse({@required this.success, this.message, this.responseCode = 0});

  factory MyResponse.success() => const MyResponse(success: true);
  factory MyResponse.unknownError() => const MyResponse(success: false, message: ErrorMessage.unknownError, responseCode: 1);

  @override
  String toString() {
    return 'My Response Error $responseCode: $message';
  }
}

/*
Error Codes
    1 - Unknown Error
    2 - Connection Error
    3 - profile not found
    4 - empty list
    5 - post not found
    6 - Sign In Required
    100 - Some other error to be shown in snackbar or elsewhere
*/
