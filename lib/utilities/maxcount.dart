import 'package:sample_qrcode/models/search_label_mod.dart';

int maxCount(ListResponse data) {
  final totalQrcode = data.totalBarcodeLblNo ?? 0;
  final printedQr = data.printedBcLblNo ?? 0;
  final maxPrint = data.maxPrintQty ?? 0;
  int result =
      (totalQrcode - printedQr) < maxPrint ? totalQrcode - printedQr : maxPrint;
  return result;
}




bool isPositiveInteger(String value) {
  try {
    int.parse(value);
    return true;
  } on FormatException {
    return false;
  }
}

bool isPositiveIntegerInRange(String value, int min, int max) {
  int parsedValue = int.parse(value);
  return isPositiveInteger(value) && parsedValue >= min && parsedValue <= max;
}