import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provide/lib.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_merger/pdf_merger.dart';
import 'package:get/get.dart';

class GenerateCertificateScreen extends StatefulWidget {
  const GenerateCertificateScreen({super.key});

  @override
  State<GenerateCertificateScreen> createState() => _GenerateCertificateScreenState();
}

class _GenerateCertificateScreenState extends State<GenerateCertificateScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  PrintingInfo? printingInfo;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool generated = false;
  String content = "";
  String name() {
    if(firstName.text.isEmpty && lastName.text.isEmpty){
      return "";
    } else {
      return "${firstName.text} ${lastName.text}";
    }
  }

  void verify() {
    if(!formKey.currentState!.validate()) return;
    setState(() => generated = true);
    Navigator.pop(context);
  }

  void generateCertificate() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: SText.center(
                text: "Please give us your details",
                size: 18,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              content: SizedBox.fromSize(
                size: const Size.fromHeight(200),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SFormField(
                        labelText: "John",
                        formName: "FirstName:",
                        controller: firstName,
                        validate: (value) {
                          if(value!.isEmpty){
                            return "Name field is empty";
                          } else {
                            return null;
                          }
                        },
                        cursorColor: Theme.of(context).primaryColor,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        formStyle: STexts.normalForm(context),
                        formColor: Theme.of(context).primaryColor,
                        enabledBorderColor: Theme.of(context).primaryColor,
                      ),
                      // const Spacer(),
                      SFormField(
                        labelText: "Doe",
                        formName: "LastName:",
                        controller: lastName,
                        validate: (value) {
                          if(value!.isEmpty){
                            return "Name field is empty";
                          } else {
                            return null;
                          }
                        },
                        cursorColor: Theme.of(context).primaryColor,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        formStyle: STexts.normalForm(context),
                        formColor: Theme.of(context).primaryColor,
                        enabledBorderColor: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                SBtn(onClick: () => verify(), text: "Ok", textSize: 16),
                SBtn(onClick: () => Get.back(), text: "Cancel", textSize: 16,)
              ],
              actionsPadding: const EdgeInsets.symmetric(vertical: 8),
              actionsAlignment: MainAxisAlignment.center,
            );
          }
        );
      }
    );
  }

  void downloadCertificate() async {
    // CreateImageFromPDFResponse response  = await PdfMerger.createImageFromPDF(path: singleFile, outputDirPath: outputDirPath);

    // if(response.status == "success") {
    // //response.response for output path in List<String>
    // //response.message for success message  in String
    // }
    // Retrieve the generated PDF file
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/certificate.pdf');
    // Save the PDF document to a file
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/certificate.pdf');
    // await file.writeAsBytes(await pdf.save());
    //     final bytes =  pdf.save();
    //     final dir = await getApplicationDocumentsDirectory();
    //     final file = File('${dir.path}/certificate.pdf');
    //     await file.writeAsBytes(bytes);

    //     await Printing.layoutPdf(
    //       onLayout: (_) => bytes,
    //       name: 'certificate.pdf',
    //     );
    // await OpenFilex.open(file.path);

    // setState(() {});

    // Print the PDF file to PDF Printer
    // await Printing.layoutPdf(
    //   onLayout: (pdfPageFormat) async => file.readAsBytes(),
    // );
  }

  List<String> generateInstructions = [
    "* Engage the least of 20 service trips",
    "* Have the least of 20 rates from your service trips",
    "* Run your account without being reported by any user",
    "* Be verified as a Serch service provider",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 1,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Theme.of(context).primaryColor
              )
            ),
            title: SText(
              text: "Generate certificate",
              color: Theme.of(context).primaryColorLight,
              size: 24, weight: FontWeight.bold
            ),
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Scolors.info3,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(Icons.warning_rounded, color: SColors.red, size: 35),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SText(
                                text: "Inorder to generate a skill certificate, you need to fulfill the following:",
                                color: SColors.black,
                                weight: FontWeight.bold,
                                size: 14
                              ),
                              const SizedBox(height: 10),
                              ...generateInstructions.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: SText(
                                    text: item,
                                    color: Theme.of(context).backgroundColor,
                                    size: 14
                                  ),
                              )).toList(),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                ]
              )
            ),
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  if(userInformationModel.certificate.isEmpty)
                  SizedBox(
                    height: 330,
                    child: PdfPreview(
                      build: (format) => certificate(format, name(), content),
                      scrollViewDecoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor
                      ),
                      //   useActions: false,
                      //   initialPageFormat: PdfPageFormat.a4,
                      //   // onPrinted: _showPrintedToast,
                      //   // onShared: _showSharedToast,
                    ),
                  ),
                  const SizedBox(height: 30),
                  if(generated) Container() else
                  SButton(
                    text: "Generate my certificate",
                    textSize: 16,
                    padding: const EdgeInsets.all(15),
                    width: Get.width,
                    onClick: () => generateCertificate()
                  ),
                  const SizedBox(height: 10),
                  if(generated)
                  SButton(
                    text: "Download my certificate",
                    textSize: 16,
                    padding: const EdgeInsets.all(15),
                    width: Get.width,
                    onClick: () => downloadCertificate(),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

Future<Uint8List> certificate(PdfPageFormat pageFormat, String name, String content) async {
  final pdf = pw.Document();

  final libreBaskerville = await PdfGoogleFonts.libreBaskervilleRegular();
  final libreBaskervilleItalic = await PdfGoogleFonts.libreBaskervilleItalic();
  final libreBaskervilleBold = await PdfGoogleFonts.libreBaskervilleBold();
  final robotoLight = await PdfGoogleFonts.robotoLight();
  final logoImage = await imageFromAssetBundle(SImages.logo);
  final awardImage = await imageFromAssetBundle(SImages.award);
  final swirlImage = await imageFromAssetBundle(SImages.swirl);
  final taglineImage = await imageFromAssetBundle(SImages.tagline);
  final signatureImage = await imageFromAssetBundle(SImages.signature);
  // final swirls = await rootBundle.loadString('asset/logo/logo.png');

  pdf.addPage(
    pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.RichText(
            text: pw.TextSpan(
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 25),
            children: [
              const pw.TextSpan(text: 'PROOF '),
              pw.TextSpan(
                text: 'of',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic, fontWeight: pw.FontWeight.normal),
              ),
              const pw.TextSpan(text: ' SKILL CERTIFICATE'),
            ]),
          ),
          pw.SizedBox(height: 50),
          pw.Text(
            'Presented by the company, Serch to the recipient below to show that the recipient worked with Serch, a provideSharing and requestSharing company.',
            style: pw.TextStyle(
              fontSize: 18,
              fontStyle: pw.FontStyle.italic,
            ),
            textAlign: pw.TextAlign.center
          ),
          pw.SizedBox(height: 50),
          pw.SizedBox(width: 500, child: pw.Divider(color: PdfColors.grey, thickness: 1.5)),
          name.isEmpty ? pw.Container(
            height: 50,
            decoration: pw.BoxDecoration(
              color: const PdfColor.fromInt(0xffF3F3F3),
              borderRadius: pw.BorderRadius.circular(20)
            )
          ) :
          pw.Text(
            name.toUpperCase(),
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 24),
          ),
          pw.SizedBox(width: 500, child: pw.Divider(color: PdfColors.grey, thickness: 1.5)),
          content.isEmpty ? pw.ListView.builder(
            itemBuilder: (context, index) {
              return pw.Container(
                height: 20,
                margin: const pw.EdgeInsets.only(bottom: 5, top: 10),
                decoration: pw.BoxDecoration(
                  color: const PdfColor.fromInt(0xffF3F3F3),
                  borderRadius: pw.BorderRadius.circular(10)
                )
              );
            },
            itemCount: 3
          ) : pw.Text(
            content,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 16, font: robotoLight),
          ),
          pw.Spacer(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.end,
            children: [
              pw.Column(
                children: [
                  pw.Image(signatureImage, width: 70),
                  pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                    child: pw.Text(
                      '_________________________',
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  pw.Text(
                    'Evaristus Adimonyemma',
                    style: pw.TextStyle(
                      font: robotoLight,
                      fontSize: 16,
                      wordSpacing: 2,
                    ),
                  ),
                  pw.Text(
                    'CEO',
                    style: pw.TextStyle(
                      font: robotoLight,
                      fontSize: 14,
                      wordSpacing: 2,
                    ),
                  ),
                ]
              )
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
        orientation: pw.PageOrientation.landscape,
        buildBackground: (context) => pw.FullPage(
          ignoreMargins: true,
          child: pw.Container(
            margin: const pw.EdgeInsets.all(30),
            decoration: pw.BoxDecoration(border: pw.Border.all(color: const PdfColor.fromInt(0xff3B043B), width: 1)),
            child: pw.Container(
              margin: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(border: pw.Border.all(color: const PdfColor.fromInt(0xff3B043B), width: 5)),
              width: double.infinity,
              height: double.infinity,
              child: pw.Stack(
                alignment: pw.Alignment.center,
                children: [
                  pw.Positioned(top: 10, left: 10, child: pw.Image(logoImage, width: 50)),
                  pw.Positioned(top: 10, right: 10, child: pw.Image(awardImage, width: 40)),
                  pw.Positioned(
                    bottom: -12, left: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(1, 1, 1),
                      adjustLayout: true,
                      child: pw.Image(swirlImage, width: 50)
                    ),
                  ),
                  pw.Positioned(
                    bottom: -12, right: 5,
                    child: pw.Transform(
                      transform: Matrix4.diagonal3Values(-1, 1, 1),
                      adjustLayout: true,
                      child: pw.Image(swirlImage, width: 50)
                    ),
                  ),
                  pw.Positioned(bottom: 5, child: pw.Image(taglineImage, width: 180)),
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