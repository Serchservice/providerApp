import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ChooseServiceScreen extends StatelessWidget {
  const ChooseServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserInformationModel data = HiveUserDatabase().getProfileData();
    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      SImages.logo,
                      width: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                SText(
                  text: "Welcome ${data.firstName},",
                  color: Theme.of(context).focusColor,
                  size: 26,
                  weight: FontWeight.w900,
                ),
                const SizedBox(height: 5),
                SText(
                  text: "Get paid on your own terms by doing what you know and love doing.",
                  color: Theme.of(context).primaryColorLight,
                  size: 18,
                ),
                const SizedBox(height: 30),
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
                      title: "Mechanic",
                      value: Services.mechanic,
                      image: SImages.mechanic
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
            Column(
              children: [
                SButtonText(
                  text: "Not sure on what skill to provide?",
                  textButton: "Skip this section for now",
                  onClick: () => Get.to(() => const AdditionalScreen()),
                  textColor: Theme.of(context).primaryColorLight,
                  textButtonColor: SColors.lightPurple,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                )
              ],
            )
          ],
        ),
      )
    );
  }
}