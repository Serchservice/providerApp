import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SlideCollapsed extends StatelessWidget {
  const SlideCollapsed({super.key});

  @override
  Widget build(BuildContext context) {
    UserConnectedModel userConnectedModel = HiveUserDatabase().getConnectedData();
    UserServiceAndPlan userServiceAndPlan = HiveUserDatabase().getServiceAndPlanData();
    const padded = EdgeInsets.symmetric(vertical: 1);
    const padding = EdgeInsets.symmetric(vertical: 6, horizontal: 10);

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Padding(padding: padded, child: Container(color: SColors.hint, height: 4, width: 100)),
          userServiceAndPlan.onTrip ? SFadeOutIn<String>(
            initialData: statements(),
            data: "You are on a service trip with ${userConnectedModel.firstName}",
            builder: (data) => Padding(padding: padding, child: SText.center(text: data, color: Theme.of(context).primaryColor, size: 16)),
            duration: const Duration(milliseconds: 1800),
          ) : Padding(
            padding: padding,
            child: SText.center(
              text: statements(),
              color: Theme.of(context).primaryColor,
              size: 16,
              weight: FontWeight.w600
            )
          ),
        ],
      ),
    );
  }
}