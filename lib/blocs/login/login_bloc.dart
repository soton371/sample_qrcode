import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sample_qrcode/config/urls.dart';
import 'package:sample_qrcode/services/do_login.dart';
import 'package:sample_qrcode/services/fetch_token.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      debugPrint("call DoLoginEvent");
      emit(LoginInitial());
      final getToken = await fetchToken();
      final accessToken = getToken.accessToken;
      if (accessToken == null || accessToken.isEmpty) {
        emit(const LoginFailed(
            title: "Token missing", content: "Failed to fetch token"));
        return;
      }

      final payload = {
        "appId": AppUrls.appId,
        "userPaswd": event.password,
        "usersName": event.username,
        "versionCode": AppUrls.versionCode
      };

      final loginResponse = await doLogin(accessToken: accessToken, payload: payload);
      final objRes = loginResponse.objResponse;
      if (objRes == null || objRes.sausersId == 0) {
        emit(const LoginFailed(
            title: "Login failed", content: "Please try again"));
        return;
      }

      emit(LoginSuccess());
    });
  }
}
