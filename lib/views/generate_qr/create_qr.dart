import 'package:flutter/material.dart';
import 'package:sample_qrcode/models/submit_label_mod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<bool> createPdf(SubmitLabelModel data, String saUser) async {
  final doc = pw.Document();
  final font = await PdfGoogleFonts.tinosRegular();

  final lsData = data.submitListResponse;
  if (lsData == null) {
    debugPrint("lsData null");
    return false;
  }

  for (var element in lsData) {
    doc.addPage(
      pw.Page(
        pageFormat: const PdfPageFormat(158, 93),
        build: (pw.Context context) {
          return pw.Container(
              height: 93,
              width: 158,
              padding: const pw.EdgeInsets.only(left: 8, bottom: 5),
              child: pw.Row(
                children: [
                  pw.BarcodeWidget(
                    height: 73,
                    width: 73,
                    barcode: pw.Barcode.qrCode(),
                    data: element.qrData ?? 'null',
                  ),
                  pw.SizedBox(width: 5),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(element.samplePkgNo ?? 'null',
                            style: pw.TextStyle(fontSize: 9, font: font)),
                        pw.Text(element.alocMonName ?? 'null',
                            style: pw.TextStyle(fontSize: 9, font: font)),
                        pw.Text(element.allocationGrpNo ?? 'NU',
                            style: pw.TextStyle(
                                fontSize: 31, fontWeight: pw.FontWeight.bold)),
                        pw.Text(element.pkgSlotName ?? 'null',
                            style: pw.TextStyle(fontSize: 9, font: font)),
                        pw.Text(saUser,
                            style: pw.TextStyle(fontSize: 9, font: font)),
                      ])
                ],
              ));
        },
      ),
    ); // Page
  }
  // final pri = await Printing.listPrinters();
  // for (var element in pri) {debugPrint("element: $element"); }

  const printer = Printer(url: "ZDesigner ZD230-203dpi ZPL", isDefault: true);

  final pp = await Printing.directPrintPdf(
      usePrinterSettings: true,
      format: const PdfPageFormat(158, 93),
      printer: printer,
      onLayout: (PdfPageFormat format) async => doc.save());

  debugPrint("Print done: $pp");
  return pp;
  
  // return doc;
}
