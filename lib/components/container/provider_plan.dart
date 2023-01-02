import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class SUPB extends StatelessWidget {
  final String? service;
  final String gender;
  final String phone;
  const SUPB({super.key, this.service, required this.gender, required this.phone});

  @override
  Widget build(BuildContext context) {
    if(service!.isNotEmpty && service != null){
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: service == "Electrician" ? SColors.blue
            : service == "Mechanic" ? SColors.aqua
            : service == "Plumber" ? SColors.libra
            : service == "Barber" ?  SColors.virgo
            : Theme.of(context).primaryColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              service == "Electrician" ? SImages.electrician
              : service == "Mechanic" ? SImages.mechanic
              : service == "Plumber" ? SImages.plumber
              : service == "Barber" ? SImages.barber
              : SImages.user,
              width: 50,
            ),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SText(
                  text: "Service: $service",
                  size: 15, weight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                SText(
                  text: "Gender: $gender",
                  size: 15, weight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor
                ),
                SText(
                  text: "Phone Number: $phone",
                  size: 15, weight: FontWeight.bold,
                  color: Theme.of(context).scaffoldBackgroundColor
                )
              ],
            ),
          ],
        )
      );
    } else {
        return Material(
        color: SColors.aries,
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          onTap: () => Get.to(() => const UChooseServiceScreen()),
          child: Container(
            padding: screenPadding,
            child: Row(
              children: [
                Image.asset(SImages.error, width: 50,),
                const SizedBox(width: 10),
                const Expanded(child: SText(
                  text: "Without your skill, how can you make money? Tap this box to select a skill!",
                  color: SColors.white, size: 16, weight: FontWeight.bold
                ))
              ],
            )
          ),
        ),
      );
    }
  }
}

class SServiceCard extends StatelessWidget{
  final String title;
  final String image;
  final dynamic value;
  final double width;
  const SServiceCard({
    super.key, required this.title, required this.image, this.width = 50, this.value
  });

  addplan(context) async {
    await AuthIDB().addservice(
      service: value == Services.barber ? "Barber"
      : value == Services.electrician ? "Electrician"
      : value == Services.mechanic ? "Mechanic"
      : "Plumber"
    );
    Get.to(() => const AdditionalScreen());
  }

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: () => addplan(context),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(5.0),
        width: 100,
        decoration: BoxDecoration(
          color: SColors.blue,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Image.asset(image, width: width),
            const SizedBox(height: 10),
            SText.center(text: title, size: 18, weight: FontWeight.w900),
            const SizedBox(height: 10.0),
            SText.center(
              text: title == "Electrician"
              ? "Enjoy more jobs on the go with your ${title.toLowerCase().substring(0, 8)}al skills"
              : title == "Plumber"
              ? "Enjoy more jobs on the go with your ${title.toLowerCase().substring(0, 5)}ing skills"
              : title == "Barber"
              ? "Enjoy more jobs on the go with your ${title.toLowerCase().substring(0, 4)}ing skills"
              : "Enjoy more jobs on the go with your ${title.toLowerCase()} skills"
            ),
          ],
        )
      ),
    );
  }
}

