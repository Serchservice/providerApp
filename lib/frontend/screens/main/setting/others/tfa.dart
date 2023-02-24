import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TFAScreen extends StatelessWidget {
  const TFAScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: Get.width,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 150, width: 150,
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(SImages.security),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SText.center(
                      text: "For extra security, turn on two-step verification, which will require a pin when registering your email with Serch again",
                      color: Theme.of(context).primaryColorLight,
                      size: 16
                    )
                  ],
                ),
              ),
              SButton(
                text: "Enable",
                padding: const EdgeInsets.all(20),
                width: Get.width,
                textSize: 16,
                onClick: () => Get.to(() => const TFACreateCodeScreen()),
              )
            ]
          ),
        )
      ),
    );
  }
}

class HasTFAScreen extends StatefulWidget {
  const HasTFAScreen({super.key});

  @override
  State<HasTFAScreen> createState() => _HasTFAScreenState();
}

class _HasTFAScreenState extends State<HasTFAScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: Get.width,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 150, width: 150,
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(SImages.security),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const Positioned(
                        right: 0,
                        bottom: 0,
                        child: Icon(Icons.check_circle, size: 40, color: Scolors.success,)
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  SText(
                    text: "Two-step verification is on. You'll need to enter your PIN if you register your account on Serch again.",
                    color: Theme.of(context).primaryColorLight, size: 16
                  )
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SetTab(
                    settingHeader: "Disable",
                    prefixIcon: Icons.cancel,
                    onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          title: SText(text: "Want to disable two-step verification?", color: Theme.of(context).primaryColor, size: 18),
                          actions: [
                            SBtn(
                              text: "Disable", textSize: 16,
                              onClick: () => Get.to(() => const TFAConfirmDisableCodeScreen())
                            ),
                            SBtn(
                              text: "Cancel", textSize: 16,
                              onClick: () => Navigator.of(context).pop(false),
                            )
                          ],
                          actionsPadding: const EdgeInsets.symmetric(vertical: 5),
                          actionsAlignment: MainAxisAlignment.center,
                        );
                      }
                    )
                  ),
                  const SizedBox(height: 10),
                  SetTab(
                    settingHeader: "Change PIN",
                    prefixIcon: Icons.password,
                    onPressed: () => Get.to(() => const TFACreateCodeScreen())
                  ),
                  const SizedBox(height: 10),
                ],
              )
            ]
          ),
        )
      ),
    );
  }
}

class TFAConfirmDisableCodeScreen extends StatefulWidget {
  const TFAConfirmDisableCodeScreen({super.key});

  @override
  State<TFAConfirmDisableCodeScreen> createState() => _TFAConfirmDisableCodeScreenState();
}

class _TFAConfirmDisableCodeScreenState extends State<TFAConfirmDisableCodeScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  final formKey = GlobalKey<FormState>();
  bool loading = false, error = false;

  void disable() async {
    if(!formKey.currentState!.validate()){
      return;
    } else if(userSettingModel.tfaCode != controllers.map((controller) => controller.text).join('')) {
      setState(() => error = true);
    } else {
      setState(() {
        loading = true;
        error = false;
      });
      try {
        await supabase.from(Supa().setting).update({"tfa": false, "tfaCode": ""}).eq("serchID", userInformationModel.serchID);
        final result = await supabase.from(Supa().setting).select().eq("serchID", userInformationModel.serchID).select();
        if (result.length > 0) {
          final setting = result[0] as Map;
          final model = UserSettingModel(
            showOnMap: setting["showOnMap"], alwaysOnline: setting["alwaysOnline"], swm: setting["swm"],
            ctg: setting["ctg"], tfa: setting["tfa"], emailSecure: setting["emailSecure"],
            biometrics: setting["biometrics"], serchID: setting["serchID"], tfaCode: setting["tfaCode"]
          );
          HiveUserDatabase().saveSettingData(model);
        }
        Get.offUntil(GetPageRoute(page: () => const SecuritySettingScreen()), (route) => false);
      } on PostgrestException catch (e) {
        showGetSnackbar(message: e.message, type: Popup.error);
        setState(() => loading = false);
      }
      // Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.chevron_left, color: Theme.of(context).primaryColorLight, size: 28)
        ),
        title: SText(text: "Two-step verification", color: Theme.of(context).primaryColorLight, size: 18, weight: FontWeight.bold,),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: screenPadding,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SText(
                text: "Verify yourself before disabling",
                color: Theme.of(context).primaryColorLight,
                size: 18, weight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 20
                        ),
                        itemCount: controllers.length,
                        itemBuilder: (context, index){
                          return SizedBox(
                            height: 64, width: 60,
                            child: TextFormField(
                              style: Theme.of(context).textTheme.headline6,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: controllers[index],
                              validator: ((value) {
                                if(value!.isEmpty){
                                  return "Empty";
                                } else {
                                  return null;
                                }
                              }),
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: SColors.black,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.lightPurple,
                                    width: 2,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: SColors.red,
                                    width: 2,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                                  borderSide: BorderSide(
                                    color: Theme.of(context).backgroundColor,
                                    width: 2,
                                  ),
                                ),
                              ),
                              onChanged: (value) {
                                if(value.length == 1){
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                            )
                          );
                        }
                      )
                    ),
                  ),
                )
              ),

              const SizedBox(height: 20),
              error ? Column(
                children: const [
                  SText(text: "Code does not match", color: SColors.red, size: 16),
                  SizedBox(height: 10),
                ]
              ) : Container(),
              SButton(
                text: "Disable Two-Factor Auth",
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                textSize: 16, textWeight: FontWeight.bold,
                onClick: () => disable(), loading: loading
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
              )
            ],
          )
        ),
      ),
    );
  }
}