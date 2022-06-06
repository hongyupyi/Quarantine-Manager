import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:medicine/calendar/sp_utils.dart';

class DateHistoryStorage {
  static const String _searchHistoryKey = "DATE_HISTORY_KEY";

  // static Future<bool> putHistoryList(List<Map<String, String>> historyList) {
  //   return SpUtils.putObjectList(_searchHistoryKey, historyList);
  // }

  static List<Map<String, dynamic>> getHistoryList() {
    List<Map>? result = SpUtils.getObjectList(_searchHistoryKey);
    List<Map<String, dynamic>> value = List.empty(growable: true);

    if ((result ?? []).isNotEmpty) {
      for (int i = 0; i < result!.length; i++) {
        Map<String, dynamic> item = result[i] as Map<String, dynamic>;

        value.add(item);
      }
    }

    return value;
  }

  static Future<bool> putHistoryListItem(String item, DateTime date) {
    List<Map<dynamic, dynamic>>? result =
    SpUtils.getObjectList(_searchHistoryKey);
    String dateString = DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    if (result == null) {
      result = [];
      result.add({'name': item, 'date': dateString});
      return SpUtils.putObjectList(_searchHistoryKey, result);
    }

    // result.removeWhere((element) => element['name'] == item);

    // if (result.length == 10) {
    //   result.removeLast();
    // }
    result.insert(0, {'name': item, 'date': dateString});
    return SpUtils.putObjectList(_searchHistoryKey, result);
  }

  static Future<bool> removeHistoryListItem(String item, String dateString) {
    List<Map<dynamic, dynamic>>? result =
    SpUtils.getObjectList(_searchHistoryKey);

    if (result != null) {
      result.removeWhere((element) => element['name'] == item && element['date'] == dateString);
      return SpUtils.putObjectList(_searchHistoryKey, result);
    }
    return Future.value(false);
  }

  static Future<bool> deleteHistoryList() {
    return SpUtils.remove(_searchHistoryKey);
  }
}
