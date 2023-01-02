import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provide/lib.dart';

class EditProfileScreen extends StatefulWidget {
  final String? image;
  const EditProfileScreen({super.key, this.image});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  //Saving the profile details
  void saveProfile(){}

  @override
  Widget build(BuildContext context) {
    String userFirstName = Provider.of<UserInformation>(context, listen: false).user.firstName!;
    String userLastName = Provider.of<UserInformation>(context, listen: false).user.lastName!;
    String userEmailAddress = Provider.of<UserInformation>(context, listen: false).user.emailAddress!;
    String userPhoneNumber = Provider.of<UserInformation>(context, listen: false).user.phone!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offUntil(GetPageRoute(page: () => const BottomNavigator()), (route) => false),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).primaryColor
          )
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<Auth>(
              builder: (context, authProvide, _) => SButton(
                text: "Save",
                padding: const EdgeInsets.all(8.0),
                textWeight: FontWeight.bold,
                textSize: 18,
                loading: authProvide.isLoading,
                onClick: () => saveProfile(),
              ),
            ),
          ),
        ]
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              //User Profile Picture Edit
              Center(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => selectPictureOptions(context),
                      child: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorLight, width: 1.2))
                        ),
                        child: Avatar(image: widget.image, radius: 65)
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const SText(
                        text: "Tap your profile picture to change it",
                        color: SColors.hint,
                        weight: FontWeight.bold,
                        size: 12
                      )
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),
              //User Profile Editing Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SFormField(
                      labelText: userFirstName,
                      formName: "First Name",
                      controller: firstName,
                      validate: Validators.name,
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    SFormField(
                      labelText: userLastName,
                      formName: "Last Name",
                      controller: lastName,
                      validate: Validators.name,
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    SFormField(
                      labelText: userEmailAddress,
                      formName: "Email Address",
                      controller: emailAddress,
                      validate: Validators.email,
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    SFormField(
                      labelText: userPhoneNumber,
                      formName: "Phone Number",
                      controller: phoneNumber,
                      validate: (value){
                        if(value!.length < 5){
                          return "Enter a correct number";
                        } else {
                          return null;
                        }
                      },
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                  ]
                )
              ),

              const SizedBox(height: 20),
              //Notification for 30days change of details.
              Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const SText(
                  text: "NOTE: You can only change your profile details once every 30days. Make sure what you give is correct.",
                  color: SColors.hint,
                  weight: FontWeight.bold,
                  size: 12
                )
              ),

            ]
          )
        )
      )
    );
  }
}

///Changing the profile picture of the user.
///Will check if gallery and camera permissions are granted before asking whether to pick from gallery, files or camera
selectPictureOptions(context) => showModalBottomSheet(
  context: context,
  backgroundColor: Colors.transparent,
  builder: (context) => StatefulBuilder(
    builder: (context, setState) => SizedBox(
      height: 150,
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SIconTextButton(
                icon: Icons.insert_photo_rounded,
                onClick: () => pickFile(
                  context: context, type: FileType.image,
                  allowMultiple: false,
                ),
                radius: 29,
                color: SColors.blue,
                text: "Gallery"
              ),
              SIconTextButton(
                icon: Icons.camera_alt_rounded,
                radius: 29,
                onClick: () => pickImage(context: context, source: ImageSource.camera),
                color: SColors.lightPurple,
                text: "Camera"
              ),
              SIconTextButton(
                icon: Icons.insert_drive_file_rounded,
                radius: 29,
                onClick: () => pickImage(context: context, source: ImageSource.gallery),
                color: SColors.virgo,
                text: "File"
              ),
            ]
          ),
        ),
      )
    ),
  )
);

