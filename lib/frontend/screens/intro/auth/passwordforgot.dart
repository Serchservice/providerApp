import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class ForgotPasswordScreen extends StatefulWidget{
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SRes.isPhone(context)
      ? SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(
                        SImages.logo,
                        width: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: horizontalPadding,
                  child: Image.asset(SImages.passwordReset, width: 150, color: Theme.of(context).primaryColor)
                ),
                const ForgotPasswordForm(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                )
              ]
          )
        )
      )
      : Column()
    );
  }
}