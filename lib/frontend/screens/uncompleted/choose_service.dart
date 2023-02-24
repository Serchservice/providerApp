import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  bool loading = false;

  Future<void> addplan(context) async {
    setState(() => loading = true);
    try{
      final userID = supabase.auth.currentUser;
      await supabase.from(Supa().profile).update({"service": widget.value == Services.electrician ? "Electrician"
        : widget.value == Services.mechanic ? "Mechanic" : "Plumber"}).eq("serchAuth", userID!.id);
      final result = await supabase.from(Supa().profile).select().eq("serchAuth", userID.id).single() as Map;
      final serchData = UserInformationModel.fromJson(result as Map<String, dynamic>);
      HiveUserDatabase().saveProfileData(serchData);
      setState(() => loading = false);
      Get.to(() => const BottomNavigator());
    } on PostgrestException catch (e) {
      showGetSnackbar(
        message: e.message,
        type: Popup.error,
        duration: const Duration(seconds: 3)
      );
      setState(() => loading = false);
    }
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
          color: SColors.darkTheme1,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Image.asset(widget.image, width: widget.width),
            const SizedBox(height: 10),
            SText.center(text: widget.title, size: 18, weight: FontWeight.w900),
            const SizedBox(height: 10.0),
            loading ? Center(child: SLoader.fallingDot(size: 55)) : SText.center(
              text: widget.title == "Electrician"
              ? "Enjoy more jobs on the go with your ${widget.title.toLowerCase().substring(0, 8)}al skills"
              : widget.title == "Plumber"
              ? "Enjoy more jobs on the go with your ${widget.title.toLowerCase().substring(0, 5)}ing skills"
              : "Enjoy more jobs on the go with your ${widget.title.toLowerCase()} skills"
            ),
          ],
        )
      ),
    );
  }
}

class UChooseServiceScreen extends StatelessWidget {
  const UChooseServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserInformationModel data = HiveUserDatabase().getProfileData();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    UServiceCard(
                      title: "Electrician",
                      value: Services.electrician,
                      image: SImages.electrician
                    ),
                    UServiceCard(
                      title: "Plumber",
                      value: Services.plumber,
                      image: SImages.plumber
                    ),
                    UServiceCard(
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