import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class BankBox extends StatelessWidget{
  final BankDetail bank;
  final bool isGrid;
  final void Function()? onLongPress;
  final void Function()? onPress;
  final void Function()? onMoreOptions;
  const BankBox({ super.key, required this.bank, this.isGrid = false, this.onPress, this.onLongPress, this.onMoreOptions});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: isGrid ? const EdgeInsets.all(1.0) : const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        // color: Theme.of(context).backgroundColor,
        child: InkWell(
          onTap: onPress,
          onLongPress: onLongPress,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(SImages.creditCard),
                fit: BoxFit.cover
              )
            ),
            child: isGrid
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SText(
                  color: SColors.white,
                  text: bank.bankName,
                  size: 18, weight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                SText(
                  color: SColors.white,
                  text: bank.accountName,
                  size: 16, weight: FontWeight.bold,
                ),
                const SizedBox(height: 5),
                SText(
                  color: SColors.white,
                  text: "${bank.accountNumber.substring(0, 4)}****",
                  size: 16, weight: FontWeight.bold,
                ),
                const SizedBox(height: 5),
                //Icon for more options and Bank Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(SImages.layers, width: 25,),
                    IconButton(
                      onPressed: onMoreOptions,
                      icon: const Icon(
                        // Icons.more_vert,
                        Icons.delete,
                        size: 24, color: Scolors.error
                      )
                    )
                  ],
                )
              ],
            )
            : Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(SImages.layers, width: 25,),
                        const SizedBox(width: 10),
                        SText(
                          color: SColors.white,
                          text: bank.bankName,
                          size: 20, weight: FontWeight.bold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SText(
                      color: SColors.white,
                      text: bank.accountName,
                      size: 16, weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 5),
                    SText(
                      color: SColors.white,
                      text: bank.accountNumber,
                      size: 14, weight: FontWeight.bold,
                    ),
                  ]
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}

class BankDetail{
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String id;

  BankDetail({required this.accountName, required this.accountNumber, required this.bankName, required this.id});
}