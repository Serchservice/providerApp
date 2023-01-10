import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class CentreScreen extends StatefulWidget {
  final bool finishSignup;
  final String service;
  final String gender;
  final String phone;
  final bool verified;
  final Country selectedCountry;
  final String userAmount;
  const CentreScreen({
    super.key, required this.finishSignup, required this.service, required this.verified, required this.phone,
    required this.selectedCountry, required this.userAmount, required this.gender
  });

  @override
  State<CentreScreen> createState() => _CentreScreenState();
}

class _CentreScreenState extends State<CentreScreen> {
  ScrollController scroll = ScrollController();
  bool showMe = false;
  void openPermissions() {
    setState(() => showMe = !showMe);
    if(showMe == true){
      scroll.animateTo(scroll.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scroll,
      slivers: [
        SliverAppBar.medium(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: const CentreProfile(),
          expandedHeight: 170,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                CentreOtherProfile(selectedCountry: widget.selectedCountry),
                const SizedBox(height: 10,),
                //User selected Service and other information
                SUPB(
                  service: widget.service,
                  gender: widget.gender,
                  phone: widget.phone
                ),

                //Email Verification
                if (widget.verified == false) Column(
                  children: [
                    const SizedBox(height: 10,),
                    Material(
                      color: SColors.lightPurple,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () => openMail(),
                        child: Container(
                          padding: screenPadding,
                          child: Row(
                            children: [
                              Image.asset(SImages.emailVerify, width: 50,),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const  [
                                    SText(
                                      text: "Seems like you haven't verified your email. Tap this box to get it done!",
                                      color: SColors.white, size: 16, weight: FontWeight.bold
                                    ),
                                    SText(
                                      text: " Make sure to check spam too.",
                                      color: SColors.white, size: 16, weight: FontWeight.bold
                                    )
                                  ],
                                )
                              )
                            ],
                          )
                        ),
                      ),
                    ),
                  ],
                ),

                //Checking if user skipped additional information verification
                if (widget.finishSignup == false) Column(
                  children: [
                    const SizedBox(height: 10,),
                    Material(
                      color: SColors.aqua,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () => Get.offAll(() => const UAdditionalScreen()),
                        child: Container(
                          padding: screenPadding,
                          child: Row(
                            children: [
                              Image.asset(SImages.layers, width: 50,),
                              const SizedBox(width: 10),
                              const Expanded(child: SText(
                                text: "You skipped out on the fun! Finish with your signup by tapping this box!",
                                color: SColors.white, size: 16, weight: FontWeight.bold
                              ))
                            ],
                          )
                        ),
                      ),
                    ),
                  ],
                ),

                //User Tap2Fix Wallet
                const SizedBox(height: 10,),
                Material(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () => Get.to(() => Tip2FixWalletScreen(userAmount: widget.userAmount)),
                    child: Container(
                      padding: screenPadding,
                      child: Row(
                        children: [
                          Image.asset(SImages.wallet, width: 50,),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SText(
                                      text: "T2F Earnings: ",
                                      size: 18,
                                      weight: FontWeight.bold,
                                      color: Scolors.info
                                    ),
                                    SText(
                                      text: widget.userAmount,
                                      size: 18,
                                      weight: FontWeight.bold,
                                      color: Scolors.info
                                    ),
                                  ]
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SText(
                                      text: "Tap this box to view your wallet",
                                      size: 12,
                                      color: Theme.of(context).primaryColor
                                    ),
                                  ],
                                )
                              ]
                            ),
                          )
                        ],
                      )
                    ),
                  ),
                ),

                const SizedBox(height: 10,),
                SetTab(
                  settingHeader: "Rating Summary",
                  settingDetail: "See what people are saying about you.",
                  prefixIcon: CupertinoIcons.star_circle,
                  onPressed: () => Get.to(() => RatingScreen())
                ),
                const SizedBox(height: 10,),
                SetTab(
                  settingHeader: "Documents and Files",
                  settingDetail: "All files shared on your chat sessions.",
                  prefixIcon: CupertinoIcons.doc_on_clipboard,
                  onPressed: () => Get.to(() => DocsAndFilesScreen())
                ),
                const SizedBox(height: 10,),
                SetTab(
                  settingHeader: "My Profile",
                  settingDetail: "Details you provided to Serch on your person.",
                  prefixIcon: CupertinoIcons.doc_person,
                  onPressed: () => Get.to(() => const ProfileScreen())
                ),
                const SizedBox(height: 10,),
                SetTab(
                  settingHeader: "Referral tree",
                  settingDetail: "Your referrals and how big of a family you have.",
                  prefixIcon: CupertinoIcons.group,
                  onPressed: () => Get.to(() => const ReferralScreen())
                ),
                const SizedBox(height: 10,),
                SetTab(
                  settingHeader: "Request account info",
                  settingDetail: "Create a report of your Serch account information",
                  prefixIcon: CupertinoIcons.download_circle,
                  onPressed: () => Get.to(() => const RequestAccountInfoScreen())
                ),
                const SizedBox(height: 10,),
                SetTab(
                  prefixIcon: CupertinoIcons.power,
                  settingHeader: "Sign Out",
                  settingDetail: "Log out of Serch app. We would love to see you again.",
                  onPressed: () => openLogOutAccount(context)
                ),
                const SizedBox(height: 10,),
                SetTab(
                  prefixIcon: CupertinoIcons.trash,
                  settingHeader: "Delete",
                  settingDetail: "Remove your Serch account.",
                  onPressed: () => Get.to(() => const DeleteMyAccountScreen()),
                  // onPressed: () => openDeleteAccount(context)
                ),
                const SizedBox(height: 10,),

                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const SText(
                    text: "A list of permission Serch uses in making sure that you have a wonderful user experience.",
                    color: SColors.hint,
                    weight: FontWeight.bold,
                    size: 12
                  )
                ),
                const SizedBox(height: 10),
                Material(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: InkWell(
                    onTap: () => openPermissions(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: Row(
                        children: [
                          SText(
                            text: "Permissions",
                            size: 16,
                            weight: FontWeight.bold,
                            color: Theme.of(context).primaryColor
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).backgroundColor,
                              ),
                            )
                          ),
                          const SizedBox(width: 5),
                          Icon(showMe == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, size: 30, color: SColors.hint)
                        ]
                      ),
                    )
                  )
                ),
                if(showMe == true)
                const AllPermissions()
                else
                Container(),

                const SizedBox(height: 40),
                Center(
                  child: Image.asset(SImages.logoName, width: 130, color: Theme.of(context).primaryColor,),
                ),
                const SizedBox(height: 40),
              ]
            ),
          ),
        ),
      ],
    );
  }
}