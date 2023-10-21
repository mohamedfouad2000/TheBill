import 'dart:io';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class pdfBill {
  static Future<File> generatePdf({
    required List<List<dynamic>> data,
    required String name,
    required String mobile,
    required String date,
    required var allprice,
  }) async {
    final headers = ['الصنف', 'الكميه', 'سعر الوحده', 'الاجمالي'];
    final pdf = pw.Document();
    DateTime billtime = DateTime.now();
    pdf.addPage(pw.Page(
        theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(
          await rootBundle.load(
            'as/fonts/NotoSansArabic-VariableFont_wdth,wght.ttf',
          ),
        )),
        textDirection: pw.TextDirection.rtl,
        build: (context) {
          return pw.Column(children: [
            pw.Text("فاتوره الدفع  ", style: const pw.TextStyle(fontSize: 40)),
            pw.Text("", style: const pw.TextStyle(fontSize: 40)),
            pw.Text("", style: const pw.TextStyle(fontSize: 40)),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(' $name', style: const pw.TextStyle(fontSize: 28)),
              pw.Text(' : ', style: const pw.TextStyle(fontSize: 28)),
              pw.Text('الاسم', style: const pw.TextStyle(fontSize: 28)),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(mobile, style: const pw.TextStyle(fontSize: 28)),
              pw.Text(' : ', style: const pw.TextStyle(fontSize: 28)),
              pw.Text('رقم الهاتف ', style: const pw.TextStyle(fontSize: 28)),
            ]),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text(' $date', style: const pw.TextStyle(fontSize: 28)),
              pw.Text(' : '),
              pw.Text('التاريخ ', style: const pw.TextStyle(fontSize: 28)),
            ]),
            pw.Table.fromTextArray(data: data, headers: headers),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text('$allprice ', style: const pw.TextStyle(fontSize: 28)),
              pw.Text(' : '),
              pw.Text('السعر الاجمالي ',
                  style: const pw.TextStyle(fontSize: 28)),
            ]),
          ]);
        }));
    return savepdf(
        Filename:
            'bill${billtime.year}${billtime.month}${billtime.day}${billtime.microsecond}.pdf',
        pdf: pdf);
  }

  static Future<File> savepdf(
      {required String Filename, required pw.Document pdf}) async {
    final byets = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$Filename');
    await file.writeAsBytes(byets);
    return file;
  }

  static Future<void> openfile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
