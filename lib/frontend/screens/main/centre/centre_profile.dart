import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class CentreProfile extends StatefulWidget {
  const CentreProfile({super.key});

  @override
  State<CentreProfile> createState() => _CentreProfileState();
}

class _CentreProfileState extends State<CentreProfile> {
  @override
  Widget build(BuildContext context) {
    UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
    UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
    UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
    final width = MediaQuery.of(context).size.width;
    double height = 230;

    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          //Background Image for the Profile, Profile Picture, Service Symbol and Status
          Container(
            width: width,
            height: height - 80,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(SImages.centreOne),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Profile Picture and Status Checker
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0),
                      //Profile Image
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorLight, width: 1.2))
                        ),
                        child: Avatar.medium(
                          userInformationModel: userInformationModel,
                          onClick: () => openPictureDialog(context, userInformationModel),
                        )
                      ),
                    ),

                    //User Status Checker
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: SText(
                          text: userServiceAndPlan.status == "Online" || userSettingModel.alwaysOnline
                          ? "Online" : "Offline",
                          size: 14,
                          color: userServiceAndPlan.status == "Online" || userSettingModel.alwaysOnline
                          ? SColors.green : Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                  ]
                ),
              ],
            ),
          ),

          //Edit Profile Button
          Positioned(
            top: 130,
            right: 10,
            child: SButton(
              text: "Edit Profile",
              textSize: 14,
              borderRadius: 0,
              onClick: () => Get.to(() => const EditProfileScreen()),
              textWeight: FontWeight.bold,
              border: Border.all(width: 2, color: Theme.of(context).primaryColorDark),
              padding: const EdgeInsets.all(8),
              textColor: Theme.of(context).primaryColor,
              buttonColor: Theme.of(context).scaffoldBackgroundColor
            )
          ),
          Positioned(
            top: 160,
            child: //User fullName and email address
              Padding(
                padding: const EdgeInsets.only(left: 15.0, bottom: 5.0, top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SText(
                      text: "${userInformationModel.firstName} ${userInformationModel.lastName}",
                      size: 20,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor
                    ),
                    const SizedBox(width: 10),
                    SText(
                      text: userInformationModel.emailAddress,
                      size: 14,
                      weight: FontWeight.bold,
                      color: SColors.hint
                    ),
                  ],
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class ScheduledBox extends StatelessWidget{
  final UserScheduleModel user;
  const ScheduledBox({ super.key, required this.user});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 6.0),
      margin: const EdgeInsets.only(right: 4.0),
      decoration: BoxDecoration(
        color: SColors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          UserAvatar.small(image: user.schedulerImage),
          SText(text: user.scheduledTime, color: SColors.white, size: 14, weight: FontWeight.normal)
        ]
      )
    );
  }
}

class CentreOtherProfile extends StatefulWidget {
  const CentreOtherProfile({super.key});

  @override
  State<CentreOtherProfile> createState() => _CentreOtherProfileState();
}

