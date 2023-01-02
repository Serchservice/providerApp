import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';
import 'package:provide/models/provider/transactions.dart';

class Tip2FixWalletScreen extends StatefulWidget {
  final String userAmount;
  const Tip2FixWalletScreen({super.key, required this.userAmount});

  @override
  State<Tip2FixWalletScreen> createState() => _Tip2FixWalletScreenState();
}

class _Tip2FixWalletScreenState extends State<Tip2FixWalletScreen> {
  @override
  Widget build(BuildContext context) {
    bool userHasBankAccount = true;
    bool userHasCompleted5Services = true;
    bool userHasStayedFor30Days = true;
    List<BankDetail> banks = [
      BankDetail(
        accountNumber: "5vdvdsd789797979797", id: "F3429Frfvsvbdjik24091",
        bankName: "Wema", accountName: "Evaristus Adimonyemma"),
      // BankDetail(
      //   accountNumber: "897899789797979797", id: "Fegaas3gdggsdegvsvbdjik24091",
      //   bankName: "Wema", accountName: "Evaristus Adimonyemma"),
    ];

    List<TransactionModel> transactionList = [
      TransactionModel("12/01/2022", senderName: "Evaristus Adimonyemma", amount: 2000, status: "Pending"),
      TransactionModel("12/01/2022", senderName: "Evaristus Adimonyemma", amount: 2000, status: "Withdrawn"),
      TransactionModel("12/01/2022", senderName: "Evaristus Adimonyemma", amount: 2000, status: "Received")
    ];

    List<TableRow> tables = [
      tableHeader(["Name", "Amount", "Date", "Status"], isHeader: true),
      tableHeader(["Evaristus Adimonyemma", "2,000", "12/01/2022", "Pending"]),
      tableHeader(["Evaristus Adimonyemma", "3,500", "12/01/2022", "Withdrawn"]),
      tableHeader(["Evaristus Adimonyemma", "10,000", "12/01/2022", "Received"]),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            elevation: 1,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: Theme.of(context).primaryColor
              )
            ),
            title: SText(
              text: "My Tip2Fix Earnings",
              color: Theme.of(context).primaryColorLight,
              size: 30, weight: FontWeight.bold
            ),
            expandedHeight: 250,
          ),
          SliverPadding(
            padding: screenPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  //Tip Wallet Box
                  Container(
                    padding: screenPadding,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Image.asset(SImages.wallet, width: 50,),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SText(
                                    text: "T2F Earnings: ",
                                    size: 18,
                                    weight: FontWeight.bold,
                                    color: Scolors.info
                                  ),
                                  SText(
                                    text: widget.userAmount,
                                    size: 18,
                                    weight: FontWeight.bold,
                                    color: Scolors.info
                                  ),
                                ]
                              ),
                            ]
                          ),
                        )
                      ],
                    )
                  ),
            
                  //Button to popup the bottomSheet for the user to enter account number for funds transfer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SButton(
                          text: "Withdraw",
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                          textWeight: FontWeight.bold,
                          textSize: 14,
                          borderRadius: 3,
                          onClick: () => openWithdrawDialog(
                            context: context,
                            userHasBankAccount: userHasBankAccount,
                            userHasCompleted5Services: userHasCompleted5Services,
                            userHasStayedFor30Days: userHasStayedFor30Days,
                            banks: banks
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ),
          //User Bank Account for withdrawal
          if(userHasBankAccount == true)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                ((context, index) => BankBox(
                  bank: banks[index],
                  isGrid: true,
                  onMoreOptions: () {
                    debugShow(banks[index].id);
                    openBankOptions(bankId: banks[index].id, context: context);
                  },
                )),
                childCount: banks.length
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 15
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  //For the User to add a bank account
                  if(userHasBankAccount == false || banks.length < 2)
                  Material(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () => addBankAccount(context: context),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_home, color: Theme.of(context).primaryColorLight, size: 26),
                            const SizedBox(width: 5),
                            SText(
                              text: "Add Bank Account",
                              size: 16,
                              weight: FontWeight.bold,
                              color: Theme.of(context).primaryColorLight
                            )
                          ]
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Scolors.info3,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: const SText(
                      text: "NOTE: Transaction history within 30 days is shown in the table history below.",
                      color: SColors.black,
                      weight: FontWeight.bold,
                      size: 14
                    )
                  ),
                  const SizedBox(height: 20),
            
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SText(
                        text: "Transaction History",
                        color: Theme.of(context).primaryColorLight,
                        size: 18, weight: FontWeight.bold
                      ),
                    ],
                  ),
                  //Tippers and Amount History
                  // Table(
                  //   border: TableBorder(
                  //     top: BorderSide(width: 0.2, color: Theme.of(context).primaryColorLight,),
                  //     bottom: BorderSide(width: 0.2, color: Theme.of(context).primaryColorLight,),
                  //     horizontalInside: BorderSide(width: 0.2, color: Theme.of(context).primaryColorLight,),
                  //   ),
                  //   columnWidths: const {
                  //     0: FractionColumnWidth(0.33),
                  //     1: FractionColumnWidth(0.23),
                  //     2: FractionColumnWidth(0.20),
                  //     3: FractionColumnWidth(0.25),
                  //   },
                  //   children: tables
                  // ),
                ]
              )
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  return TransactionBox(model: transactionList[index]);
                }),
                childCount: transactionList.length
              )
            ),
          ),

          if(transactionList.isEmpty)
          SliverToBoxAdapter(
            child: Column(
              children: const [
                Center(
                  child: SText.center(
                    text: "No transactions yet",
                    color: SColors.hint,
                    size: 20,
                  ),
                ),
                SizedBox(height: 40)
              ],
            ),
          )
          else
          const SliverToBoxAdapter(child: SizedBox(height: 40))
        ],
      )
    );
  }

  TableRow tableHeader(List<String> headers, {bool isHeader = false}) => TableRow(
    children: headers.map((e) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 8),
      child: Center(
        child: SText(
          text: e,
          size: isHeader ? 16 : 14, weight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: e.toString() == "Pending" ? Scolors.info2 : e.toString() == "Withdrawn" ? Scolors.error
          : e.toString() == "Received" ? Scolors.success : Theme.of(context).primaryColorLight
        ),
      ),
    )).toList()
  );

  void openWithdrawDialog({
    required BuildContext context,
    required bool userHasBankAccount,
    required bool userHasCompleted5Services,
    required bool userHasStayedFor30Days,
    required List<BankDetail> banks,
  }){

    if(userHasBankAccount && userHasCompleted5Services && userHasStayedFor30Days) {
      //Show the user's account number/s for the user to choose which account to transfer money to.
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
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
                        text: "Choose an account for withdrawal",
                        size: 20,
                        weight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) => BankBox(
                      bank: banks[index],
                      onPress: () {
                        debugShow(banks[index].id);
                        enterWithdrawAmount(bank: banks[index], context: context);
                      },
                    )),
                    childCount: banks.length,
                  )
                )
              ]
            ),
          )
        )
      );
    } else if(userHasBankAccount == true && userHasCompleted5Services == false){
      //Tell the user that he has to complete 5 t2f services before being able to withdraw money
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        enableDrag: false,
        builder: (context) => StatefulBuilder(
          builder:(context, setState) => Container(
            padding: screenPadding,
            width: MediaQuery.of(context).size.width,
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
                        text: "Looking to make a withdrawal?",
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
                          text: "You cannot make withdrawals till you complete the least of 5 Tip2Fix service trips.",
                          color: SColors.black,
                          weight: FontWeight.bold,
                          size: 14
                        )
                      ),
                      const SizedBox(height: 20),
                    ]
                  )
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) => BankBox(bank: banks[index])),
                    childCount: banks.length
                  )
                ),
              ]
            ),
          )
        )
      );
    } else if(userHasBankAccount == true && userHasStayedFor30Days == false){
      //Tell the user that he has to run the account for 30days before being able to withdraw money
      showModalBottomSheet(
        context: context,
        enableDrag: false,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
          builder:(context, setState) => Container(
            padding: screenPadding,
            width: MediaQuery.of(context).size.width,
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
                        text: "Looking to make a withdrawal?",
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
                          text: "You cannot make withdrawals till your account completes 30days of activeness.",
                          color: SColors.black,
                          weight: FontWeight.bold,
                          size: 14
                        )
                      ),
                      const SizedBox(height: 20),
                    ]
                  )
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    ((context, index) => BankBox(bank: banks[index])),
                    childCount: banks.length
                  )
                ),
              ]
            ),
          )
        )
      );
    } else {
      ///Show the user that he has no bank account attached to his profile, give him an option to add a bank account
      ///Also tell the user to wait for 30days and run 5 t2f features before being able to withdraw.
      addBankAccount(context: context);
    }
  }
}

