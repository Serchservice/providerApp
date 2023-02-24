import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TabWithImage extends StatelessWidget {
  final String settingHeader;
  final String? settingDetail;
  final String? image;
  final VoidCallback? onPressed;

  const TabWithImage({
    super.key,
    required this.settingHeader,
    this.settingDetail,
    this.image,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            if(image == null)
            Container()
            else
            Image.asset(image!, width: 40),
            const SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SText(
                    text: settingHeader,
                    size: 16,
                    weight: FontWeight.bold,
                    color: Theme.of(context).primaryColorLight
                  ),
                  if(settingDetail == null)
                  Container()
                  else
                  SText(text: settingDetail!, color: SColors.hint,)
                ],
              )
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 24,
              color: Theme.of(context).primaryColorLight
            )
          ],
        ),
      ),
    );
  }
}


class SetTab extends StatelessWidget {
  final String settingHeader;
  final String? settingDetail;
  final IconData? prefixIcon;
  final Color? iconColor;
  final VoidCallback? onPressed;
  final Widget? widget;

  const SetTab({
    super.key,
    required this.settingHeader,
    this.settingDetail,
    this.prefixIcon,
    this.onPressed,
    this.widget,
    this.iconColor
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      color: Theme.of(context).backgroundColor,
      child: InkWell(
        onTap: onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if(prefixIcon == null)
              Container()
              else
              Icon(prefixIcon!, color: iconColor ?? Theme.of(context).primaryColorLight, size: 28),
                const SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: settingHeader,
                      size: 18,
                      // weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                    const SizedBox(height: 2),
                    if(settingDetail == null)
                    Container()
                    else
                    SText(text: settingDetail!, color: SColors.hint,)
                  ],
                )
              ),
              if(widget == null)
              Container()
              else
              widget!
            ],
          ),
        ),
      ),
    );
  }
}

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

class SServiceCard extends StatefulWidget{
  final String title;
  final String image;
  final dynamic value;
  final double width;
  const SServiceCard({
    super.key, required this.title, required this.image, this.width = 50, this.value
  });

  @override
  State<SServiceCard> createState() => _SServiceCardState();
}

class _SServiceCardState extends State<SServiceCard> {
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
      Get.to(() => const AdditionalScreen());
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