class _CentreOtherProfileState extends State<CentreOtherProfile> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  late final Stream<List<UserScheduleModel>> _scheduledListStream;
  late final Stream<UserInformationModel> _ratingStream;

  @override
  void initState() {
    super.initState();
    _scheduledListStream = supabase.from(Supa().scheduled).stream(primaryKey: ['id']).eq("serchID", userInformationModel.serchID)
      .order('created_at').map((maps) => maps.map((map) => UserScheduleModel.fromMap(map)).toList());

    _ratingStream = supabase.from(Supa().profile).stream(primaryKey: ['id']).eq("serchAuth", userInformationModel.serchAuth).map(
      (maps) => maps.map((map) => UserInformationModel.fromMap(map)).toList()
    ).map((list) => list.first);
  }

  @override
  Widget build(BuildContext context) {
    Country country = countries.where((element) => element.name == userInformationModel.countryInfo.country).first;
    List<UserScheduleModel> schedulingList = HiveUserDatabase().getScheduleDataList();
    final phoneNumber = "${userInformationModel.phoneInfo.phoneCountryCode}${userInformationModel.phoneInfo.phone}";

    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: SColors.hint, width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Phone Number and Country Name and Flag
          const SizedBox(height: 3),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //User Phonenumber
              phoneNumber.isNotEmpty ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.phone,
                    color: SColors.hint,
                    size: 20
                  ),
                  const SizedBox(width: 5),
                  SButton(
                    text: phoneNumber,
                    textSize: 16,
                    onClick: () => WebFunctions.makePhoneCall(phoneNumber),
                    textWeight: FontWeight.bold,
                    textColor: Scolors.info,
                    buttonColor: Theme.of(context).scaffoldBackgroundColor
                  ),
                ],
              ) : Container(),
              const SizedBox(width: 8),
              //Country Name
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: SColors.lightPurple,
                    size: 20
                  ),
                  const SizedBox(width: 5),
                  SText(
                    text: country.name,
                    size: 16,
                    weight: FontWeight.bold,
                    color: SColors.hint
                  ),
                  const SizedBox(width: 5),
                  Image.asset(
                    flagImage(country.code.toLowerCase()),
                    width: 20,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          StreamBuilder<List<UserScheduleModel>>(
            stream: _scheduledListStream,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final scheduledList = snapshot.data!;
                return scheduledList.isEmpty ? Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const SText(
                    text: "List of scheduled service trips will appear here.",
                    color: SColors.hint,
                    weight: FontWeight.bold,
                    size: 12
                  )
                ) : SizedBox(
                  height: 33,
                  child: ListView.builder(
                    itemCount: scheduledList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ScheduledBox(user: scheduledList[index])
                  ),
                );
              } else {
                return schedulingList.isEmpty ? Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const SText(
                    text: "List of scheduled service trips will appear here.",
                    color: SColors.hint,
                    weight: FontWeight.bold,
                    size: 12
                  )
                ) : SizedBox(
                  height: 33,
                  child: ListView.builder(
                    itemCount: schedulingList.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ScheduledBox(user: schedulingList[index])
                  ),
                );
              }
            }
          ),
          const SizedBox(height: 10),
          //All about Rating
          StreamBuilder<UserInformationModel>(
            stream: _ratingStream,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                final rating = snapshot.data!;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(rating.totalRating),
                          itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 15.0,
                        ),
                        const SizedBox(height: 2),
                        const SText(
                          text: "Rate Stars",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 16
                        )
                      ]
                    ),
                    Column(
                      children: [
                        SText(
                          text: rating.totalRating.toString(),
                          size: 20,
                          color: Theme.of(context).primaryColor,
                          weight: FontWeight.bold,
                        ),
                        const SText(
                          text: "Rate Average",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 16
                        )
                      ]
                    ),
                    Column(
                      children: [
                        SText(
                          text: rating.numberOfRating.toString(),
                          size: 20,
                          weight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SText(
                          text: "Rate Count",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 16
                        )
                      ]
                    )
                  ]
                );
              } else if(snapshot.connectionState == ConnectionState.waiting) {
                return const ShimmerSerch(amount: 1);
              } else {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      children: [
                        RatingBarIndicator(
                          rating: double.parse(userInformationModel.totalRating),
                          itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                          itemCount: 5,
                          itemSize: 15.0,
                        ),
                        const SizedBox(height: 2),
                        const SText(
                          text: "Rate Stars",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 16
                        )
                      ]
                    ),
                    Column(
                      children: [
                        SText(
                          text: userInformationModel.totalRating.toString(),
                          size: 20,
                          color: Theme.of(context).primaryColor,
                          weight: FontWeight.bold,
                        ),
                        const SText(
                          text: "Rate Average",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 16
                        )
                      ]
                    ),
                    Column(
                      children: [
                        SText(
                          text: userInformationModel.numberOfRating.toString(),
                          size: 20,
                          weight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SText(
                          text: "Rate Count",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 16
                        )
                      ]
                    )
                  ]
                );
              }
            }
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}

void openPictureDialog(BuildContext context, UserInformationModel userInformationModel) {
  showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final imagePath = userInformationModel.avatar;
        final userImage = imagePath.contains("https://") ? NetworkImage(imagePath)
        : imagePath.startsWith("/") ? FileImage(File(imagePath)) : AssetImage(
          userInformationModel.service == "Electrician" ? SImages.manElectrician
          : userInformationModel.gender == "Female" && userInformationModel.service == "Electrician" ? SImages.womanElectrician
          : userInformationModel.service == "Plumber" ? SImages.manPlumber
          : userInformationModel.gender == "Female" && userInformationModel.service == "Plumber" ? SImages.manPlumber
          : userInformationModel.service == "Mechanic" ? SImages.manMechanic
          : userInformationModel.gender == "Female" && userInformationModel.service == "Mechanic" ? SImages.manMechanic
          : userInformationModel.gender == "Prefer Not to Say" && userInformationModel.service == "" ? SImages.noGender
          : userInformationModel.gender == "Female" && userInformationModel.service == "" ? SImages.woman
          : SImages.man
        );
        return SizedBox(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: userInformationModel.avatar.isEmpty ? SColors.darkTheme : null
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 500,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: userInformationModel.avatar.isEmpty ? BorderRadius.circular(0) : BorderRadius.circular(12),
                          color: userInformationModel.avatar.isEmpty ? SColors.darkTheme : null
                        ),
                        child: Image(
                          image: userImage as ImageProvider,
                          fit: BoxFit.cover, filterQuality: FilterQuality.high,
                        )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.wrap_text_outlined, color: SColors.white, size: 22,),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: SText(
                                    text: "${userInformationModel.firstName} ${userInformationModel.lastName}",
                                    color: SColors.white,
                                    size: 22,
                                    weight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                //Add verified symbol
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(Icons.work_history_outlined, color: SColors.white, size: 18,),
                                const SizedBox(width: 8),
                                SText(
                                  text: userInformationModel.service,
                                  color: SColors.white,
                                  size: 18,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SButton(
                text: "Edit Profile",
                textSize: 14,
                borderRadius: 16,
                onClick: () => Get.to(() => const EditProfileScreen()),
                textWeight: FontWeight.bold,
                width: Get.width - 25,
                padding: const EdgeInsets.all(16),
                textColor: SColors.white,
                buttonColor: SColors.lightPurple
              ),
              const SizedBox(height: 10),
            ]
          )
        );
      }
    )
  );
}