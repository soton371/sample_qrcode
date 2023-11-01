import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/database/app_db.dart';
import 'package:sample_qrcode/models/login_mod.dart';

Future<LoginModel> doLogin({required String accessToken, required Map payload}) async {
  debugPrint("call doLogin");
  Uri url = Uri.parse(AppUrls.loginUrl);
  final encodedPayload = jsonEncode(payload);
  final header = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $accessToken'
  };
  
  final response = await http.post(url, body: encodedPayload, headers: header);

  LoginModel loginModel = LoginModel();
  try {
    if (response.statusCode == 200) {
      loginModel = loginModelFromJson(response.body);
      final obj = loginModel.objResponse;
      if (obj != null) {
        AppDB.putSaUserId(obj.sausersId ?? 0);
        AppDB.putSessionId(obj.sessionId ?? '');
        AppDB.putUserCode(obj.userCode ?? '');
        AppDB.putUserName(obj.usersName ?? '');
      }
      return loginModel;
    } else {
      debugPrint("response.statusCode: ${response.statusCode}");
      return loginModel;
    }
  } catch (e) {
    debugPrint("Exception: $e");
    loginModel.message = "Something went wrong";
    return loginModel;
  }
}
