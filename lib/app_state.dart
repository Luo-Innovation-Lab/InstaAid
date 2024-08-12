import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:csv/csv.dart';
import 'package:synchronized/synchronized.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    secureStorage = const FlutterSecureStorage();
    await _safeInitAsync(() async {
      _apiKey = await secureStorage.getString('ff_apiKey') ?? _apiKey;
    });
    await _safeInitAsync(() async {
      _isDarkMode = await secureStorage.getBool('ff_isDarkMode') ?? _isDarkMode;
    });
    await _safeInitAsync(() async {
      _savedConversations =
          (await secureStorage.getStringList('ff_savedConversations'))
                  ?.map((x) {
                try {
                  return jsonDecode(x);
                } catch (e) {
                  print("Can't decode persisted json. Error: $e.");
                  return {};
                }
              }).toList() ??
              _savedConversations;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late FlutterSecureStorage secureStorage;

  String _apiKey = 'sk-None-EdysOtJ2uiExwRxhethrT3BlbkFJ50xu3NIhqZnYt4aBOygC';
  String get apiKey => _apiKey;
  set apiKey(String value) {
    _apiKey = value;
    secureStorage.setString('ff_apiKey', value);
  }

  void deleteApiKey() {
    secureStorage.delete(key: 'ff_apiKey');
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;
  set isDarkMode(bool value) {
    _isDarkMode = value;
    secureStorage.setBool('ff_isDarkMode', value);
  }

  void deleteIsDarkMode() {
    secureStorage.delete(key: 'ff_isDarkMode');
  }

  List<dynamic> _currentConversation = [];
  List<dynamic> get currentConversation => _currentConversation;
  set currentConversation(List<dynamic> value) {
    _currentConversation = value;
  }

  void addToCurrentConversation(dynamic value) {
    currentConversation.add(value);
  }

  void removeFromCurrentConversation(dynamic value) {
    currentConversation.remove(value);
  }

  void removeAtIndexFromCurrentConversation(int index) {
    currentConversation.removeAt(index);
  }

  void updateCurrentConversationAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    currentConversation[index] = updateFn(_currentConversation[index]);
  }

  void insertAtIndexInCurrentConversation(int index, dynamic value) {
    currentConversation.insert(index, value);
  }

  List<dynamic> _savedConversations = [];
  List<dynamic> get savedConversations => _savedConversations;
  set savedConversations(List<dynamic> value) {
    _savedConversations = value;
    secureStorage.setStringList(
        'ff_savedConversations', value.map((x) => jsonEncode(x)).toList());
  }

  void deleteSavedConversations() {
    secureStorage.delete(key: 'ff_savedConversations');
  }

  void addToSavedConversations(dynamic value) {
    savedConversations.add(value);
    secureStorage.setStringList('ff_savedConversations',
        _savedConversations.map((x) => jsonEncode(x)).toList());
  }

  void removeFromSavedConversations(dynamic value) {
    savedConversations.remove(value);
    secureStorage.setStringList('ff_savedConversations',
        _savedConversations.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromSavedConversations(int index) {
    savedConversations.removeAt(index);
    secureStorage.setStringList('ff_savedConversations',
        _savedConversations.map((x) => jsonEncode(x)).toList());
  }

  void updateSavedConversationsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    savedConversations[index] = updateFn(_savedConversations[index]);
    secureStorage.setStringList('ff_savedConversations',
        _savedConversations.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInSavedConversations(int index, dynamic value) {
    savedConversations.insert(index, value);
    secureStorage.setStringList('ff_savedConversations',
        _savedConversations.map((x) => jsonEncode(x)).toList());
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

extension FlutterSecureStorageExtensions on FlutterSecureStorage {
  static final _lock = Lock();

  Future<void> writeSync({required String key, String? value}) async =>
      await _lock.synchronized(() async {
        await write(key: key, value: value);
      });

  void remove(String key) => delete(key: key);

  Future<String?> getString(String key) async => await read(key: key);
  Future<void> setString(String key, String value) async =>
      await writeSync(key: key, value: value);

  Future<bool?> getBool(String key) async => (await read(key: key)) == 'true';
  Future<void> setBool(String key, bool value) async =>
      await writeSync(key: key, value: value.toString());

  Future<int?> getInt(String key) async =>
      int.tryParse(await read(key: key) ?? '');
  Future<void> setInt(String key, int value) async =>
      await writeSync(key: key, value: value.toString());

  Future<double?> getDouble(String key) async =>
      double.tryParse(await read(key: key) ?? '');
  Future<void> setDouble(String key, double value) async =>
      await writeSync(key: key, value: value.toString());

  Future<List<String>?> getStringList(String key) async =>
      await read(key: key).then((result) {
        if (result == null || result.isEmpty) {
          return null;
        }
        return const CsvToListConverter()
            .convert(result)
            .first
            .map((e) => e.toString())
            .toList();
      });
  Future<void> setStringList(String key, List<String> value) async =>
      await writeSync(key: key, value: const ListToCsvConverter().convert([value]));
}
