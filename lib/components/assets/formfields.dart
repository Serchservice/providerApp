import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class SFormField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final bool? enabled;
  final bool obscureText;
  final String? Function(String?)? validate;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? suffixColor;
  final Color? prefixColor;
  final Color formColor;
  final Color enabledBorderColor;
  final TextStyle formStyle;
  final TextInputAction inputAction;
  final TextInputType? keyboard;
  final String formName;
  final FocusNode? focus;
  final void Function(String)? onChanged;
  const SFormField({
    super.key, this.labelText, this.controller, this.enabled, this.obscureText = false, this.validate, this.prefixIcon, this.onChanged,
    this.onPressed, this.icon, this.inputAction = TextInputAction.next, this.keyboard, required this.formName, this.suffixIcon,
    this.cursorColor, this.fillColor, this.enabledBorderColor = SColors.white, required this.formStyle, this.formColor = SColors.white,
    this.suffixColor, this.prefixColor, this.focus
  });
  SFormField.password({
    super.key, this.labelText, this.controller, this.enabled, this.obscureText = false, this.validate, this.prefixIcon,
    this.suffixColor, this.prefixColor, this.onPressed, this.icon, this.inputAction = TextInputAction.next, this.keyboard,
    required this.formName, this.onChanged, this.cursorColor, this.fillColor, this.enabledBorderColor = SColors.white,
    required this.formStyle, this.formColor = SColors.white, this.focus
  }) : suffixIcon = IconButton(onPressed: onPressed, icon: Icon(icon, size: 24), color: suffixColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SText(text: formName, size: 16, color: formColor, weight: FontWeight.w500),
          const SizedBox(height: 5),
          TextFormField(
            style: formStyle,
            cursorColor: cursorColor,
            controller: controller,
            enabled: enabled,
            focusNode: focus,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: inputAction,
            keyboardType: keyboard,
            obscureText: obscureText,
            validator: validate,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: labelText,
              hintStyle: STexts.hints(context),
              isDense: true,
              filled: true,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              fillColor: fillColor,
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
              disabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: Theme.of(context).backgroundColor,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SDropDown extends StatelessWidget {
  final List<String> list;
  final String? hintText;
  final void Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Color? fillColor;
  final Color enabledBorderColor;
  final String formName;
  final Color formColor;
  final Color listColor;
  final Color iconColor;
  final String? Function(String?)? validate;
  const SDropDown({
    super.key, required this.list, this.hintText, this.onChanged, this.onSaved, required this.formName,
    this.validate, this.fillColor, this.enabledBorderColor = SColors.white, this.formColor = SColors.white,
    this.listColor = SColors.white, this.iconColor = SColors.hint
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SText(text: formName, size: 16, color: formColor, weight: FontWeight.w500),
          const SizedBox(height: 5),
          DropdownButtonFormField(
            items: list.map((lists) => DropdownMenuItem<String>(
              value: lists,
              child: SText.theme(text: lists, color: formColor, size: 16)
            )).toList(),
            dropdownColor: fillColor,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // hint: Text(hintText, style: STexts.hints(context)),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              hintText: hintText,
              hintStyle: STexts.hints(context),
              contentPadding: const EdgeInsets.all(12),
              fillColor: fillColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: enabledBorderColor,
                  style: BorderStyle.solid,
                  width: 2
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: SColors.lightPurple,
                  width: 2,
                  style: BorderStyle.solid
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
                  color: SColors.grey,
                  width: 2,
                ),
              ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: iconColor,
            ),
            onChanged: (value) => debugShow(value.toString()),
            onSaved: onSaved,
            validator: validate,
          ),
        ],
      ),
    );
  }
}

class SPhoneField extends StatelessWidget{
  final TextEditingController? controller;
  final String labelText;
  final String formName;
  final TextInputAction? inputAction;
  final bool enabled;
  final Color enabledBorderColor;
  final Color? cursorColor;
  final Color? fillColor;
  final Color? formColor;
  final TextStyle formStyle;
  final void Function(PhoneNumber)? onPhoneChanged;
  final void Function(Country)? onCountryChanged;
  const SPhoneField({
    super.key, this.controller, required this.labelText, this.enabled = true, this.inputAction, required this.formName,
    this.onPhoneChanged, this.onCountryChanged, this.enabledBorderColor = SColors.white, required this.formStyle, this.cursorColor, this.fillColor, this.formColor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SText(text: formName, size: 16, color: formColor ?? Theme.of(context).scaffoldBackgroundColor, weight: FontWeight.w500),
          const SizedBox(height: 5),
          PhoneFormField(
            initialCountryCode: 'US',
            style: formStyle,
            dropdownIconPosition: IconPosition.trailing,
            flagsButtonPadding: const EdgeInsets.only(left: 10),
            textInputAction: inputAction,
            cursorColor: cursorColor ?? Theme.of(context).scaffoldBackgroundColor,
            cursorWidth: 2,
            dropdownDecoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15)
              ),
            ),
            dropdownTextStyle: formStyle,
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
              fillColor: fillColor,
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