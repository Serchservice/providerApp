import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class GenerateCertificateScreen extends StatefulWidget {
  const GenerateCertificateScreen({super.key});

  @override
  State<GenerateCertificateScreen> createState() => _GenerateCertificateScreenState();
}

class _GenerateCertificateScreenState extends State<GenerateCertificateScreen> {
  PrintingInfo? printingInfo;

  var _data = const CustomData();
  var _hasData = false;
  var _pending = false;
  bool doneAll = true;
  bool generated = true;

  Future<void> _saveAsFile(
    BuildContext context,
    LayoutCallback build,
    PdfPageFormat pageFormat,
  ) async {
    final bytes = await build(pageFormat);

    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    final file = File('$appDocPath/document.pdf');
    debugPrint('Save as file ${file.path} ...');
    await file.writeAsBytes(bytes);
    await OpenFilex.open(file.path);
  }

  void generateCert() async {
    final info = await Printing.info();
    // if (examples[_tab].needsData && !_hasData && !_pending) {
    //     _pending = true;
    //     askName(context).then((value) {
    //       if (value != null) {
    //         setState(() {
    //           _data = CustomData(name: value);
    //           _hasData = true;
    //           _pending = false;
    //         });
    //       }
    //     });
    //   }
    _pending = true;
    askName(context).then((value) {
      if (value != null) {
        setState(() {
          _data = CustomData(name: value);
          _hasData = true;
          _pending = false;
        });
      }
    });
    setState(() {
      printingInfo = info;
    });
  }

  Future<String?> askName(BuildContext context) {
    return showDialog<String>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        final controller = TextEditingController();

        return AlertDialog(
          title: const Text('Please type your name:'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          content: TextField(
            decoration: const InputDecoration(hintText: '[your name]'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (controller.text != '') {
                  Navigator.pop(context, controller.text);
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      }
    );
  }

  void _showPrintedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document printed successfully'),
      ),
    );
  }

  void _showSharedToast(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Document shared successfully'),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    pw.RichText.debug = true;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Generate certificate", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: CustomScrollView(
        slivers: [
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
                              SText(
                                text: "* Engage the least of 20 service trips",
                                color: Theme.of(context).backgroundColor,
                                size: 14
                              ),
                              const SizedBox(height: 5),
                              SText(
                                text: "* Have the least of 20 rates from your service trips",
                                color: Theme.of(context).backgroundColor,
                                size: 14
                              ),
                              const SizedBox(height: 5),
                              SText(
                                text: "* Run your account without being reported by any user",
                                color: Theme.of(context).backgroundColor,
                                size: 14
                              ),
                              const SizedBox(height: 5),
                              SText(
                                text: "* Be verified as a Serch service provider",
                                color: Theme.of(context).backgroundColor,
                                size: 14
                              ),
                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(height: 30),
                  // SizedBox(
                  //   height: 330,
                  //   child: PdfPreview(
                  //     build: (format) => examples.builder(format, _data),
                  //     onPrinted: _showPrintedToast,
                  //     onShared: _showSharedToast,
                  //   ),
                  // ),
                  const SkillCertificate(),
                  const SizedBox(height: 30),
                  if(doneAll)
                  SButton(
                    text: "Generate my certificate",
                    textSize: 16,
                    padding: const EdgeInsets.all(15),
                    width: Get.width,
                  ),
                  const SizedBox(height: 10),
                  if(generated)
                  SButton(
                    text: "Download my certificate",
                    textSize: 16,
                    padding: const EdgeInsets.all(15),
                    width: Get.width,
                    onClick: () => _saveAsFile,
                  )
                ]
              )
            ),
          ),
        ],
      )
    );
  }
}