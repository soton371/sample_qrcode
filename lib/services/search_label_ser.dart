import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/database/app_db.dart';
import 'package:sample_qrcode/models/search_label_mod.dart';
import 'package:sample_qrcode/utilities/fetch_device_id.dart';

Future<SearchLabelModel> fetchSearchLabelData() async {
  debugPrint("call fetchSearchLabelData");

  try {
    Uri url = Uri.parse(AppUrls.searchLabelUrl);
    final userDeviceDTM = DateTime.now();
    final userDeviceNo = await fetchDeviceId();
    final userId = await AppDB.fetchSaUserId();
    final session = await AppDB.fetchSessionId();

    final payload = {
      "performBy": userId,
      "udPerformBy": userId.toString(),
      "userDeviceNo": userDeviceNo,
      "userDeviceDTM": userDeviceDTM.toString(),
      "appNo": AppUrls.appId,
      "sessionId": session
    };

    final response = await http.post(url, body: json.encode(payload), headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });

    if (response.statusCode == 200) {
      final searchLabelModel = searchLabelModelFromJson(response.body);
      return searchLabelModel;
    } else {
      debugPrint(
          "response.statusCode in fetchSearchLabelData: ${response.statusCode}");
      final searchLabelModel = SearchLabelModel();
      searchLabelModel.message = "Not data found";
      searchLabelModel.statusCode = response.statusCode;
      searchLabelModel.listResponse = [];
      return searchLabelModel;
    }
  } catch (e) {
    debugPrint("Exception in fetchSearchLabelData: $e");
    final searchLabelModel = SearchLabelModel();
    searchLabelModel.message = "Something went wrong";
    searchLabelModel.statusCode = 500;
    searchLabelModel.listResponse = [];
    return searchLabelModel;
  }
}
