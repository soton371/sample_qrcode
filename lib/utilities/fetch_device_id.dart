import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';

Future<String> fetchDeviceId() async {
  debugPrint("call fetchDeviceId");
    String? deviceId;
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId';
    }
    debugPrint("deviceId: $deviceId");
    return deviceId ?? 'null';
  }
