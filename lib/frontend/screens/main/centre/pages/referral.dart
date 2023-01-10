import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:share_plus/share_plus.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final referLink = "https://serch.app/share-rytushgts";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: SText.center(
          text: "Referral Tree",
          size: 20,
          weight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Theme.of(context).primaryColorLight,
            size: 28
          )
        ),
        actions: [
          IconButton(
            // onPressed: () => showReferCode(context, CodeGenerator.generateCode("Serch-User-")),
            onPressed: () {
              showGetSnackbar(message: "Wait a moment", type: Popup.info);
              Share.share(referLink);
            },
            icon: Icon(
              CupertinoIcons.share,
              color: Theme.of(context).primaryColorLight,
              size: 28
            )
          ),
        ],
      ),
      body: ReferTree(referLink: referLink)
    );
  }
}