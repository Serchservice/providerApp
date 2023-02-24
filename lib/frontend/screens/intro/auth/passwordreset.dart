import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ConfirmPasswordScreen extends StatefulWidget {
  final String email;
  const ConfirmPasswordScreen({super.key, required this.email});

  @override
  State<ConfirmPasswordScreen> createState() => _ConfirmPasswordScreenState();
}

class _ConfirmPasswordScreenState extends State<ConfirmPasswordScreen> {
  List<TextEditingController> controllers = List.generate(6, (index) => TextEditingController());
  final formKey = GlobalKey<FormState>();
  bool loading = false;

  void verify() async {
    if(!formKey.currentState!.validate()){
      return;
    } else {
      setState(() => loading = true);
      try {
        final AuthResponse response = await supabase.auth.verifyOTP(
          token: controllers.map((controller) => controller.text).join(''), type: OtpType.recovery,
          email: widget.email
        );
        final model = PasswordReset(
          accessToken: response.session!.accessToken, type: response.session!.tokenType,
          expiresIn: response.session?.expiresIn, refreshToken: response.session?.refreshToken,
        );
        Get.offAll(() => ResetPasswordScreen(model: model));
      } on AuthException catch (e) {
        showGetSnackbar(
          message: e.message,
          type: Popup.error,
          duration: const Duration(seconds: 3)
        );
        setState(() => loading = false);
      }
    }
  }

  Future<void> resendOTP() async {
    try {
      await supabase.auth.resetPasswordForEmail(widget.email);
      showGetSnackbar(
        message: "We have sent you reset instructions in your email address",
        type: Popup.success,
        duration: const Duration(seconds: 3)
      );
    } on AuthException catch (error) {
      showGetSnackbar(
        message: error.toString(),
        type: Popup.error,
        duration: const Duration(seconds: 3)
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: screenPadding,
            child: Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        SImages.logo,
                        width: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SText(
                    text: "Dear Sercher,",
                    color: Theme.of(context).focusColor,
                    size: 26,
                    weight: FontWeight.w900,
                  ),
                ]),
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: SText(
                    text: "We have sent a mail to ${widget.email}. Verify with the OTP here or use the magicLink in the mail.",
                    color: Theme.of(context).scaffoldBackgroundColor,
                    size: 18,
                    align: TextAlign.left
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          crossAxisSpacing: 8
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
                const SizedBox(height: 40),
                SButton(
                  text: "Verify Email", padding: const EdgeInsets.all(15),
                  width: Get.width, textSize: 16, textWeight: FontWeight.bold,
                  loading: loading, onClick: () => verify()
                ),
                const SizedBox(height: 40),
                SButtonText(
                  text: "Didn't get any code?",
                  textButton: "Request again",
                  onClick: () => resendOTP(),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                )
              ]
            )
          ),
        ),
      )
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
  final PasswordReset model;
  const ResetPasswordScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      SImages.logo,
                      width: 35,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
                Image.asset(SImages.password, width: 100, color: Theme.of(context).primaryColor),
                ResetPasswordForm(model: model),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                )
              ]
            ),
          )
        )
      )
      : Column()
    );
  }
}