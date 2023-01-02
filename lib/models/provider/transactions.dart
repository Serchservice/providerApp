import 'package:flutter/material.dart';
import 'package:provide/lib.dart';

class TransactionHistoryBox extends StatelessWidget {
  final TransactionModel model;
  const TransactionHistoryBox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SText(
          text: model.senderName,
          color: SColors.hint, weight: FontWeight.bold
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SText(
              text: model.amount.toString(),
              color: SColors.hint, weight: FontWeight.bold
            ),
            const SizedBox(width: 10),
            SText(
              text: model.status,
              color: model.status == "Pending" ? SColors.hint : model.status == "Sent" ? SColors.green : SColors.red,
              weight: FontWeight.bold
            ),
          ]
        )
      ]
    );
  }
}

class TransactionBox extends StatelessWidget {
  final TransactionModel model;
  const TransactionBox({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(child: Image.asset(SImages.creditCard, width: 35,)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SText(
                    text: model.senderName, size: 18,
                    color: Theme.of(context).primaryColorLight, weight: FontWeight.bold
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SText(
                        text: model.amount.toString(),
                        color: SColors.hint, weight: FontWeight.bold
                      ),
                      const SizedBox(width: 10),
                      SText(
                        text: model.date,
                        color: SColors.hint, weight: FontWeight.bold,
                      ),
                    ]
                  ),
                ],
              ),
            ],
          ),
          SText(
            text: model.status,
            color: model.status == "Pending" ? Scolors.info2 : model.status == "Received" ? Scolors.success : Scolors.error,
            weight: FontWeight.bold
          ),
        ],
      )
    );
  }
}

class TransactionModel{
  final String senderName;
  final int amount;
  final String status;
  final String date;

  TransactionModel(this.date, {required this.senderName, required this.amount, required this.status});
}