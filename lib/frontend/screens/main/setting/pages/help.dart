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
                children: [
                  SetTab(
                    settingHeader: "Terms and Policy",
                    prefixIcon: CupertinoIcons.doc_richtext,
                    settingDetail: "Terms and conditions, privacy policy, etc",
                    onPressed: () => launchInWebViewOrVC(policies)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "LinkedIn",
                    prefixIcon: FontAwesomeIcons.linkedin,
                    settingDetail: "Follow us on linkedIn, join the community and make your suggestions.",
                    onPressed: () => launchUniversalLinkIos(launchLinkedIn)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Instagram",
                    prefixIcon: FontAwesomeIcons.instagram,
                    settingDetail: "Follow us on instagram, join the community and make your suggestions.",
                    onPressed: () => launchUniversalLinkIos(launchInstagram)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Twitter",
                    prefixIcon: FontAwesomeIcons.twitter,
                    settingDetail: "Follow us on twitter, join the community and make your suggestions.",
                    onPressed: () => launchUniversalLinkIos(launchTwitter)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Facebook",
                    prefixIcon: FontAwesomeIcons.facebook,
                    settingDetail: "Follow us on facebook, join the community and make your suggestions.",
                    onPressed: () => launchUniversalLinkIos(launchFacebook)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Youtube",
                    prefixIcon: FontAwesomeIcons.youtube,
                    settingDetail: "Connect with us on youtube, watch videos on our products and make comments.",
                    onPressed: () => launchUniversalLinkIos(launchYoutube)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "TikTok",
                    prefixIcon: FontAwesomeIcons.tiktok,
                    settingDetail: "Follow us on tiktok, watch videos on our products and make comments.",
                    onPressed: () => launchUniversalLinkIos(launchYoutube)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Mail",
                    prefixIcon: CupertinoIcons.mail_solid,
                    settingDetail: "Send us an email. We are with you 24 hours of the day.",
                    onPressed: () => launchMail(helpMail)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Call Centre",
                    prefixIcon: Icons.phone,
                    settingDetail: "Talk to our customer service today. Get all the help you need.",
                    onPressed: () => makePhoneCall(phoneCall)
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Safe-Guard Community",
                    prefixIcon: FontAwesomeIcons.helmetSafety,
                    settingDetail: "Join the SGC family and make your own contributions and suggestions.",
                    onPressed: () => launchUniversalLinkIos(launchDiscord)
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