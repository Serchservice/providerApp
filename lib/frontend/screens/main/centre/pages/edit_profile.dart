import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfileScreen extends StatefulWidget {
  final String image;
  final PlatformFile? imageFile;
  final XFile? file;
  const EditProfileScreen({super.key, this.image = "", this.imageFile, this.file});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String? phoneCountryCode, phoneCountryISOCode, country, countryDialCode;

  //Saving the profile details
  void saveProfile() async {
    try {
      if(widget.image.isNotEmpty || firstName.text.isNotEmpty || lastName.text.isNotEmpty
      || emailAddress.text.isNotEmpty || phoneNumber.text.isNotEmpty
      ){
        showDialog(
          context: context, barrierDismissible: false, builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: AlertLoader.fallingDot(
              size: 40, color: Theme.of(context).primaryColor, text: "Saving profile", textSize: 16,
            ),
          )
        );
        final bytes = widget.imageFile != null ? widget.imageFile?.bytes : await widget.file?.readAsBytes();
        final fileExt = widget.imageFile != null ? widget.imageFile?.extension : widget.image.split(".").last;
        final fileName = "profile-picture-${DateTime.now().toIso8601String()}.$fileExt";
        await supabase.storage.from("${Supa().profilePictureStorage}${userInformationModel.serchAuth}").uploadBinary(
          fileName, bytes!, fileOptions: FileOptions(
            contentType: widget.imageFile != null ? null : widget.file?.mimeType
          )
        );
        final responseUrl = supabase.storage.from("${Supa().profilePictureStorage}${userInformationModel.serchAuth}")
        .getPublicUrl(fileName);
        // .createSignedUrl(fileName, 60 * 60 * 24 * 365 * 100);
        await supabase.from(Supa().profile).update({
          "avatar": responseUrl,
          "firstName": firstName.text.isNotEmpty ? firstName.text.trim() : userInformationModel.firstName,
          "lastName": lastName.text.isNotEmpty ? lastName.text.trim() : userInformationModel.lastName,
          "emailAddress": emailAddress.text.isNotEmpty ? emailAddress.text.trim() : userInformationModel.emailAddress,
          "phoneInfo": {
            "phone": phoneNumber.text.isNotEmpty ? phoneNumber.text.trim() : userInformationModel.phoneInfo.phone,
            "phoneCountryCode": userInformationModel.phoneInfo.phoneCountryCode,
            "phoneCountryISOCode": userInformationModel.phoneInfo.phoneCountryISOCode,
          }
        }).eq("serchID", userInformationModel.serchID);
        final result = await supabase.from(Supa().profile).select().eq("serchID", userInformationModel.serchID).select();
        if (result.length > 0) {
          final setting = result[0] as Map;
          final model = UserInformationModel(
            emailAddress: setting["emailAddress"], firstName: setting["firstName"], lastName: setting["lastName"],
            referLink: setting["referLink"], gender: setting["gender"], serchAuth: setting["serchAuth"], serchID: setting["serchID"],
            phoneInfo: UserPhoneInfo.fromJson(setting["phoneInfo"] as Map<String, dynamic>), avatar: setting["avatar"],
            countryInfo: UserCountryInfo.fromJson(setting["countryInfo"] as Map<String, dynamic>),
            password: setting["password"], totalRating: setting["totalRating"], numberOfRating: setting["numberOfRating"],
            totalServiceTrips: setting["total_service_trips"], balance: setting["balance"]
          );
          HiveUserDatabase().saveProfileData(model);
          showGetSnackbar(message: "Your profile data has changed", type: Popup.success);
        }
      } else {
        return;
      }
      Get.offAll(() => const BottomNavigator(newPage: 4));
    } on StorageException catch (e) {
      Navigator.of(context).pop();
      showGetSnackbar(message: "From Storage: ${e.message}", type: Popup.error);
    } on PostgrestException catch (e) {
      Navigator.of(context).pop();
      showGetSnackbar(message: "From Database: ${e.message}", type: Popup.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () => Get.offUntil(GetPageRoute(page: () => const BottomNavigator(newPage: 4)), (route) => false),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Theme.of(context).primaryColor
              )
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SButton(
                  text: "Save",
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  textWeight: FontWeight.bold,
                  borderRadius: 4,
                  textSize: 18,
                  onClick: () => saveProfile(),
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
                            child: widget.image.isEmpty ? Avatar(
                              userInformationModel: userInformationModel,
                              radius: 90
                            ) : UserAvatar(radius: 90, image: widget.image,)
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
                          labelText: userInformationModel.firstName,
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
                          labelText: userInformationModel.lastName,
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
                          labelText: userInformationModel.emailAddress,
                          formName: "Email Address",
                          controller: emailAddress,
                          validate: Validators.email,
                          cursorColor: Theme.of(context).primaryColor,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                          enabledBorderColor: Theme.of(context).primaryColor,
                        ),
                        SPhoneField(
                          labelText: userInformationModel.phoneInfo.phone,
                          formName: "Phone Number *",
                          onPhoneChanged: (value) {
                            setState(() => phoneCountryISOCode = value.countryISOCode);
                            setState(() => phoneCountryCode = value.countryCode.toString());
                            setState(() => phoneNumber.text = value.number);
                          },
                          onCountryChanged: (value) {
                            setState(() => country = value.name);
                            setState(() => countryDialCode = value.dialCode);
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
        ),
      ),
    );
  }
}


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

