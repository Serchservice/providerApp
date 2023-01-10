import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class RequestAccountInfoScreen extends StatefulWidget {
  const RequestAccountInfoScreen({super.key});

  @override
  State<RequestAccountInfoScreen> createState() => _RequestAccountInfoScreenState();
}

class _RequestAccountInfoScreenState extends State<RequestAccountInfoScreen> {
  bool sent = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Request account info", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: SColors.darkTheme4
                  ),
                  child: Image.asset(SImages.notes, width: 100)
                )
              ),
              const SizedBox(height: 20),
              SText(
                text: "Create a report of your Serch account information and setting. This report does not include your messages.",
                color: Theme.of(context).primaryColorLight,
              ),
              TextButton(
                onPressed: () {},
                child: const SText(
                  text: "Learn more",
                  weight: FontWeight.bold,
                  color: SColors.lightPurple,
                ),
              ),
              const SizedBox(height: 30),
              if(sent)
              Column(
                children: [
                  const SetTab(
                    settingHeader: "Request sent",
                    settingDetail: "Ready by January 5, 2023",
                    prefixIcon: Icons.timelapse,
                  ),
                  const SizedBox(height: 20),
                  SText(
                    text: "Your request will be canceled if you make changes to your account such as changing your email address, password or deleting your account.",
                    color: Theme.of(context).primaryColorLight,
                    size: 16
                  ),
                ],
              )
              else
              SetTab(
                settingHeader: "Request report",
                prefixIcon: Icons.notes,
                onPressed: () {},
              ),
            ],
          )
        )
      ),
    );
  }
}