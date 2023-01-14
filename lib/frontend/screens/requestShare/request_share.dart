import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

void enableRequestShare({
  required BuildContext context,
  bool one = false,
  bool two = false,
  bool three = false,
}) {
  String text1 = "Plumber";
  String text2 = "Mechanic";
  String text3 = "Electrician";
  String text4 = "Barber";
  int selected = -1;

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    elevation: 0,
    builder:(context) => StatefulBuilder(
      builder:(context, setState) {
        void handleItemSelected(int index){
          setState(() {
            selected = index;
          });
        }

        return Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SText(
                            size: 22,
                            text: "Where are you sharing, ${currentUserInfo?.firstName}?",
                            weight: FontWeight.bold,
                            color: Theme.of(context).primaryColor
                          ),
                          SText(
                            size: 16,
                            weight: FontWeight.w600,
                            text: "Where and what do you need help with?",
                            color: Theme.of(context).primaryColorLight
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    spacing: 5,
                    runSpacing: 10,
                    children: [
                      SServiceContainer(
                        onTap: handleItemSelected,
                        index: 0,
                        selected: (selected == 0),
                        text: text1
                      ),
                      SServiceContainer(
                        onTap: handleItemSelected,
                        index: 1,
                        selected: (selected == 1),
                        text: text2
                      ),
                      SServiceContainer(
                        onTap: handleItemSelected,
                        index: 2,
                        selected: (selected == 2),
                        text: text3
                      ),
                      SServiceContainer(
                        onTap: handleItemSelected,
                        index: 3,
                        selected: (selected == 3),
                        text: text4
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Stepping(lineH: 5),
                    Stepping(lineH: 5)
                  ],
                ),
                const SizedBox(height: 10),
                Material(
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () => Get.to(() => SearchScreen(
                      selected: selected == 0 ? text1 : selected == 1 ? text2 : selected == 2 ? text3 : text4,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          Icon(CupertinoIcons.search, color: SColors.hint),
                          SizedBox(width: 10.0),
                          SText(text: "Enter your location", color: SColors.hint, weight: FontWeight.bold, size: 16)
                        ]
                      )
                    )
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }
    ),
  );
}

class RequestShareScreen extends StatefulWidget {
  const RequestShareScreen({super.key});

  @override
  State<RequestShareScreen> createState() => _RequestShareScreenState();
}

class _RequestShareScreenState extends State<RequestShareScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}