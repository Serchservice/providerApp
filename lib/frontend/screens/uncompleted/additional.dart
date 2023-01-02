import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class UAdditionalScreen extends StatefulWidget {
  const UAdditionalScreen({super.key});

  @override
  State<UAdditionalScreen> createState() => _UAdditionalScreenState();
}

class _UAdditionalScreenState extends State<UAdditionalScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                const UAdditionalForm()
              ],
            )
          ),
        ),
      )
      : Column()
    );
  }
}

class UAdditionalForm extends StatefulWidget {
  const UAdditionalForm({Key? key}) : super(key: key);

  @override
  State<UAdditionalForm> createState() => _UAdditionalFormState();
}

class _UAdditionalFormState extends State<UAdditionalForm> {
  final _formKey = GlobalKey<FormState>();
  // final user = FbAuth().currentUser;
  String? titled, relation;

  TextEditingController streetNumber = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController lga = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController userCity = TextEditingController();
  TextEditingController stateOfOrigin = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController emailAlternate = TextEditingController();
  TextEditingController alternatePhoneNumber = TextEditingController();
  TextEditingController nokFirstName = TextEditingController();
  TextEditingController nokLastName = TextEditingController();
  TextEditingController nokEmailAddress = TextEditingController();
  TextEditingController nokPhoneNumber = TextEditingController();
  TextEditingController nokAddress = TextEditingController();
  TextEditingController nokCity = TextEditingController();
  TextEditingController nokState = TextEditingController();
  TextEditingController nokCountry = TextEditingController();

  void validate(context) async {
    if(!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:(context) => SLoader.fallingDot(color: Theme.of(context).scaffoldBackgroundColor, size: 70),
    );
    await AuthIDB().addform(
      streetNumber: streetNumber.text.trim(), streetName: streetName.text.trim(), lga: lga.text.trim(),
      landMark: landMark.text.trim(), userCity: userCity.text.trim(), stateOfOrigin: stateOfOrigin.text.trim(),
      country: country.text.trim(), emailAlternate: emailAlternate.text.trim(), alternatePhoneNumber: alternatePhoneNumber.text.trim(),
      nokTitle: titled.toString(), nokRelationship: relation.toString(), nokFirstName: nokFirstName.text.trim(),
      nokLastName: nokLastName.text.trim(), nokEmailAddress: nokEmailAddress.text.trim(), nokPhoneNumber: nokPhoneNumber.text.trim(),
      nokAddress: nokAddress.text.trim(), nokCity: nokCity.text.trim(), nokState: nokState.text.trim(), nokCountry: nokCountry.text.trim(),
    );
    Navigator.pop(context);
    Get.offAll(() => const BottomNavigator());
  }

