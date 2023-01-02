import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SPhoneField extends StatelessWidget{
  final TextEditingController? controller;
  final String labelText;
  final String formName;
  final TextInputAction? inputAction;
  final bool enabled;
  final Color enabledBorderColor;
  final TextStyle formStyle;
  final void Function(PhoneNumber)? onPhoneChanged;
  final void Function(Country)? onCountryChanged;
  const SPhoneField({
    super.key, this.controller, required this.labelText, this.enabled = true, this.inputAction, required this.formName,
    this.onPhoneChanged, this.onCountryChanged, this.enabledBorderColor = SColors.white, required this.formStyle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SText(text: formName, size: 16, color: Theme.of(context).scaffoldBackgroundColor, weight: FontWeight.w500),
          const SizedBox(height: 5),
          PhoneFormField(
            initialCountryCode: 'US',
            style: formStyle,
            dropdownIconPosition: IconPosition.trailing,
            flagsButtonPadding: const EdgeInsets.only(left: 10),
            textInputAction: inputAction,
            cursorColor: Theme.of(context).scaffoldBackgroundColor,
            cursorWidth: 2,
            dropdownDecoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15)
              ),
            ),
            dropdownTextStyle: STexts.authForm(context),
            dropdownIcon: const Icon(
              Icons.arrow_drop_down_rounded ,
              size: 20,
              color: SColors.hint
            ),
            enabled: enabled,
            controller: controller,
            onChanged: onPhoneChanged,
            onCountryChanged: onCountryChanged,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: STexts.hints(context),
              isDense: true,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  width: 2,
                  color: enabledBorderColor,
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
              disabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: SColors.hint,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}