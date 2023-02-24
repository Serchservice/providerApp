import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class HelpSettingScreen extends StatefulWidget {
  const HelpSettingScreen({super.key});

  @override
  State<HelpSettingScreen> createState() => _HelpSettingScreenState();
}

class _HelpSettingScreenState extends State<HelpSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            title: SText.center(
              text: "Help Centre",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Help Section",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(context).backgroundColor
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Terms and Policy",
                          prefixIcon: CupertinoIcons.doc_richtext,
                          settingDetail: "Terms and conditions, privacy policy, etc",
                          onPressed: () => Get.to(() => WebViewScreen(uri: launchLocation, header: "Serch - T&C / Policies",))
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Ask Serch",
                          prefixIcon: Icons.question_mark,
                          settingDetail: "Got issues you want a direct response? Ask Serch",
                          onPressed: () => Get.to(() => const AskQuestionScreen())
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Mail",
                          prefixIcon: CupertinoIcons.mail_solid,
                          settingDetail: "Send us an email. We are with you 24 hours of the day.",
                          onPressed: () => WebFunctions.launchMail(helpMail)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Call Centre",
                          prefixIcon: Icons.phone,
                          settingDetail: "Talk to our customer service today. Get all the help you need.",
                          onPressed: () => WebFunctions.makePhoneCall(phoneCall)
                        ),
                      ]
                    )
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: SText(
                      text: "Media Section",
                      size: 18,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Theme.of(context).backgroundColor
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "LinkedIn",
                          prefixIcon: FontAwesomeIcons.linkedin,
                          settingDetail: "Follow us on linkedIn, join the community and make your suggestions.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchLinkedIn)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Instagram",
                          prefixIcon: FontAwesomeIcons.instagram,
                          settingDetail: "Follow us on instagram, join the community and make your suggestions.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchInstagram)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Twitter",
                          prefixIcon: FontAwesomeIcons.twitter,
                          settingDetail: "Follow us on twitter, join the community and make your suggestions.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchTwitter)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Facebook",
                          prefixIcon: FontAwesomeIcons.facebook,
                          settingDetail: "Follow us on facebook, join the community and make your suggestions.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchFacebook)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Youtube",
                          prefixIcon: FontAwesomeIcons.youtube,
                          settingDetail: "Connect with us on youtube, watch videos on our products and make comments.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchYoutube)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "TikTok",
                          prefixIcon: FontAwesomeIcons.tiktok,
                          settingDetail: "Follow us on tiktok, watch videos on our products and make comments.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchYoutube)
                        ),
                        const SizedBox(height: 10),
                        SetTab(
                          settingHeader: "Safe-Guard Community",
                          prefixIcon: FontAwesomeIcons.helmetSafety,
                          settingDetail: "Join the SGC family and make your own contributions and suggestions.",
                          onPressed: () => WebFunctions.launchUniversalLinkIos(launchDiscord)
                        ),
                      ]
                    )
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