  @override
  void initState() {
    super.initState();
    SerchUser.getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          SText(
            text: "Hey ${currentUserInfo?.firstName},",
            color: Theme.of(context).scaffoldBackgroundColor,
            size: 22,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 3),
          SText(
            text: "You are almost done!. Let's cross together.",
            color: Theme.of(context).scaffoldBackgroundColor,
            size: 16,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 10,),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Basic Address
                    const SizedBox(height: 10,),
                    SText(
                      text: "Basic Information.",
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 110,
                          child: SFormField(
                            labelText: "12",
                            formName: "Street Number *",
                            controller: streetNumber,
                            validate: AdditionalValidators.streetNumber,
                            keyboard: TextInputType.number,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: SFormField(
                            labelText: "Frank Stuart Street",
                            formName: "Street Name *",
                            controller: streetName,
                            validate: AdditionalValidators.streetName,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: SFormField(
                            labelText: "Standing Local Government Area",
                            formName: "LGA (Optional)",
                            controller: lga,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: SFormField(
                            labelText: "12001",
                            formName: "LandMark (Optional)",
                            controller: landMark,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 120,
                          child: SFormField(
                            labelText: "Dulphin",
                            formName: "Residential City *",
                            controller: userCity,
                            validate: AdditionalValidators.userCity,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          child: SFormField(
                            labelText: "Lagos",
                            formName: "State of Origin *",
                            controller: stateOfOrigin,
                            validate: AdditionalValidators.userState,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "Nigeria",
                      formName: "Residential Country *",
                      controller: country,
                      validate: AdditionalValidators.userCountry,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),

                    //Email and Phone Number
                    const SizedBox(height: 20,),
                    SText(
                      text: "Email Address and Phone Number",
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10,),
                    SFormField(
                      labelText: currentUserInfo?.emailAddress,
                      formName: "Email Address",
                      enabled: false,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "johndoe@email.com",
                      formName: "Alternate Email",
                      controller: emailAlternate,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: currentUserInfo?.phoneNumber,
                      formName: "Phone Number",
                      enabled: false,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "000 - 0234 - 0909",
                      formName: "Alternate Phone Number",
                      controller: alternatePhoneNumber,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),

                    //Next of Kin
                    const SizedBox(height: 20,),
                    SText(
                      text: "Next of Kin (This contact is for emergencies)",
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 145,
                          child: SDropDown(
                            list: title,
                            hintText: "Next of Kin Title",
                            formName: "Title *",
                            validate: AdditionalValidators.title,
                            onChanged: (value) => setState(() => titled = value.toString()),
                            onSaved: (value) => setState(() => titled = value.toString()),
                            fillColor: Theme.of(context).primaryColor,
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            width: 170,
                            child: SDropDown(
                              list: relationship,
                              hintText: "How are you related?",
                              formName: "Relationship *",
                              validate: AdditionalValidators.title,
                              onChanged: (value) => setState(() => relation = value.toString()),
                              onSaved: (value) => setState(() => relation = value.toString()),
                              fillColor: Theme.of(context).primaryColor,
                              formColor: Theme.of(context).scaffoldBackgroundColor,
                              enabledBorderColor: Theme.of(context).backgroundColor,
                            ),
                          ),
                        )
                        ,
                      ],
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "John",
                      formName: "First Name *",
                      controller: nokFirstName,
                      validate: Validators.name,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "Doe",
                      formName: "Last Name *",
                      controller: nokLastName,
                      validate: Validators.name,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "000 - 1242 - 098",
                      formName: "Phone Number *",
                      controller: nokPhoneNumber,
                      validate: Validators.phone,
                      keyboard: TextInputType.number,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    SFormField(
                      labelText: "johndoe@goserch.com",
                      formName: "Email Address (Optional)",
                      controller: nokEmailAddress,
                      cursorColor: Theme.of(context).scaffoldBackgroundColor,
                      fillColor: Theme.of(context).primaryColor,
                      formStyle: STexts.authForm(context),
                      formColor: Theme.of(context).scaffoldBackgroundColor,
                      enabledBorderColor: Theme.of(context).backgroundColor,
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 160,
                          child: SFormField(
                            labelText: "No. 4 Frankie Street, Duplmos",
                            formName: "Address *",
                            controller: nokAddress,
                            validate: AdditionalValidators.address,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: SFormField(
                            labelText: "Calry",
                            formName: "City *",
                            controller: nokCity,
                            validate: AdditionalValidators.userCity,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          child: SFormField(
                            labelText: "Lagos",
                            formName: "State *",
                            controller: nokState,
                            validate: AdditionalValidators.userState,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: 170,
                          child: SFormField(
                            labelText: "Nigeria",
                            formName: "Country *",
                            controller: nokCountry,
                            validate: AdditionalValidators.userCountry,
                            cursorColor: Theme.of(context).scaffoldBackgroundColor,
                            fillColor: Theme.of(context).primaryColor,
                            formStyle: STexts.authForm(context),
                            formColor: Theme.of(context).scaffoldBackgroundColor,
                            enabledBorderColor: Theme.of(context).backgroundColor,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 50,),
                  ],
                ),
                SButton(
                  onClick: () => validate(context),
                  text: "Finish",
                  width: width,
                  textWeight: FontWeight.bold,
                  textSize: 18,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}