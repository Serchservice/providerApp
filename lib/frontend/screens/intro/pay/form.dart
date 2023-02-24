import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class PayForm extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final String cardCode;
  final String date;
  final String cardNameText;
  final String cardNumberText;
  final String cardCodeText;
  final String cardDateText;
  final Widget? widget;
  final Color? color;
  final GlobalKey<FormState> formKey;
  final void Function(UserBankCardModel) onCreditCardModelChange;
  const PayForm({
    super.key,
    required this.cardName,
    required this.cardNumber,
    required this.cardCode,
    required this.date,
    required this.onCreditCardModelChange,
    required this.formKey, this.color,
    this.cardNameText = "John Doe",
    this.cardNumberText = "5045 5435 4543 5435",
    this.cardCodeText = "405",
    this.cardDateText = "MM/YY", this.widget
  });

  @override
  State<PayForm> createState() => _PayFormState();
}

class _PayFormState extends State<PayForm> {
  late String cardNumber;
  late String date;
  late String cardName;
  late String cardCode;
  bool isVisible = false;
  bool visible = false;

  late void Function(UserBankCardModel) onCreditCardModelChange;
  late UserBankCardModel creditCardModel;

  final MaskedTextController cardNumberController = MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController dateController = MaskedTextController(mask: '00/00');
  final TextEditingController cardNameController = TextEditingController();
  final TextEditingController cardCodeController = MaskedTextController(mask: '0000');

  void createCreditCardModel() {
    cardNumber = widget.cardNumber;
    date = widget.date;
    cardName = widget.cardName;
    cardCode = widget.cardCode;
    creditCardModel = UserBankCardModel(cardNumber: cardNumber, cardExpiryDate: date, cardName: cardName, cardCode: cardCode);
  }

  @override
  void initState() {
    super.initState();

    createCreditCardModel();

    onCreditCardModelChange = widget.onCreditCardModelChange;

    cardNumberController.addListener(() {
      setState(() {
        cardNumber = cardNumberController.text;
        creditCardModel.cardNumber = cardNumber;
        onCreditCardModelChange(creditCardModel);
      });
    });

    dateController.addListener(() {
      setState(() {
        date = dateController.text;
        creditCardModel.cardExpiryDate = date;
        onCreditCardModelChange(creditCardModel);
      });
    });

    cardNameController.addListener(() {
      setState(() {
        cardName = cardNameController.text;
        creditCardModel.cardName = cardName;
        onCreditCardModelChange(creditCardModel);
      });
    });

    cardCodeController.addListener(() {
      setState(() {
        cardCode = cardCodeController.text;
        creditCardModel.cardCode = cardCode;
        onCreditCardModelChange(creditCardModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SFormField(
            labelText: widget.cardNameText,
            controller: cardNameController,
            inputAction: TextInputAction.next,
            keyboard: TextInputType.name,
            formName: "Card Holder Name",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
          ),
          SFormField.password(
            labelText: widget.cardNumberText,
            controller: cardNumberController,
            keyboard: TextInputType.number,
            obscureText: !isVisible,
            inputAction: TextInputAction.next,
            onPressed: () {
              setState(() {
                isVisible = !isVisible;
              });
            },
            formName: "Card Holder Name",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
            icon: isVisible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            // myValidators: Validators.validateCardNumber
          ),
          SFormField.password(
            labelText: widget.cardCodeText,
            controller: cardCodeController,
            keyboard: TextInputType.number,
            obscureText: !visible,
            inputAction: TextInputAction.next,
            onPressed: () {
              setState(() {
                visible = !visible;
              });
            },
            formName: "Card CVV Code",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
            icon: visible ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
            // myValidators: Validators.validateCardNumber
          ),
          SFormField(
            labelText: widget.cardDateText,
            controller: dateController,
            // validate: Validators.validateCardDate,
            keyboard: TextInputType.number,
            inputAction: TextInputAction.done,
            formName: "Card Expiry Date",
            formStyle: STexts.normalForm(context),
            formColor: Theme.of(context).primaryColor,
            fillColor: widget.color ?? Theme.of(context).backgroundColor,
          ),
          Container(child: widget.widget)
      ],
    ));
  }
}


class SPayCard extends StatefulWidget {
  final String cardName;
  final String cardNumber;
  final String cardCode;
  final String date;
  final double width;
  final double height;
  const SPayCard({
    super.key, required this.cardName, required this.cardNumber, required this.cardCode, required this.date,
    this.width = 200, this.height = 180
  });

  @override
  State<SPayCard> createState() => _SPayCardState();
}

class _SPayCardState extends State<SPayCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        image: const DecorationImage(image: AssetImage(SImages.creditCard),fit: BoxFit.cover),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.blue,width: 2,),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SText(text: "Name:", size: 16, weight: FontWeight.bold,),
                  const SizedBox(width: 10,),
                  SText(text: widget.cardName.isEmpty ? "Card Holder Name" : widget.cardName, size: 16, weight: FontWeight.bold,)
                ],
              ),
              // Image.asset(SImages.chip, width: 30,),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SText(text: "Number:", size: 16, weight: FontWeight.bold,),
                  const SizedBox(width: 10,),
                  SText(text: widget.cardNumber.isEmpty ? "XXXX XXXX XXXX XXXX" : widget.cardNumber, size: 16, weight: FontWeight.bold,),
                ],
              ),
              getCardTypeIcon(widget.cardNumber)
            ],
          ),
          Row(
            children: [
              const SText(text: "CVV:", size: 16, weight: FontWeight.bold,),
              const SizedBox(width: 10,),
              SText(text: widget.cardCode.isEmpty ? "Card Holder Code" : widget.cardCode, size: 16, weight: FontWeight.bold,),
            ],
          ),
          Row(
            children: [
              const SText(text: "Card Expiry Date:", size: 16, weight: FontWeight.bold,),
              const SizedBox(width: 10,),
              SText(text: widget.date.isEmpty ? "Card Expiry Date" : widget.date, size: 16, weight: FontWeight.bold,),
            ],
          ),
        ],
      ),
    );
  }
}