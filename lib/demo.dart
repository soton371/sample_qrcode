// // import 'package:flutter/services.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:printing/printing.dart';

// class DemoScreen extends StatefulWidget {
//   const DemoScreen({super.key});

//   @override
//   State<DemoScreen> createState() => _DemoScreenState();
// }

// class _DemoScreenState extends State<DemoScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Printing"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton(
//               onPressed: _createPdf,
//               child: const Text(
//                 'Create & Print PDF',
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: _displayPdf,
//               child: const Text(
//                 'Display PDF',
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             ElevatedButton(
//               onPressed: generatePdf,
//               child: const Text(
//                 'Generate Advanced PDF',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// create PDF & print it
//   void _createPdf() async {
//     final doc = pw.Document();

//     /// for using an image from assets
//     // final image = await imageFromAssetBundle('assets/image.png');

//     doc.addPage(
//       pw.Page(
//         // pageFormat: PdfPageFormat.a4,
//         pageFormat: const PdfPageFormat(158, 93, marginAll: 8),
//         build: (pw.Context context) {
//           return pw.Row(
//             children: [
//               pw.Container(
//                   height: 80,
//                   child: pw.Column(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.BarcodeWidget(
//                           height: 65,
//                           width: 65,
//                           barcode: pw.Barcode.qrCode(),
//                           data: "qrData",
//                         ),
//                         pw.Text("Soton Ahmed",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                             )),
//                       ])),
//               pw.SizedBox(width: 10),
//               pw.Container(
//                   height: 80,
//                   child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("2309A01000001",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                             )),
//                         pw.Text("S",
//                             style: pw.TextStyle(
//                                 fontSize: 30, fontWeight: pw.FontWeight.bold)),
//                         pw.Text("slotNo",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                             )),
//                       ]))
//             ],
//           );
//           // pw.Center(
//           //   child: pw.Text('Hello C# Brother'),
//           // ); // Center
//         },
//       ),
//     ); // Page

//     /// print the document using the iOS or Android print service:
//     await Printing.layoutPdf(
//         onLayout: (PdfPageFormat format) async => doc.save());

//     /// share the document to other applications:
//     // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

//     /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
//     /// save PDF with Flutter library "path_provider":
//     // final output = await getTemporaryDirectory();
//     // final file = File('${output.path}/example.pdf');
//     // await file.writeAsBytes(await doc.save());
//   }

//   /// display a pdf document.
//   void _displayPdf() {
//     final doc = pw.Document();
//     doc.addPage(
//       pw.Page(
//         // pageFormat: PdfPageFormat.a4,
//         pageFormat: const PdfPageFormat(158, 93, marginAll: 8),
//         build: (pw.Context context) {
//           return pw.Row(
//             children: [
//               pw.Container(
//                   height: 80,
//                   child: pw.Column(
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.BarcodeWidget(
//                           height: 65,
//                           width: 65,
//                           barcode: pw.Barcode.qrCode(),
//                           data: "qrData",
//                         ),
//                         pw.Text("Soton Ahmed",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                             )),
//                       ])),
//               pw.SizedBox(width: 10),
//               pw.Container(
//                   height: 80,
//                   child: pw.Column(
//                       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                       mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
//                       children: [
//                         pw.Text("2309A01000001",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                             )),
//                         pw.Text("S",
//                             style: pw.TextStyle(
//                                 fontSize: 30, fontWeight: pw.FontWeight.bold)),
//                         pw.Text("slotNo",
//                             style: const pw.TextStyle(
//                               fontSize: 10,
//                             )),
//                       ]))
//             ],
//           );
//           // pw.Center(
//           //   child: pw.Text(
//           //     'Hello eclectify Enthusiast',
//           //     style: pw.TextStyle(fontSize: 30),
//           //   ),
//           // );
//         },
//       ),
//     );

//     /// open Preview Screen
//     Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => PreviewScreen(doc: doc),
//         ));
//   }


//   /// more advanced PDF styling
//   Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
//     final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
//     final font = await PdfGoogleFonts.nunitoExtraLight();

//     pdf.addPage(
//       pw.Page(
//         pageFormat: format,
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.SizedBox(
//                 width: double.infinity,
//                 child: pw.FittedBox(
//                   child: pw.Text(title, style: pw.TextStyle(font: font)),
//                 ),
//               ),
//               pw.SizedBox(height: 20),
//               pw.Flexible(child: pw.FlutterLogo())
//             ],
//           );
//         },
//       ),
//     );
//     return pdf.save();
//   }

//   void generatePdf() async {
//     const title = 'Hello C# Brother';
//     await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
//   }
// }

// class PreviewScreen extends StatelessWidget {
//   final pw.Document doc;

//   const PreviewScreen({
//     Key? key,
//     required this.doc,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_outlined),
//         ),
//         centerTitle: true,
//         title: const Text("Preview"),
//       ),
//       body: PdfPreview(
//         build: (format) => doc.save(),
//         allowSharing: false,
//         allowPrinting: false,
//         initialPageFormat: const PdfPageFormat(158, 93, marginAll: 8),
//         pdfFileName: "mydoc.pdf",
//       ),
//     );
    
//   }
// }
