import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/models/token_mod.dart';

Future<TokenModel> fetchToken() async {
  debugPrint("call fetchToken");
  Uri url = Uri.parse(AppUrls.tokenUrl);
  final payload = {
    "client_id": "ati-client-id",
    "username": "ati-user",
    "password": "ati123",
    "grant_type": "password"
  };
  final response = await http.post(url,
      body: payload,
      headers: {"content-type": "application/x-www-form-urlencoded"});
  TokenModel tokenModel = TokenModel();
  try {
    if (response.statusCode == 200) {
      tokenModel = tokenModelFromJson(response.body);
      debugPrint("tokenModel.tokenType: ${tokenModel.tokenType}");
      return tokenModel;
    } else {
      debugPrint("response.statusCode: ${response.statusCode}");
      return tokenModel;
    }
  } catch (e) {
    debugPrint("Exception: $e");
    return tokenModel;
  }
}