addBankAccount({
  required BuildContext context,
}) async {
  final formKey = GlobalKey<FormState>();
  TextEditingController accountNumber = TextEditingController();
  String? myBank;
  bool verified = true;

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => StatefulBuilder(
      builder:(context, setState) => Container(
        padding: screenPadding,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SText(
                text: "Provide a bank account in order to process your withdrawals",
                size: 20,
                weight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SFormField(
                      labelText: "3034584932",
                      formName: "Account Number",
                      controller: accountNumber,
                      cursorColor: Theme.of(context).primaryColor,
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formStyle: STexts.normalForm(context),
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    SDropDown(
                      list: gender,
                      hintText: "Select your bank",
                      formName: "Bank Name",
                      onChanged: (value) => setState(() => myBank = value.toString()),
                      onSaved: (value) => setState(() => myBank = value.toString()),
                      fillColor: Theme.of(context).scaffoldBackgroundColor,
                      formColor: Theme.of(context).primaryColor,
                      enabledBorderColor: Theme.of(context).primaryColor,
                    ),
                    if(verified == true)
                    Column(
                      children: [
                        SFormField(
                          labelText: "Evaristus Adimonyemma",
                          formName: "Account Name",
                          enabled: false,
                          cursorColor: Theme.of(context).primaryColor,
                          fillColor: Theme.of(context).scaffoldBackgroundColor,
                          formStyle: STexts.normalForm(context),
                          formColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(height: 20)
                      ],
                    )
                    else
                    const SizedBox(height: 20),
                    if(verified == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SButton(
                        text: "Save my bank information",
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        textWeight: FontWeight.bold,
                        textSize: 18,
                        onClick: () => {},
                      ),
                    )
                    else
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SButton(
                        text: "Verify Bank Account",
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        textWeight: FontWeight.bold,
                        textSize: 18,
                        onClick: () => {},
                      ),
                    ),
                  ]
                )
              ),
            ]
          ),
        ),
      )
    )
  );
}

