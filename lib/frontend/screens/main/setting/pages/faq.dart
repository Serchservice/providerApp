import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class FAQSettingScreen extends StatefulWidget {
  const FAQSettingScreen({super.key});

  @override
  State<FAQSettingScreen> createState() => _FAQSettingScreenState();
}

class _FAQSettingScreenState extends State<FAQSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            title: SText.center(
              text: "Frequently Asked Questions", size: 24,
              weight: FontWeight.bold, color: Theme.of(context).primaryColorLight
            ),
            leading: IconButton(
              onPressed: () => Get.offAll(() => const BottomNavigator(newPage: 3)),
              icon: Icon(CupertinoIcons.chevron_back, color: Theme.of(context).primaryColorLight, size: 28)
            ),
            expandedHeight: 200,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Authentication FAQ",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  SetTab(
                    settingHeader: "Why can't I sign in?",
                    prefixIcon: FontAwesomeIcons.rightToBracket,
                    settingDetail: "Took you long to get back to the app? You can check some reasons causing it.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers/account-and-app-issues/Can't%20sign%20in%20or%20go%20online/1784713992d88627eb-c090-4598-8e33-a17f04"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "How can I reset my password?",
                    prefixIcon: CupertinoIcons.pencil_ellipsis_rectangle,
                    settingDetail: "Forgetting your password is not something bad, not fixing it, is though.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Do I really need two-factor authentication?",
                    prefixIcon: CupertinoIcons.shield_lefthalf_fill,
                    settingDetail: "Confused on whether you need to turn on 2FA? We got your back. Learn more.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers"
                    ))
                  ),
                ]
              )
            )
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Account FAQ",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  SetTab(
                    settingHeader: "Can my acccount be suspended?",
                    prefixIcon: CupertinoIcons.question_diamond,
                    settingDetail: "That would be so sad for us, but yes. Learn what can cause and how to avoid them.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers/account-and-app-issues/Can't%20sign%20in%20or%20go%20online/22018742449d12e0cc-273e-48c4-b3fb-a97439"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "How do I accept a user request?",
                    prefixIcon: FontAwesomeIcons.codePullRequest,
                    settingDetail: "Learn how to easily accept a user request.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Why is my rating low?",
                    prefixIcon: CupertinoIcons.t_bubble,
                    settingDetail: "Confused on why your rating is low? Learn more.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers/account-and-app-issues/Ratings%20and%20acceptance%20rates/2371167042526287df-472d-45fb-a0d3-9d7633"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "I find it hard to share my images",
                    prefixIcon: CupertinoIcons.camera,
                    settingDetail: "Not just images, maybe videos and files too. Learn how to fix the issue.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "I Want to delete my Serch account",
                    prefixIcon: FontAwesomeIcons.trashCan,
                    settingDetail: "Learn how we delete your Serch account and how to get it done.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "I can't seem to find the user I talked to",
                    prefixIcon: CupertinoIcons.bubble_middle_top,
                    settingDetail: "Oops! That is so bad. Want to why that happened? Learn more",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers"
                    ))
                  ),
                ]
              )
            )
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Earnings/Payment FAQ",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  SetTab(
                    settingHeader: "What do I gain from referring?",
                    prefixIcon: Icons.room_preferences,
                    settingDetail: "Our referral promo is targeted in giving you the best offers.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers/earnings-and-payment/Referrals/16997313008dfc523c-1dd4-42e5-b0cb-e40ffe"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "How can I get my promotions?",
                    prefixIcon: Icons.local_offer,
                    settingDetail: "Learn how to easily withdraw your promotions",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers/earnings-and-payment/Promotions/3838078520a1472e9d-837e-491d-8d27-97fb2c"
                    ))
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "My promotion was wrong",
                    prefixIcon: CupertinoIcons.projective,
                    settingDetail: "Find out what could be the issue and resolve it.",
                    onPressed: () => Get.to(() => const WebViewScreen(
                      url: "help.serchservice.com/providers/earnings-and-payment/Promotions/3370199391208a6c9-89e0-4443-8d3e-9a1a44"
                    ))
                  ),
                ]
              )
            )
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SButtonText(
                    text: "Can't find your problem?",
                    textColor: Theme.of(context).primaryColorLight,
                    textButton: "Ask your question",
                    onClick: () => Get.to(() => const AskQuestionScreen()),
                  ),
                  const SizedBox(height: 15),
                  SButtonText(
                    text: "Want to ask something else?",
                    textColor: Theme.of(context).primaryColorLight,
                    textButton: "Talk to support",
                    onClick: () => WebFunctions.launchMail(helpMail)
                  ),
                  const SizedBox(height: 40),
                ]
              )
            )
          ),
        ],
      )
    );
  }
}