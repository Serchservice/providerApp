import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

void enterWithdrawAmount({
  required BuildContext context,
  required BankDetail bank,
}) async {
  TextEditingController amount = MaskedTextController(mask: "00,000");
  final formKey = GlobalKey<FormState>();

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    builder: (context) => KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: StatefulBuilder(
        builder:(context, setState) => Container(
          padding: screenPadding,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SText(
                      text: "Enter Withdrawal Amount",
                      size: 20,
                      weight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Scolors.info3,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const SText(
                        text: "You can only make withdrawals once in a week!. Withdrawal limit is #20,000 while the minimum is #1,000.",
                        color: SColors.black,
                        weight: FontWeight.bold,
                        size: 14
                      )
                    ),
                    const SizedBox(height: 10),
                  ]
                )
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    BankBox(bank: bank,),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SFormField(
                            labelText: "0.00",
                            formName: "Withdrawal Amount",
                            controller: amount,
                            keyboard: TextInputType.number,
                            cursorColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).scaffoldBackgroundColor,
                            formStyle: STexts.normalForm(context),
                            formColor: Theme.of(context).primaryColor,
                            enabledBorderColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SButton(
                              text: "Cash Out",
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(14.0),
                              textWeight: FontWeight.bold,
                              textSize: 18,
                              onClick: () => {},
                            ),
                          ),
                        ]
                      )
                    )
                  ]
                ),
              ),
            ],
          ),
        )
      ),
    )
  );
}





///Popup for bank account deleting
///
void openBankOptions({
  required BuildContext context,
  required dynamic bankId,
}) async {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => StatefulBuilder(
      builder:(context, setState) => Padding(
        padding: screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SText.center(
              text: "Are you sure you want to delete this Bank Account?",
              size: 22,
              weight: FontWeight.bold,
              color: SColors.white,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SBtn(
                  onClick: () {},
                  text: "Yes",
                ),
                const SizedBox(width: 10,),
                SBtn(onClick: () => Get.back(), text: "No")
              ],
            ),
          ],
        ),
      ),
    )
  );
}