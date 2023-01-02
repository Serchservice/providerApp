import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class AdditionalScreen extends StatefulWidget {
  const AdditionalScreen({super.key});

  @override
  State<AdditionalScreen> createState() => _AdditionalScreenState();
}

class _AdditionalScreenState extends State<AdditionalScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(160))
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            size: 24
                          )
                        ),
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        SImages.logo,
                        width: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                const AdditionalForm()
              ],
            )
          ),
        ),
      )
      : Column()
    );
  }
}