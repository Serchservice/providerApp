import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class UServiceCard extends StatefulWidget{
  final String title;
  final String image;
  final dynamic value;
  final double width;
  const UServiceCard({
    super.key, required this.title, required this.image, this.width = 50, this.value
  });

  @override
  State<UServiceCard> createState() => _UServiceCardState();
}

class _UServiceCardState extends State<UServiceCard> {
  addplan(context) async {
    await AuthIDB().addservice(
      service: widget.value == Services.barber ? "Barber"
      : widget.value == Services.electrician ? "Electrician"
      : widget.value == Services.mechanic ? "Mechanic"
      : "Plumber"
    );
    Get.offAll(() => const BottomNavigator());
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
            Image.asset(widget.image, width: widget.width),
            const SizedBox(height: 10),
            SText.center(text: widget.title, size: 18, weight: FontWeight.w900),
            const SizedBox(height: 10.0),
            SText.center(
              text: widget.title == "Electrician"
              ? "Enjoy more jobs on the go with your ${widget.title.toLowerCase().substring(0, 8)}al skills"
              : widget.title == "Plumber"
              ? "Enjoy more jobs on the go with your ${widget.title.toLowerCase().substring(0, 5)}ing skills"
              : widget.title == "Barber"
              ? "Enjoy more jobs on the go with your ${widget.title.toLowerCase().substring(0, 4)}ing skills"
              : "Enjoy more jobs on the go with your ${widget.title.toLowerCase()} skills"
            ),
          ],
        )
      ),
    );
  }
}

class UChooseServiceScreen extends StatefulWidget {
  const UChooseServiceScreen({super.key});

  @override
  State<UChooseServiceScreen> createState() => _UChooseServiceScreenState();
}

class _UChooseServiceScreenState extends State<UChooseServiceScreen> {

  @override
  void initState() {
    super.initState();
    SerchUser.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                      text: "Welcome ${currentUserInfo?.firstName},",
                      color: Theme.of(context).primaryColor,
                      size: 24,
                      weight: FontWeight.w900,
                    ),
                    const SizedBox(height: 5),
                    const SText(
                      text: "Get paid on your own terms by doing what you know and love doing.",
                      color: SColors.hint,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SText.center(
                  text: "What service would be providing for us?",
                  color: SColors.hint,
                  size: 18,
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: const [
                    UServiceCard(
                      title: "Electrician",
                      value: Services.electrician,
                      image: SImages.logo
                    ),
                    UServiceCard(
                      title: "Plumber",
                      value: Services.plumber,
                      image: SImages.logo
                    ),
                    UServiceCard(
                      title: "Barber",
                      value: Services.barber,
                      image: SImages.logo
                    ),
                    UServiceCard(
                      title: "Mechanic",
                      value: Services.mechanic,
                      image: SImages.logo
                    ),
                  ],
                ),
                const SizedBox(height: 20),
            ],
          ),
        ),
      )
    );
  }
}