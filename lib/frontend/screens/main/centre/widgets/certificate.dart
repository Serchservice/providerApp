import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provide/lib.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart';

class CustomData {
  const CustomData({this.name = '[your name]'});
  final String name;
}

typedef LayoutCallbackWithData = Future<Uint8List> Function(PdfPageFormat pageFormat, CustomData data);

class Example {
  const Example(this.name, this.file, this.builder, [this.needsData = false]);
  final String name;
  final String file;
  final LayoutCallbackWithData builder;
  final bool needsData;
}

const examples = Example('CERTIFICATE', 'certificate.dart', generateCertificate, true);

Future<Uint8List> generateCertificate(
    PdfPageFormat pageFormat, CustomData data) async {
  final lorem = pw.LoremText();
  final pdf = pw.Document();

  final libreBaskerville = await PdfGoogleFonts.libreBaskervilleRegular();
  final libreBaskervilleItalic = await PdfGoogleFonts.libreBaskervilleItalic();
  final libreBaskervilleBold = await PdfGoogleFonts.libreBaskervilleBold();
  final robotoLight = await PdfGoogleFonts.robotoLight();
  final medail = await rootBundle.loadString('asset/logo/logo.png');
  final swirls = await rootBundle.loadString('asset/logo/logo.png');
  final swirls1 = await rootBundle.loadString('asset/logo/logo.png');
  final swirls2 = await rootBundle.loadString('asset/logo/logo.png');
  final swirls3 = await rootBundle.loadString('asset/logo/logo.png');
  final garland = await rootBundle.loadString('asset/logo/logo.png');

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          // pw.Spacer(flex: 2),
          pw.RichText(
            text: pw.TextSpan(
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 25,
                ),
                children: [
                  const pw.TextSpan(text: 'CERTIFICATE '),
                  pw.TextSpan(
                    text: 'of',
                    style: pw.TextStyle(
                      fontStyle: pw.FontStyle.italic,
                      fontWeight: pw.FontWeight.normal,
                    ),
                  ),
                  const pw.TextSpan(text: ' ACHIEVEMENT'),
                ]),
          ),
          pw.Spacer(),
          pw.Text(
            'THIS ACKNOWLEDGES THAT',
            style: pw.TextStyle(
              font: robotoLight,
              fontSize: 10,
              letterSpacing: 2,
              wordSpacing: 2,
            ),
          ),
          pw.SizedBox(
            width: 300,
            child: pw.Divider(color: PdfColors.grey, thickness: 1.5),
          ),
          pw.Text(
            data.name,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 20,
            ),
          ),
          pw.SizedBox(
            width: 300,
            child: pw.Divider(color: PdfColors.grey, thickness: 1.5),
          ),
          pw.Text(
            'HAS SUCCESSFULLY COMPLETED THE',
            style: pw.TextStyle(
              font: robotoLight,
              fontSize: 10,
              letterSpacing: 2,
              wordSpacing: 2,
            ),
          ),
          pw.SizedBox(height: 10),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.SvgImage(
                svg: swirls,
                height: 10,
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                child: pw.Text(
                  'Flutter PDF Demo',
                  style: const pw.TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              pw.Transform(
                transform: Matrix4.diagonal3Values(-1, 1, 1),
                adjustLayout: true,
                child: pw.SvgImage(
                  svg: swirls,
                  height: 10,
                ),
              ),
            ],
          ),
          pw.Spacer(),
          pw.SvgImage(
            svg: swirls2,
            width: 150,
          ),
          pw.Spacer(),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Flexible(
                child: pw.Text(
                  lorem.paragraph(40),
                  style: const pw.TextStyle(fontSize: 6),
                  textAlign: pw.TextAlign.justify,
                ),
              ),
              pw.SizedBox(width: 100),
              pw.SvgImage(
                svg: medail,
                width: 100,
              ),
            ],
          ),
        ],
      ),
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat,
        theme: pw.ThemeData.withFont(
          base: libreBaskerville,
          italic: libreBaskervilleItalic,
          bold: libreBaskervilleBold,
        ),
        buildBackground: (context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(
            margin: const pw.EdgeInsets.all(10),
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                  color: const PdfColor.fromInt(0xffe435), width: 1),
            ),
            child: pw.Container(
              margin: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                    color: const PdfColor.fromInt(0xffe435), width: 5),
              ),
              width: double.infinity,
              height: double.infinity,
              child: pw.Stack(
                alignment: pw.Alignment.center,
                children: [
                  pw.Positioned(
                    top: 5,
                    child: pw.SvgImage(
                      svg: swirls1,
                      height: 60,
                    ),
                  ),
                  pw.Positioned(
                    bottom: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls1,
                        height: 60,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    top: 5,
                    left: 5,
                    child: pw.SvgImage(
                      svg: swirls3,
                      height: 160,
                    ),
                  ),
                  pw.Positioned(
                    top: 5,
                    right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, 1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 5,
                    left: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),
                  pw.Positioned(
                    bottom: 5,
                    right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, -1, 1),
                      adjustLayout: true,
                      child: pw.SvgImage(
                        svg: swirls3,
                        height: 160,
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.only(
                      top: 120,
                      left: 80,
                      right: 80,
                      bottom: 80,
                    ),
                    child: pw.SvgImage(
                      svg: garland,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  return pdf.save();
}


class SkillCertificate extends StatefulWidget {
  const SkillCertificate({super.key});

  @override
  State<SkillCertificate> createState() => _SkillCertificateState();
}

class _SkillCertificateState extends State<SkillCertificate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: SColors.lightPurple,
          width: 2.0
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(
            color: SColors.lightPurple,
            width: 2.0
          ),
        ),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.all(3),
              height: 80
            ),
            Container(
              color: Theme.of(context).primaryColor,
              padding: const EdgeInsets.all(6),
            )
          ],
        )
      )
    );
  }
}