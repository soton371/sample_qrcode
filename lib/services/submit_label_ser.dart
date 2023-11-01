import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/models/submit_label_mod.dart';

Future<SubmitLabelModel> submitLabelData(Map<String, Object> payload) async {
  debugPrint("call submitLabelData");
  Uri url = Uri.parse(AppUrls.submitLabelUrl);

  final response = await http.post(url, body: json.encode(payload), headers: {
    "Accept": "application/json",
    "content-type": "application/json"
  });
  try {
    if (response.statusCode == 200) {
      final submitLabelModel = submitLabelModelFromJson(response.body);
      
      if (submitLabelModel.statusCode == 200) {
        return submitLabelModel;
      } else {
        debugPrint("submitLabelModel.statusCode: ${submitLabelModel.statusCode}");
        debugPrint("submitLabelModel.Msg: ${submitLabelModel.message}");
        submitLabelModel.message = "No data found";
        submitLabelModel.statusCode = response.statusCode;
        submitLabelModel.submitListResponse = [];
        return submitLabelModel;
      }
    } else {
      debugPrint("response.statusCode: ${response.statusCode}");
      final submitLabelModel = SubmitLabelModel();
      submitLabelModel.message = "No data found";
      submitLabelModel.statusCode = response.statusCode;
      submitLabelModel.submitListResponse = [];
      return submitLabelModel;
    }
  } catch (e) {
    debugPrint("Exception: $e");
    final submitLabelModel = SubmitLabelModel();
    submitLabelModel.message = "Something went wrong";
    submitLabelModel.statusCode = 500;
    submitLabelModel.submitListResponse = [];
    return submitLabelModel;
  }
}
