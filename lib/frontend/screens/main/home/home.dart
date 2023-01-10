import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // DocumentReference? onlineStatus;
  bool location = false;
  bool online = false;
  String status = "Offline";

  @override
    void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkFirstRun(context));
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      FeatureDiscovery.discoverFeatures(
        context,
        const <String>{ // Feature ids for every feature that you want to showcase in order.
          featureStatus,
        },
      );
    });
  }

  Future toggleStatus() async {
    if(Provider.of<UserServiceInformation>(context, listen: false).model.status == "Online" || UserPreferences().getShowAlwaysOnline()){
      setState(() => status = "Offline");
      Provider.of<UserServiceInformation>(context, listen: false).updateStatus(newStatus: status);
    } else {
      setState(() => status = "Online");
      Provider.of<UserServiceInformation>(context, listen: false).updateStatus(newStatus: status);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 50,
        leading: DescribedFeatureOverlay(
          featureId: featureStatus,
          tapTarget: iconStatus,
          backgroundColor: Colors.purple,
          contentLocation: ContentLocation.below,
          title: const SText(text: "Status Toggler", weight: FontWeight.bold, size: 20),
          description: Column(
            children: [
              const SText(text: "Change between online status and busy.", weight: FontWeight.bold, size: 16),
              TextButton(
                onPressed: () async => FeatureDiscovery.completeCurrentStep(context),
                child: SButton(text: "Understood"),
              ),
              TextButton(
                onPressed: () => FeatureDiscovery.dismissAll(context),
                child: SButton(text: "Dismiss")
              ),
            ],
          ),
          child: Provider.of<UserServiceInformation>(context, listen: false).model.status == "Online" || UserPreferences().getShowAlwaysOnline()
          ? Material(
            color: SColors.green,
            child: InkWell(
              onTap: () => toggleStatus(),
              child: const Icon(
                CupertinoIcons.bolt_circle_fill,
                size: 28,
                color: SColors.white
              ),
            ),
          ) : Container()
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SlidingUpPanel(
        color: Theme.of(context).bottomAppBarColor,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        minHeight: 80.5,
        maxHeight: UserConnection().getOnTrip() ? 400 : 300,
        padding: const EdgeInsets.all(20),
        collapsed: SlideCollapsed(onTrip: UserConnection().getOnTrip(),),
        panel: SlidePanel(
          onTrip: UserConnection().getOnTrip(),
          cancelClick: () => showCancelReason(context: context),
          endClick: () => showRatingDialog(context: context, user: "Evaristus Adimonyemma"),
        ),
        body: HomeMap(
          width: width,
          height: height,
          online: online,
          toggleStatus: () => toggleStatus(),
        ),
      ),
    );
  }
}