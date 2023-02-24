import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:provide/lib.dart';

class Rundown{
  final String header;
  final String? body;
  final double? number;
  Rundown({required this.header, this.body, this.number});
}

class NoTripCount extends StatelessWidget {
  const NoTripCount({super.key});
  @override
  Widget build(BuildContext context) {
    UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
    UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
    UserRequestShare userRequestShare = HiveUserDatabase().getMyRequestShareData();
    List<UserReferralModel> userReferralList = HiveUserDatabase().getReferralDataList();
    List<Rundown> rundown = [
      Rundown(header: "Total Service Trip: ", body: userInformationModel.totalServiceTrips.toString()),
      Rundown(header: "Number of Shared: ", body: userInformationModel.totalShared.toString()),
      Rundown(header: "Number of Referrals: ", body: userReferralList.isEmpty ? "0" : userReferralList.length.toString()),
      Rundown(header: "Average Rate: ", number: double.parse(userInformationModel.totalRating))
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: SText(
              size: 22,
              text: "${greeting()}${userInformationModel.firstName}",
              weight: FontWeight.bold, color: Theme.of(context).primaryColor
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
              Stepping(lineH: 5), Stepping(lineH: 5)
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
                      text: Provider.of<UserMapInformation>(context).currentLocation.placeName.isNotEmpty
                      ? Provider.of<UserMapInformation>(context).currentLocation.placeName
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
              Stepping(lineH: 5), Stepping(lineH: 5)
            ],
          ),
          const SizedBox(height: 5),
          const SText(
            text: "Here's a little rundown of your account",
            color: SColors.hint, size: 16, weight: FontWeight.w600
          ),
          const SizedBox(height: 5),
          ...rundown.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Wrap(
                  children: [
                    SText(text: item.header, color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600),
                    item.body != null ? SText(
                      text: item.body!,
                      color: Theme.of(context).primaryColor, size: 16, weight: FontWeight.w600
                    ) : RatingBarIndicator(
                      rating: item.number!,
                      itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      itemCount: 5,
                      itemSize: 15.0,
                    ),
                  ]
                ),
              ],
            ),
          )),
          const SizedBox(height: 20),
          if(userServiceAndPlan.onRequestShare)
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
                    UserAvatar.medium(image: userRequestShare.rsImage),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SText(
                                text: "${userRequestShare.rsFirstName} ${userRequestShare.rsLastName}",
                                size: 18, weight: FontWeight.bold,
                                color: Theme.of(context).primaryColorLight
                              ),
                            )
                            ,
                          ],
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
                                onTap: () => endMyRequestShare(
                                  context: context, userRequestShare: userRequestShare,
                                  userInformationModel: userInformationModel, userServiceAndPlan: userServiceAndPlan
                                ),
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
          // Center(
          //   child: Container(
          //     padding: screenPadding,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       color: userInformationModel.totalServiceTrips ? SColors.red : trips.length < 5 ? SColors.yellow : SColors.green,
          //     ),
          //     child: SText(
          //       text: trips.isEmpty ? "Wishing you a good day today..."
          //       : trips.length < 5 ? "You've come a long way for the day..."
          //       : "What a day! Gotta go for more though...",
          //       color: SColors.white, size: 15, weight: FontWeight.bold
          //     )
          //   ),
          // ),
          // const SizedBox(height: 50),
        ]
      ),
    );
  }
}

class ConnectedProfile extends StatefulWidget {
  const ConnectedProfile({super.key});

  @override
  State<ConnectedProfile> createState() => _ConnectedProfileState();
}

class _ConnectedProfileState extends State<ConnectedProfile> {
  UserConnectedModel userConnectedModel = HiveUserDatabase().getConnectedData();
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  UserRequestShare userRequestShare = HiveUserDatabase().getOtherRequestShareData();
  UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            SText(
              text: "View your ongoing service trip",
              size: 16,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            UserAvatar.medium(image: userConnectedModel.avatar),
            const SizedBox(height: 10),
            RatingBarIndicator(
              rating: double.parse(userConnectedModel.rate),
              itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 15.0,
            ),
            const SizedBox(height: 5),
            SText.center(
              text: "${userConnectedModel.firstName} ${userConnectedModel.lastName}",
              size: 20, weight: FontWeight.bold,
              color: Theme.of(context).primaryColorLight
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Material(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SIcon(
                        icon: CupertinoIcons.phone_fill,
                        iconColor: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SIcon(
                        icon: CupertinoIcons.video_camera_solid,
                        iconColor: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SIcon(
                        icon: CupertinoIcons.bubble_left_bubble_right_fill,
                        iconColor: Theme.of(context).primaryColorLight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SText(
                      text: "Status: ",
                      size: 16, weight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight
                    ),
                    Icon(
                      userSettingModel.showOnMap ? CupertinoIcons.bolt_horizontal_circle_fill : CupertinoIcons.bolt_slash_fill,
                      color: userSettingModel.showOnMap ? SColors.green : SColors.yellow,
                      size: 16
                    ),
                    SText(
                      text: userSettingModel.showOnMap ? " Busy but online" : " Busy",
                      size: 16, weight: FontWeight.bold,
                      color: userSettingModel.showOnMap ? SColors.green : SColors.yellow,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SText(
                      text: "SWM Enabled: ",
                      size: 16, weight: FontWeight.bold,
                      color: Theme.of(context).primaryColorLight
                    ),
                    SText(
                      text: userSettingModel.swm ? "True" : "False",
                      size: 16, weight: FontWeight.bold,
                      color: userSettingModel.swm? SColors.green : SColors.red,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            if(userServiceAndPlan.onRequestShare)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SText(
                  text: "You've invited:",
                  size: 16, weight: FontWeight.bold,
                  color: Theme.of(context).primaryColorLight
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      UserAvatar.medium(image: userRequestShare.rsImage),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(
                            text: "${userRequestShare.rsFirstName} ${userRequestShare.rsLastName}",
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
                                  onTap: () => endOtherRequestShare(
                                    context: context, userRequestShare: userRequestShare,
                                    userInformationModel: userInformationModel, userServiceAndPlan: userServiceAndPlan
                                  ),
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
            Column(
              children: [
                SButton(
                  textSize: 16,
                  text: "Cancel Service",
                  padding: const EdgeInsets.all(10),
                  textWeight: FontWeight.bold,
                  onClick: () => cancelServiceTrip(
                    context: context, userInformationModel: userInformationModel, userConnectedModel: userConnectedModel
                  )
                ),
                const SizedBox(height: 10),
                SButton(
                  textSize: 16,
                  text: "End Service",
                  padding: const EdgeInsets.all(10),
                  textWeight: FontWeight.bold,
                  onClick: () => endServiceTrip(
                    context: context, userConnectedModel: userConnectedModel, userInformationModel: userInformationModel
                  )
                ),
                const SizedBox(height: 10),
                if(userServiceAndPlan.onRequestShare)
                Container()
                else
                SButton(
                  textSize: 16,
                  text: "RequestShare",
                  padding: const EdgeInsets.all(10),
                  textWeight: FontWeight.bold,
                  onClick: () => enableRequestShare(context)
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}