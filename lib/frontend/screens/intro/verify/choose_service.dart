import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ChooseServiceScreen extends StatefulWidget {
  const ChooseServiceScreen({super.key});

  @override
  State<ChooseServiceScreen> createState() => _ChooseServiceScreenState();
}

class _ChooseServiceScreenState extends State<ChooseServiceScreen> {
  @override
  Widget build(BuildContext context) {
    String userFirstName = Provider.of<UserInformation>(context, listen: false).user.firstName ?? "";
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: "Welcome $userFirstName,",
                      color: Theme.of(context).focusColor,
                      size: 24,
                      weight: FontWeight.w900,
                    ),
                    const SizedBox(height: 5),
                    SText(
                      text: "Get paid on your own terms by doing what you know and love doing.",
                      color: Theme.of(context).primaryColorLight,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SText.center(
                  text: "Pick a service you are good with...",
                  color: Theme.of(context).primaryColorLight,
                  size: 18,
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: const [
                    SServiceCard(
                      title: "Electrician",
                      value: Services.electrician,
                      image: SImages.electrician
                    ),
                    SServiceCard(
                      title: "Plumber",
                      value: Services.plumber,
                      image: SImages.plumber
                    ),
                    SServiceCard(
                      title: "Barber",
                      value: Services.barber,
                      image: SImages.barber
                    ),
                    SServiceCard(
                      title: "Mechanic",
                      value: Services.mechanic,
                      image: SImages.mechanic
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SButtonText(
                  text: "Not sure on what skill to provide?",
                  textButton: "Skip this section for now",
                  onClick: () => Get.to(() => const AdditionalScreen()),
                  textColor: Theme.of(context).primaryColorLight,
                  textButtonColor: SColors.lightPurple,
                )
            ],
          ),
        ),
      )
    );
  }
}