import 'dart:convert';
import 'package:flutter/foundation.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'api_manager.dart';

export 'api_manager.dart' show ApiCallResponse;

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

/// Start Flowise Group Code

class FlowiseGroup {
  static String getBaseUrl({
    String? question = '',
    String? sessionId = '',
  }) =>
      'http://18.226.17.246/api/v1/prediction';
  static Map<String, String> headers = {};
  static AskquestionCall askquestionCall = AskquestionCall();
  static VoiceChatCall voiceChatCall = VoiceChatCall();
  static ImageChatCall imageChatCall = ImageChatCall();
}

class AskquestionCall {
  Future<ApiCallResponse> call({
    String? question = '',
    String? sessionId = '',
  }) async {
    final baseUrl = FlowiseGroup.getBaseUrl(
      question: question,
      sessionId: sessionId,
    );

    final ffApiRequestBody = '''
{
  "question": "$question",
  "overrideConfig": {
    "sessionId": "$sessionId"
  }
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'askquestion',
      apiUrl: '$baseUrl/698d97c9-800a-44ca-a16e-3dd450aa4864',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }

  String? response(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.text''',
      ));
  String? sessionId(dynamic response) => castToType<String>(getJsonField(
        response,
        r'''$.sessionId''',
      ));
}

class VoiceChatCall {
  Future<ApiCallResponse> call({
    String? data = '',
    String? type = 'audio',
    String? question = '',
    String? sessionId = '',
  }) async {
    final baseUrl = FlowiseGroup.getBaseUrl(
      question: question,
      sessionId: sessionId,
    );

    final ffApiRequestBody = '''
{
  "overrideConfig": {
    "sessionId": "$sessionId"
  },
  "uploads": [
    {
      "data": "data:audio/webm;codecs=opus;base64,$data",
      "type": "audio",
      "name": "audio.wav",
      "mime": "audio/webm"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'VoiceChat',
      apiUrl: '$baseUrl/698d97c9-800a-44ca-a16e-3dd450aa4864',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

class ImageChatCall {
  Future<ApiCallResponse> call({
    String? imgUrl = '',
    String? question = '',
    String? sessionId = '',
  }) async {
    final baseUrl = FlowiseGroup.getBaseUrl(
      question: question,
      sessionId: sessionId,
    );

    final ffApiRequestBody = '''
{
  "question": "$question",
  "overrideConfig": {
    "sessionId": "$sessionId"
  },
  "uploads": [
    {
      "data": "data:image/png;base64,$imgUrl",
      "name": "Flowise.png",
      "mime": "image/png",
      "type": "url"
    }
  ]
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'ImageChat',
      apiUrl: '$baseUrl/698d97c9-800a-44ca-a16e-3dd450aa4864',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: false,
      alwaysAllowBody: false,
    );
  }
}

/// End Flowise Group Code

class FlowiseCombatCall {
  static Future<ApiCallResponse> call({
    String? question = '',
    String? namespace = '',
  }) async {
    final ffApiRequestBody = '''
{
  "question": "$question"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'flowiseCombat',
      apiUrl:
          'http://18.226.17.246/api/v1/prediction/698d97c9-800a-44ca-a16e-3dd450aa4864',
      callType: ApiCallType.POST,
      headers: {
        'Authorization': 'Bearer tkWSaFpLtEaPlPCmpY9fXsSGBlzWEw1go9nOAE8TgU4',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
      isStreamingApi: true,
      alwaysAllowBody: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _toEncodable(dynamic item) {
  if (item is DocumentReference) {
    return item.path;
  }
  return item;
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("List serialization failed. Returning empty list.");
    }
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar, toEncodable: _toEncodable);
  } catch (_) {
    if (kDebugMode) {
      print("Json serialization failed. Returning empty json.");
    }
    return isList ? '[]' : '{}';
  }
}
