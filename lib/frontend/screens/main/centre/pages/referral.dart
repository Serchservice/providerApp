import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  List<UserReferralModel> userReferrals = HiveUserDatabase().getReferralDataList();
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
            onPressed: () {
              showDialog(context: context, barrierDismissible: false, builder:(context) {
                return SLoader.fallingDot();
              });
              Share.share(userInformationModel.referLink);
              Navigator.of(context).pop();
            },
            icon: Icon(
              CupertinoIcons.share,
              color: Theme.of(context).primaryColorLight,
              size: 28
            )
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Column(
                children: [
                  SizedBox(
                    width: 150, height: 150,
                    child: PrettyQr(
                      typeNumber: 3,
                      size: 250,
                      data: userInformationModel.referLink,
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      roundEdges: true,
                      elementColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).backgroundColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SText(
                          text: userInformationModel.referLink, color: Theme.of(context).primaryColor,
                          size: 16, decoration: TextDecoration.underline,
                        ),
                        const SizedBox(width: 10),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => copy(userInformationModel.referLink),
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: const Icon(
                                Icons.copy_rounded,
                                color: SColors.hint,
                                size: 20,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
          if(userReferrals.isEmpty)
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 200.0),
            sliver: SliverToBoxAdapter(
              child: Center(child: SText(text: "You have no referrals yet", color: Theme.of(context).primaryColorLight, size: 20)),
            ),
          )
          else
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) => ReferModelBox(model: userReferrals[index]),
            childCount: userReferrals.length
            )
          )
        ],
      )
    );
  }
}


class ReferModelBox extends StatelessWidget {
  final UserReferralModel model;
  const ReferModelBox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UserAvatar.small(image: model.referredImage),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SText(
                    text: "${model.referredFirstName} ${model.referredLastName}",
                    color: Theme.of(context).primaryColorLight, size: 18
                  ),
                  const SizedBox(height: 5),
                  SText(
                    text: model.referredStatus,
                    color: Theme.of(context).primaryColorLight, size: 14
                  ),
                ],
              ),
            ],
          ),
          Icon(
            model.referredStatus == "Pending" ? Icons.check_circle : Icons.access_time,
            size: 24, color: model.referredStatus == "Pending" ? Scolors.success : Scolors.silver ,
          )
        ],
      ),
    );
  }
}