import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:provide/lib.dart';

class SubscriptionScreen extends StatefulWidget{
  final int freeTrialDuration;
  const SubscriptionScreen({super.key, required this.freeTrialDuration});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();

  @override
  Widget build(BuildContext context) {
    String planName = userServiceAndPlan.plan.isEmpty ? "Free" : userServiceAndPlan.plan;
    var plan = serchPlans.singleWhere((plan) => plan.planName.contains(planName));
    String duration() {
      if (widget.freeTrialDuration >= 2) {
        return "${widget.freeTrialDuration} days remaining";
      } else if(widget.freeTrialDuration == 1){
        return "${widget.freeTrialDuration} day remaining";
      } else {
        return "Free trial is over";
      }
    }





    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 0.5,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                CupertinoIcons.chevron_back,
                color: Theme.of(context).primaryColorLight,
                size: 28
              )
            ),
            title: SText(
              text: "My Serch Plan",
              color: Theme.of(context).primaryColorLight,
              size: 30,
              weight: FontWeight.bold
            ),
            expandedHeight: 200,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Material(
                borderRadius: BorderRadius.circular(6),
                color: plan.bgColor,
                elevation: 1,
                shadowColor: Colors.black26,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(plan.planImage, width: 50),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SText(text: plan.planName, size: 20, weight: FontWeight.bold,),
                                plan.price.contains("No fees") ? SText(
                                  text: plan.price,
                                  size: 16, weight: FontWeight.bold,
                                ) : Text(
                                  CurrencyFormatter.formatter.format(double.parse(plan.price)),
                                  style: const TextStyle(
                                    fontFamily: "",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: SColors.white
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ...plan.content.map((content) => Padding(
                        padding: const EdgeInsets.only(left: 60, bottom: 5),
                        child: Row(children: [
                          Image.asset(SImages.checked, width: 15, color: SColors.white,),
                          const SizedBox(width: 5),
                          Expanded(child: SText(text: content, size: 16))
                        ]),
                      )).toList(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SText.right(
                            text: plan.planName.contains("Free") ? duration() : plan.duration,
                            size: 16, weight: FontWeight.bold
                          ),
                        ],
                      )
                    ]
                  ),
                ),
              )
            )
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const SText(
                  text: "Serch plans are designed to help you have a wonderful experience all throughout the whole tour, and we hope you mkae the right choice.",
                  color: SColors.hint,
                  weight: FontWeight.bold,
                  size: 12
                )
              )
            )
          ),
          if(plan.planName.contains("Free"))
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: SButton(
                text: "Feel like changing your plan? Click me",
                width: Get.width,
                padding: const EdgeInsets.all(10),
                textWeight: FontWeight.bold,
                textSize: 18,
                onClick: () => chooseNewPlan(context, userServiceAndPlan),
              ),
            ),
          )
          else
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const SText(
                      text: "NOTE: At the end of each subscription timeline, a button will appear below to enable you change your plan, if you feel like.",
                      color: SColors.hint,
                      weight: FontWeight.bold,
                      size: 12
                    )
                  ),
                  const SizedBox(height: 20),
                  if(widget.freeTrialDuration == 30)
                  SButton(
                    text: "Feel like changing your plan? Click me",
                    width: Get.width,
                    padding: const EdgeInsets.all(10),
                    textWeight: FontWeight.bold,
                    textSize: 18,
                    onClick: () => chooseNewPlan(context, userServiceAndPlan),
                  ),
                ]
              )
            )
          )
        ],
      )
    );
  }
}

void chooseNewPlan(BuildContext context, UserServiceAndPlan userServiceAndPlan) => showModalBottomSheet(
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  elevation: 1,
  isScrollControlled: true,
  context: context, builder: (context) {
    return StatefulBuilder(builder:(context, setState) {
      List<SerchPlan> plans = serchPlans;
      List<SerchPlan> filteredPlans = List<SerchPlan>.from(plans.where((element) => !element.planName.contains("Free")));

      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.chevron_left_rounded, color: Theme.of(context).primaryColor, size: 40,)
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, top: 6),
                    child: SText.center(
                      text: "Choose a new Serch Plan",
                      color: Theme.of(context).primaryColor,
                      size: 18,
                      weight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: userServiceAndPlan.freeTrial == "Done" || userServiceAndPlan.plan.contains("Free")
                ? filteredPlans.length : serchPlans.length,
                (context, index){
                  var plan = userServiceAndPlan.freeTrial == "Done" || userServiceAndPlan.plan.contains("Free")
                  ? filteredPlans[index] : serchPlans[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Material(
                      borderRadius: BorderRadius.circular(6),
                      color: plan.bgColor,
                      elevation: 1,
                      shadowColor: Colors.black26,
                      child: InkWell(
                        onTap:() => plan.planName.contains("Free")
                        ? Get.to(() => const FreeTrialActivatedScreen())
                        : openPayForm(context: context, selectedPlan: plan.planName),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(plan.planImage, width: 50,),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SText(text: plan.planName, size: 20, weight: FontWeight.bold,),
                                        plan.price.contains("No fees") ? SText(
                                          text: plan.price,
                                          size: 16, weight: FontWeight.bold,
                                        ) : Text(
                                          CurrencyFormatter.formatter.format(double.parse(plan.price)),
                                          style: const TextStyle(
                                            fontFamily: "",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            color: SColors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              ),
                              const SizedBox(height: 10),
                              ...plan.content.map((content) => Padding(
                                padding: const EdgeInsets.only(left: 60, bottom: 5),
                                child: Row(children: [
                                  Image.asset(SImages.checked, width: 15, color: SColors.white,),
                                  const SizedBox(width: 5),
                                  Expanded(child: SText(text: content, size: 16))
                                ]),
                              )).toList(),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SButton(
                                    text: "Get ${plan.planName}",
                                    padding: const EdgeInsets.all(8),
                                    textSize: 16, textWeight: FontWeight.bold,
                                    onClick: () => plan.planName.contains("Free")
                                    ? Get.offAll(() => const FreeTrialActivatedScreen())
                                    : openPayForm(context: context, selectedPlan: plan.planName),
                                  ),
                                  SText.right(text: plan.duration, size: 16, weight: FontWeight.bold,),
                                ],
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SButtonText(
                    text: "Need help selecting?",
                    textButton: "Read about Serch plans",
                    textColor: Theme.of(context).primaryColor,
                    textButtonColor: SColors.lightPurple,
                    onClick: () => Get.to(() => const WebViewScreen(url: "help.serchservice.com")),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor)),
                  )
                ],
              )
            ),
          )
        ],
      );
    });
  }
);