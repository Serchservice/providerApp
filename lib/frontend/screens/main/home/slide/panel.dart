import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

class SlidePanel extends StatelessWidget {
  final bool onTrip;
  final VoidCallback? cancelClick;
  final VoidCallback? endClick;
  const SlidePanel({super.key, this.onTrip = false, this.cancelClick, this.endClick});

  @override
  Widget build(BuildContext context) {
    return onTrip ? OnTripCount(
      cancelClick: cancelClick,
      endClick: endClick,
    ) : const NoTripCount();
  }
}

class NoTripCount extends StatefulWidget {
  const NoTripCount({super.key});

  @override
  State<NoTripCount> createState() => _NoTripCountState();
}

class _NoTripCountState extends State<NoTripCount> {
  @override
  Widget build(BuildContext context) {
    const trips = "4";
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: SText(
                size: 22,
                text: "${greeting()}${currentUserInfo?.firstName}",
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor
              ),
            ),
            const SizedBox(height: 5),
            SText(
              text: "Ready to start fixing problems with your skill?",
              color: Theme.of(context).primaryColorLight, size: 16, weight: FontWeight.w600
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Stepping(lineH: 5),
                Stepping(lineH: 5)
              ],
            ),
            const SizedBox(height: 5),
            const SText(
              text: "Here's your location:",
              color: SColors.hint, size: 16, weight: FontWeight.w600
            ),
            const SizedBox(height: 2),
            Material(
              color: SColors.virgo,
              borderRadius: BorderRadius.circular(3),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.home, color: SColors.hint),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: SText(
                        text: Provider.of<UserMapInformation>(context).currentLocation != null
                        ? Provider.of<UserMapInformation>(context).currentLocation!.placeName!
                        : "Add Home",
                        size: 16,
                        color: SColors.white
                      ),
                    ),
                  ]
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Stepping(lineH: 5),
                Stepping(lineH: 5)
              ],
            ),
            const SizedBox(height: 5),
            const SText(
              text: "Here's a little rundown of your day",
              color: SColors.hint, size: 16, weight: FontWeight.w600
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SText(text: "Today's Trip Count: ", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600),
                    SText(text: trips, color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600)
                  ]
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SText(text: "Number of Shared: ", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600),
                    SText(text: "0", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600)
                  ]
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SText(text: "Number of Referrals: ", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600),
                    SText(text: "4", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600)
                  ]
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SText(text: "Average Rate: ", color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600),
                    RatingBarIndicator(
                      rating: 3,
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 15.0,
                    ),
                  ]
                ),
              ],
            ),
            const SizedBox(height: 20),
            if(UserConnection().getOnRequestShare())
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SText(
                  text: "On an RS invited by:",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Picture.medium(),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(
                            text: "Evaristus Frank-Calvary",
                            size: 18, weight: FontWeight.bold,
                            color: Theme.of(context).primaryColorLight
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            alignment: WrapAlignment.spaceEvenly,
                            spacing: 20,
                            children: [
                              Material(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: (){},
                                  child: const SIcon(
                                    icon: CupertinoIcons.phone_fill,
                                    size: 20,
                                    iconColor: SColors.lightPurple,
                                  ),
                                ),
                              ),
                              Material(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: (){},
                                  child: const SIcon(
                                    icon: CupertinoIcons.video_camera_solid,
                                    size: 20,
                                    iconColor: SColors.lightPurple,
                                  ),
                                ),
                              ),
                              Material(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: (){},
                                  child: const SIcon(
                                    icon: CupertinoIcons.bubble_left_bubble_right_fill,
                                    size: 20,
                                    iconColor: SColors.lightPurple,
                                  ),
                                ),
                              ),
                              Material(
                                color: Theme.of(context).backgroundColor,
                                borderRadius: BorderRadius.circular(4),
                                child: InkWell(
                                  onTap: (){},
                                  child: const SIcon(
                                    icon: Icons.cancel,
                                    size: 20,
                                    iconColor: SColors.lightPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            Center(
              child: Container(
                padding: screenPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: trips.isEmpty ? SColors.red : trips.length < 5 ? SColors.yellow : SColors.green,
                ),
                child: SText(
                  text: trips.isEmpty ? "Wishing you a good day today..."
                  : trips.length < 5 ? "You've come a long way for the day..."
                  : "What a day! Gotta go for more though...",
                  color: SColors.white, size: 15, weight: FontWeight.bold
                )
              ),
            ),
            const SizedBox(height: 50),
          ]
        ),
      ),
    );
  }
}

class OnTripCount extends StatelessWidget {
  final VoidCallback? cancelClick;
  final VoidCallback? endClick;
  const OnTripCount({super.key, this.cancelClick, this.endClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SText(
              text: "View your ongoing service trip",
              size: 16,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            ConnectedProfile(
              serviceStatus: "Ongoing",
              swm: true,
              name: "Evaristus Adimonyemma",
              endClick: endClick,
              cancelClick: cancelClick,
            )
          ]
        )
      ),
    );
  }
}