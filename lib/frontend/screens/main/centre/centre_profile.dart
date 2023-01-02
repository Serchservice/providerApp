import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:provider/provider.dart';

class CentreProfile extends StatefulWidget {
  final Country selectedCountry;
  final double height;
  const CentreProfile({super.key, required this.selectedCountry, required this.height});

  @override
  State<CentreProfile> createState() => _CentreProfileState();
}

class _CentreProfileState extends State<CentreProfile> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    double height = 150;

    String userFirstName = Provider.of<UserInformation>(context, listen: false).user.firstName ?? "";
    String userLastName = Provider.of<UserInformation>(context, listen: false).user.lastName ?? "";
    String userEmailAddress = Provider.of<UserInformation>(context, listen: false).user.email ?? "";
    String userPhone = Provider.of<UserInformation>(context, listen: false).user.phone ?? "";
    String userStatus = Provider.of<UserServiceInformation>(context, listen: false).status;
    List<UserScheduledListModel> scheduledList = Provider.of<UserScheduleList>(context, listen: false).scheduledList ?? [];
    // UserScheduledListModel(scheduledImage: SImages.user, scheduledTime: "10.00am"),
    String userImage = Provider.of<UserInformation>(context, listen: false).user.image ?? "";
    double totalRating = Provider.of<UserRatingInformation>(context, listen: false).user.totalRating;
    double numberRated = Provider.of<UserRatingInformation>(context, listen: false).user.numberRated;

    String ratings(){
      if(numberRated.toInt() < 2){
        return "No rating yet";
      } else {
        return "${numberRated.toInt()} rating";
      }
    }

    return Container(
      height: widget.height,
      width: width,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).backgroundColor, width: 2))
      ),
      child: Stack(
        children: [
          //Background Image for the Profile, Profile Picture, Service Symbol and Status
          Container(
            width: width,
            height: height,
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
                      child: Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorLight, width: 1.2))
                            ),
                            child: Avatar.medium(image: userImage,)
                          ),
                          const Positioned(child: SSPicture.small())
                        ],
                      ),
                    ),
    
                    //User Status Checker
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: SText(
                          text: userStatus,
                          size: 14,
                          color: userStatus == "Online" ? SColors.green : Theme.of(context).backgroundColor
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
                padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SText(
                          text: "$userFirstName $userLastName",
                          size: 20,
                          weight: FontWeight.bold,
                          color: Theme.of(context).primaryColor
                        ),
                        const SizedBox(width: 5),
                        Image.asset(SImages.verified, width: 20),
                      ],
                    ),
                    const SizedBox(width: 10),
                    SText(
                      text: userEmailAddress,
                      size: 14,
                      weight: FontWeight.bold,
                      color: SColors.hint
                    ),
                  ],
                ),
              ),
          ),
          //Rating, Phone number, Country and Country Flag, Scheduled buttons
          Positioned(
            top: 210,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //All about Rating
                  Row(
                    children: [
                      //Rated Bar with Rating Badge
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(SImages.star, width: 24,),
                          RatingBar(
                            minRating: 1,
                            maxRating: 5,
                            itemSize: 15,
                            initialRating: totalRating,
                            allowHalfRating: true,
                            ratingWidget: RatingWidget(
                              full: const Icon(Icons.star, color: Colors.amber),
                              half: const Icon(Icons.star_half, color: Colors.amber),
                              empty: const Icon(Icons.star, color: Colors.grey)
                            ),
                            onRatingUpdate:(value) {},
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          Image.asset(SImages.medal, width: 24,),
                          SText(
                            text: totalRating.toString(),
                            size: 16,
                            color: SColors.hint
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(SImages.starBadge, width: 24,),
                          SText(
                            text: ratings(),
                            size: 16,
                            color: SColors.hint
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
    
                  //Phone Number and Country Name and Flag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //User Phonenumber
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.phone,
                            color: SColors.hint,
                            size: 20
                          ),
                          const SizedBox(width: 5),
                          SButton(
                            text: userPhone,
                            textSize: 16,
                            onClick: () => makePhoneCall(userPhone),
                            textWeight: FontWeight.bold,
                            textColor: Scolors.info,
                            buttonColor: Theme.of(context).scaffoldBackgroundColor
                          ),
                        ],
                      ),
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
                            text: widget.selectedCountry.name,
                            size: 16,
                            weight: FontWeight.bold,
                            color: SColors.hint
                          ),
                          const SizedBox(width: 5),
                          Image.asset(
                            flagImage(widget.selectedCountry.code.toLowerCase()),
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
    
                  //Scheduled List Buttons
                  if(scheduledList.isEmpty)
                  Container(
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
                  )
                  else
                  SizedBox(
                    height: 33,
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: ListView.builder(
                        itemCount: scheduledList.length,
                        physics: const AlwaysScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => ScheduledBox(user: scheduledList[index])
                      ),
                    ),
                  )
                ],
              ),
            )
          ),
    
        ],
      ),
    );
  }
}