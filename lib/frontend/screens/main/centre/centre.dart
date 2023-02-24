import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CentreScreen extends StatefulWidget {
  final bool verified;
  const CentreScreen({super.key, required this.verified});

  @override
  State<CentreScreen> createState() => _CentreScreenState();
}

class _CentreScreenState extends State<CentreScreen> {
  ScrollController scroll = ScrollController();
  UserAdditionalModel userAdditionalModel = HiveUserDatabase().getAdditionalData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  late final Stream<UserInformationModel> _moneyStream;
  bool showMe = false;
  late int freeTrialDuration;

  void openPermissions() {
    setState(() => showMe = !showMe);
    if(showMe == true){
      scroll.animateTo(
        scroll.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut
      );
    }
  }

  void getFreeTrialDuration() async {
    try {
      final result = await supabase.from(Supa().serviceAndPlan).select().eq("serchID", userInformationModel.serchID).single() as Map;
      // Convert the string representation of the created_at timestamp to a DateTime object
      DateTime createdAtDate = TimeFormatter.supabaseDateParser.parse(result["created_at"]);
      // Get the current date and time
      DateTime now = DateTime.now();
      // Calculate the difference in days between the created_at timestamp and the current date
      freeTrialDuration = 13 - now.difference(createdAtDate).inDays;
    } on PostgrestException catch (e) {
      freeTrialDuration = 0;
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  @override
  void initState() {
    super.initState();
    getFreeTrialDuration();
    Initializers().getRateLists(userInformationModel);

    _moneyStream = supabase.from(Supa().profile).stream(primaryKey: ['id']).eq("serchAuth", userInformationModel.serchAuth).map(
      (maps) => maps.map((map) => UserInformationModel.fromMap(map)).toList()
    ).map((list) => list.first);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scroll,
      slivers: [
        SliverAppBar.medium(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: const CentreProfile(),
          expandedHeight: 200,
          collapsedHeight: 80,
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                const CentreOtherProfile(),
                const SizedBox(height: 10,),

                //Email Verification
                if (widget.verified == false) Column(
                  children: [
                    const SizedBox(height: 10,),
                    Material(
                      color: SColors.lightPurple,
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () => WebFunctions.openMail(),
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
                if (userAdditionalModel.nokFirstName.isEmpty) Column(
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
                    onTap: () => Get.to(() => const Tip2FixWalletScreen()),
                    child: Container(
                      padding: screenPadding,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(SImages.wallet, width: 50,),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                StreamBuilder<UserInformationModel>(
                                  stream: _moneyStream,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                      final money = snapshot.data!;
                                      return Text(
                                        // "₦${plan.price}",
                                        "T2F Earnings: ${CurrencyFormatter.formatter.format(double.parse(money.balance))}",
                                        style: const TextStyle(
                                          fontFamily: "",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Scolors.info
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        // "₦${plan.price}",
                                        "T2F Earnings: ${CurrencyFormatter.formatter.format(double.parse(userInformationModel.balance))}",
                                        style: const TextStyle(
                                          fontFamily: "",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Scolors.info
                                        ),
                                      );
                                    }
                                  }
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SText.right(
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
                  settingHeader: "My Serch Plan",
                  settingDetail: "Your subscription plan and how to change it.",
                  prefixIcon: Icons.subscriptions_outlined,
                  onPressed: () => Get.to(() => SubscriptionScreen(freeTrialDuration: freeTrialDuration,))
                ),
                const SizedBox(height: 10,),
                SetTab(
                  settingHeader: "My Bookmarkers",
                  settingDetail: "Continue the conversation with who bookmarked you.",
                  prefixIcon: Icons.bookmarks_outlined,
                  onPressed: () => Get.to(() => const BookmarkerScreen())
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
                  settingHeader: "Skill certificate",
                  settingDetail: "Generate a reusable certificate for any place",
                  prefixIcon: Icons.file_present_outlined,
                  onPressed: () => Get.to(() => const GenerateCertificateScreen())
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
                const SizedBox(height: 50),
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
                Center(child: Image.asset(SImages.logoName, width: 130, color: Theme.of(context).primaryColor)),
                const SizedBox(height: 40),
              ]
            ),
          ),
        ),
      ],
    );
  }
}