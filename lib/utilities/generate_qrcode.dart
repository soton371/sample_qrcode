import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

pw.BarcodeWidget generateQRCode(String data) {
  return pw.BarcodeWidget(
    color: PdfColor.fromHex("#000000"),
    barcode: pw.Barcode.qrCode(),
    data: data,
  );
}
