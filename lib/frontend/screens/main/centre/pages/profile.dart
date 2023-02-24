import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
    UserAdditionalModel userAdditionalModel = HiveUserDatabase().getAdditionalData();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              text: "My Contact Information",
              color: Theme.of(context).primaryColorLight,
              size: 30,
              weight: FontWeight.bold
            ),
            expandedHeight: 200,
          ),
          userAdditionalModel.country.isEmpty
          ? SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Material(
                  color: SColors.aqua,
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    onTap: () => Get.offAll(() => const AdditionalScreen()),
                    child: Container(
                      padding: screenPadding,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(SImages.layers, width: 50,),
                          const SizedBox(width: 10),
                          const Expanded(child: SText(
                            text: "You skipped out on the fun! Finish with your signup by tapping this box!",
                            color: SColors.white, size: 16, weight: FontWeight.bold
                          ))
                        ],
                      )
                    ),
                  ),
                ),
              ),
            )
          : SliverToBoxAdapter(
            child: Padding(
              padding: screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Basic Address
                  const SizedBox(height: 10,),
                  const SText(
                    text: "Basic Information.",
                    color: SColors.hint,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 110,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.stNo.toString(),
                          formName: "Street Number *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.stName,
                          formName: "Street Name *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.lga,
                          formName: "LGA (Optional)",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.landMark,
                          formName: "LandMark (Optional)",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.city,
                          formName: "Residential City *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 180,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.state,
                          formName: "State of Origin *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ],
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.country,
                    formName: "Residential Country *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),

                  const SizedBox(height: 20,),
                  //Email and Phone Number
                  const SText(
                    text: "Email Address and Phone Number",
                    color: SColors.hint,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10,),
                  SFormField(
                    enabled: false,
                    labelText: userInformationModel.emailAddress,
                    formName: "Email Address",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.emailAlternate,
                    formName: "Alternate Email",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: "${userInformationModel.phoneInfo.phoneCountryCode}${userInformationModel.phoneInfo.phone}",
                    formName: "Phone Number",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.emailAlternate,
                    formName: "Alternate Phone Number",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),

                  const SizedBox(height: 20,),
                  //Next of Kin
                  const SText(
                    text: "Next of Kin (This contact is for emergencies)",
                    color: SColors.hint,
                    size: 20,
                    weight: FontWeight.bold,
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 145,
                        child: SDropDown(
                          list: title,
                          hintText: userAdditionalModel.nokTitle,
                          formName: "Title *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          width: 170,
                          child: SDropDown(
                            list: relationship,
                            hintText: userAdditionalModel.nokRelationship,
                            formName: "Relationship *",
                            fillColor: Theme.of(context).scaffoldBackgroundColor,
                            formColor: Theme.of(context).primaryColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                      )
                      ,
                    ],
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.nokFirstName,
                    formName: "First Name *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.nokLastName,
                    formName: "Last Name *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.nokPhone,
                    formName: "Phone Number *",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  SFormField(
                    enabled: false,
                    labelText: userAdditionalModel.nokEmail,
                    formName: "Email Address (Optional)",
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    formStyle: STexts.normalForm(context),
                    formColor: Theme.of(context).primaryColor,
                    enabledBorderColor: Theme.of(context).backgroundColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.nokAddress,
                          formName: "Address *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.nokCity,
                          formName: "City *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.nokState,
                          formName: "State *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      ),
                      SizedBox(
                        width: 170,
                        child: SFormField(
                          enabled: false,
                          labelText: userAdditionalModel.nokCountry,
                          formName: "Country *",
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ),
        ],
      ),
    );
  }
}