import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TFACreateCodeScreen extends StatefulWidget {
  const TFACreateCodeScreen({super.key});

  @override
  State<TFACreateCodeScreen> createState() => _TFACreateCodeScreenState();
}

class _TFACreateCodeScreenState extends State<TFACreateCodeScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  bool loading = false, error = false;

  void next() async {
    if(!_formKey.currentState!.validate()){
      return;
    } else if(userSettingModel.tfaCode == controllers.map((controller) => controller.text).join('')) {
      setState(() => error = true);
    } else {
      setState(() {
        loading = true;
        error = false;
      });
      _formKey.currentState!.save();
      try{
        await supabase.from(Supa().setting).update({"tfaCode": controllers.map((controller) => controller.text).join('')})
        .eq("serchID", userInformationModel.serchID);
        final result = await supabase.from(Supa().setting).select().eq("serchID", userInformationModel.serchID).select();
        if (result.length > 0) {
          final setting = result[0] as Map;
          final model = UserSettingModel(
            showOnMap: setting["showOnMap"], alwaysOnline: setting["alwaysOnline"], swm: setting["swm"], ctg: setting["ctg"],
            tfa: setting["tfa"], emailSecure: setting["emailSecure"], biometrics: setting["biometrics"], serchID: setting["serchID"],
            tfaCode: setting["tfaCode"]
          );
          HiveUserDatabase().saveSettingData(model);
        }
        Get.to(() => const TFAConfirmCodeScreen());
      } on PostgrestException catch (e) {
        showGetSnackbar(message: e.message, type: Popup.error);
        setState(() => loading = false);
      }
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
                text: "Create a 6-digit PIN that you can remember",
                color: Theme.of(context).primaryColorLight,
                size: 16, weight: FontWeight.bold,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Form(
                      key: _formKey,
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
                ),
              ),

              const SizedBox(height: 20),
              error ? Column(
                children: const [
                  SText(text: "Create a code that is different", color: SColors.red, size: 16),
                  SizedBox(height: 10),
                ]
              ) : Container(),
              SButton(
                text: "Next",
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15), loading: loading,
                textSize: 16, textWeight: FontWeight.bold,
                onClick: () => next(),
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




class TFAConfirmCodeScreen extends StatefulWidget {
  const TFAConfirmCodeScreen({super.key});

  @override
  State<TFAConfirmCodeScreen> createState() => _TFAConfirmCodeScreenState();
}

class _TFAConfirmCodeScreenState extends State<TFAConfirmCodeScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  UserSettingModel userSettingModel = HiveUserDatabase().getSettingData();
  List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  final formKey = GlobalKey<FormState>();
  bool loading = false, error = false;

  void apply() async {
    if(!formKey.currentState!.validate()){
      return;
    } else {
      if(userSettingModel.tfaCode != controllers.map((controller) => controller.text).join('')){
        setState(() => error = true);
        return;
      } else{
        try {
          setState(() {
            loading = true;
            error = false;
          });
          formKey.currentState!.save();
          await supabase.from(Supa().setting).update({"tfa": true}).eq("serchID", userInformationModel.serchID);
          final result = await supabase.from(Supa().setting).select().eq("serchID", userInformationModel.serchID).select();
          if (result.length > 0) {
            final setting = result[0] as Map;
            final model = UserSettingModel(
              showOnMap: setting["showOnMap"], alwaysOnline: setting["alwaysOnline"], swm: setting["swm"], ctg: setting["ctg"],
              tfa: setting["tfa"], emailSecure: setting["emailSecure"], biometrics: setting["biometrics"], serchID: setting["serchID"],
              tfaCode: setting["tfaCode"]
            );
            HiveUserDatabase().saveSettingData(model);
          }
          Get.offUntil(GetPageRoute(page: () => const SecuritySettingScreen()), (route) => false);
          setState(() => loading = false);
        } on PostgrestException catch (e) {
          showGetSnackbar(message: e.message, type: Popup.error);
          setState(() => loading = false);
        }
      }
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
                text: "Confirm your pin",
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
                text: "Apply Code",
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(15),
                textSize: 16, textWeight: FontWeight.bold,
                onClick: () => apply(), loading: loading
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