import 'package:flutter/material.dart';
import 'package:provide/lib.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class ReferModelBox extends StatelessWidget {
  final ReferModel model;
  const ReferModelBox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(model.referredPicture == null)
              CircleAvatar(
                backgroundColor: SColors.lightPurple,
                radius: 20,
                child: SText(
                  text: "${model.referredFirstName.substring(0, 1)}${model.referredLastName.substring(0, 1)}",
                  color: SColors.white, size: 18
                ),
              )
              else
              CircleAvatar(
                foregroundImage: AssetImage(model.referredPicture!),
                backgroundColor: SColors.lightPurple,
                radius: 20,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SText(
                    text: "${model.referredFirstName} ${model.referredLastName}",
                    color: Theme.of(context).primaryColorLight, size: 18
                  ),
                  const SizedBox(width: 15),
                  SText(
                    text: model.referredStatus ? "Activated" : "Pending",
                    color: Theme.of(context).primaryColorLight, size: 14
                  ),
                ],
              ),
            ],
          ),
          Icon(
            model.referredStatus ? Icons.check_circle : Icons.access_time,
            size: 24, color: model.referredStatus ? Scolors.success : Scolors.silver ,
          )
        ],
      ),
    );
  }
}

class ReferTree extends StatefulWidget {
  final String referLink;
  const ReferTree({super.key, required this.referLink});

  @override
  State<ReferTree> createState() => _ReferTreeState();
}

class _ReferTreeState extends State<ReferTree> {
  List<ReferModel> referList = [
    ReferModel(referredFirstName: "Evaristus", referredLastName: "Adims", referredPicture: SImages.barb, referredStatus: false),
    ReferModel(referredFirstName: "Evaristus", referredLastName: "Adims", referredStatus: true),
    ReferModel(referredFirstName: "Evaristus", referredLastName: "Adims", referredPicture: SImages.barb, referredStatus: false),
    ReferModel(referredFirstName: "Evaristus", referredLastName: "Adims", referredStatus: false),
    ReferModel(referredFirstName: "Evaristus", referredLastName: "Adims", referredPicture: SImages.barb, referredStatus: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Avatar(radius: 40),
                    const SizedBox(width: 30),
                    SizedBox(
                      width: 100, height: 100,
                      child: PrettyQr(
                        typeNumber: 3,
                        size: 200,
                        data: widget.referLink,
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        roundEdges: true,
                        elementColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SText(
                        text: widget.referLink, color: SColors.hint,
                        size: 16, decoration: TextDecoration.underline,
                      ),
                      const SizedBox(width: 10),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => copy(widget.referLink),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            child: const Icon(
                              Icons.copy_rounded,
                              color: SColors.hint,
                              size: 20,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          if(referList.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 200.0),
            child: Center(
              child: SText(text: "You have no referrals yet", color: Theme.of(context).primaryColorLight, size: 16),
            ),
          )
          else
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) => ReferModelBox(model: referList[index]),
                  childCount: referList.length
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}