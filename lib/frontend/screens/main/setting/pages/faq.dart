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
              text: "Frequently Asked Questions",
              size: 24,
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
            expandedHeight: 200,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  SetTab(
                    settingHeader: "Can my acccount be suspended?",
                    prefixIcon: CupertinoIcons.question_diamond,
                    settingDetail: "That would be so sad for us, but yes. Learn what can cause and how to avoid them.",
                    onPressed: () {}
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "How do I accept a user request?",
                    prefixIcon: FontAwesomeIcons.codePullRequest,
                    settingDetail: "Learn how to easily accept a user request.",
                    onPressed: () => launchUniversalLinkIos(launchLinkedIn)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Why is my rating low?",
                    prefixIcon: CupertinoIcons.t_bubble,
                    settingDetail: "Confused on why your rating is low? Learn more.",
                    onPressed: () => launchUniversalLinkIos(launchInstagram)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "I find it hard to share my images",
                    prefixIcon: CupertinoIcons.camera,
                    settingDetail: "Not just images, maybe videos and files too. Learn how to fix the issue.",
                    onPressed: () => launchUniversalLinkIos(launchTwitter)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Why can't I sign in?",
                    prefixIcon: FontAwesomeIcons.rightToBracket,
                    settingDetail: "Took you long to get back to the app? You can check some reasons causing it.",
                    onPressed: () => launchUniversalLinkIos(launchFacebook)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "How can I reset my password?",
                    prefixIcon: CupertinoIcons.pencil_ellipsis_rectangle,
                    settingDetail: "Forgetting your password is not something bad, not fixing it, is though.",
                    onPressed: () => launchMail("help@serchservice.com")
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Do I really need two-factor authentication?",
                    prefixIcon: CupertinoIcons.shield_lefthalf_fill,
                    settingDetail: "Confused on whether you need to turn on 2FA? We got your back. Learn more.",
                    onPressed: () => makePhoneCall("09164806343")
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "I Want to delete my Serch account",
                    prefixIcon: FontAwesomeIcons.trashCan,
                    settingDetail: "Learn how we delete your Serch account and how to get it done.",
                    onPressed: () => makePhoneCall("09164806343")
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "I can't seem to find the user I talked to",
                    prefixIcon: CupertinoIcons.bubble_middle_top,
                    settingDetail: "Oops! That is so bad. Want to why that happened? Learn more",
                    onPressed: () => makePhoneCall("09164806343")
                  ),
                  const SizedBox(height: 20),
                  const SButtonText(
                    text: "Can't find your problem?",
                    textButton: "Ask your question"
                  ),
                  const SizedBox(height: 10),
                  const SButtonText(
                    text: "Want to ask something else?",
                    textButton: "Talk to support"
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