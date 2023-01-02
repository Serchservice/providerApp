import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(SImages.login, height: 200,),
                ),
                // LottieBuilder.network(
                //   "https://assets10.lottiefiles.com/packages/lf20_pwwZiL9I3Y.json"
                // ),
                const LoginForm(),
              ],
            )
          )
        )
      : Column()
    );
  }
}