// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
import 'dart:convert';

class Base64Image extends StatelessWidget {
  final double? width;
  final double? height;
  final String base64Image;

  Base64Image({
    Key? key,
    this.width,
    this.height,
    required this.base64Image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert the base64 string to Uint8List
    final decodedBytes = base64Decode(base64Image);

    return Image.memory(
      decodedBytes,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
