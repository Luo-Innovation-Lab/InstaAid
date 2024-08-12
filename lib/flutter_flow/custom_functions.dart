import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<dynamic> prepareChatHistory(
  List<dynamic> chatHistory,
  String newChat,
  String? imgUrl,
) {
  // This function will create a ChatGPT shaped conversation and add it to our
  // chatHistory list. This function is typically called before we make a call
  // in to the ChatGPT API.

  // Add our shaped conversation to our list
  chatHistory.add(
      {"role": "userMessage", "content": newChat.trim(), "imgUrl": imgUrl});
  // Return our chatHistory list back which is then typically written back
  // to our App State variable
  return chatHistory;
}

List<dynamic> refreshChatHistory(
  List<dynamic> chatHistory,
  dynamic chatResponse,
) {
  // When ChatGPT responds we need to take the new response and add it
  // to our chatHistory list. We then pass back the chatHistory list
  // to the calling function which will typically update the AppState
  // with the new list.
  chatHistory.add({"role": "apiMessage", "content": chatResponse});
  //chatHistory.add(chatResponse);
  return chatHistory;
}

dynamic prepareSaveChat(
  String title,
  String description,
  List<dynamic> chat,
) {
  dynamic savedChat = {
    "title": title,
    "description": description,
    "history": chat
  };
  return savedChat;
}
