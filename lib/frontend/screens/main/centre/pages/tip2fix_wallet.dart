import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provide/lib.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BankDetails{
  final String header;
  final Widget widget;
  const BankDetails({required this.header, required this.widget});
}

class Tip2FixWalletScreen extends StatefulWidget {
  const Tip2FixWalletScreen({super.key});

  @override
  State<Tip2FixWalletScreen> createState() => _Tip2FixWalletScreenState();
}

class _Tip2FixWalletScreenState extends State<Tip2FixWalletScreen> {
  UserBankAccountModel userBankAccountModel = HiveUserDatabase().getBankAccountData();
  UserBankCardModel userBankCardModel = HiveUserDatabase().getBankCardData();
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  List<UserMoneyModel> transactionList = HiveUserDatabase().getMoneyDataList();
  late int accountDuration;

  void getAccountDuration() async {
    try {
      final result = await supabase.from(Supa().profile).select().eq("serchAuth", userInformationModel.serchAuth).single() as Map;
      // Define the format of your created_at timestamp
      final format = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS+00:00");
      // Convert the string representation of the created_at timestamp to a DateTime object
      DateTime createdAtDate = format.parse(result["created_at"]);
      // Get the current date and time
      DateTime now = DateTime.now();
      // Calculate the difference in days between the created_at timestamp and the current date
      accountDuration = now.difference(createdAtDate).inDays;
    } on PostgrestException catch (e) {
      accountDuration = 0;
      showGetSnackbar(message: e.message, type: Popup.error);
    }
  }

  @override
  void initState() {
    super.initState();
    getAccountDuration();
  }

  @override
  Widget build(BuildContext context) {
    List<BankDetails> bankDetails = [
      BankDetails(
        header: "Bank Card",
        widget: userBankCardModel.cardNumber.isEmpty ? const NoBankCard() : Container()
      ),
      BankDetails(
        header: "Bank Account",
        widget: userBankAccountModel.accountNumber.isEmpty ? const AddBankAccount() : SizedBox(
          height: 170,
          child: BankBox(
            bank: userBankAccountModel,
            isGrid: true,
            onMoreOptions: () {
              debugShow("hi");
              openBankOptions(bankId: userBankAccountModel.serchID, context: context);
            },
          ),
        )
      )
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
              size: 24, weight: FontWeight.bold
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
                          child: Text(
                            // "₦${plan.price}",
                            "T2F Earnings: ${CurrencyFormatter.formatter.format(double.parse(userInformationModel.balance))}",
                            style: const TextStyle(
                              fontFamily: "",
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Scolors.info
                            ),
                          ),
                        )
                      ],
                    )
                  ),

                  //Button to popup the bottomSheet for the user to enter account number for funds transfer
                  if(userBankAccountModel.accountNumber.isNotEmpty)
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
                            userBankAccountModel: userBankAccountModel,
                            userInformationModel: userInformationModel,
                            accountDuration: accountDuration,
                          ),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...bankDetails.map((item) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SText(
                        text: item.header,
                        size: 18,
                        weight: FontWeight.bold,
                        color: Theme.of(context).primaryColor
                      ),
                      const SizedBox(height: 10),
                      item.widget
                    ],
                  )).toList()
                ],
              )
            )
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
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
                ]
              )
            )
          ),
          if(transactionList.isEmpty)
          SliverToBoxAdapter(
            child: Column(
              children: const [
                SizedBox(height: 40),
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                ((context, index) {
                  return TransactionBox(userMoneyModel: transactionList[index]);
                }),
                childCount: transactionList.length
              )
            ),
          ),
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
    required UserBankAccountModel userBankAccountModel,
    required UserInformationModel userInformationModel,
    required int accountDuration,
  }){

    if(userInformationModel.totalServiceTrips >= 5 && accountDuration >= 30) {
      TextEditingController amount = MaskedTextController(mask: "00000");
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
                          child: Text(
                            // "₦${plan.price}",
                            "You can only make withdrawals once in a week!. Withdrawal limit is ${CurrencyFormatter.formatter.format(double.parse("20000"))} while the minimum is ${CurrencyFormatter.formatter.format(double.parse("1000"))}",
                            style: const TextStyle(
                              fontFamily: "",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: SColors.black
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ]
                    )
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        BankBox(bank: userBankAccountModel),
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
    } else if(userInformationModel.totalServiceTrips >= 5){
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
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SText(
                        text: "Hoping to make a withdrawal?",
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
                BankBox(bank: userBankAccountModel),
              ]
            ),
          )
        )
      );
    } else if(accountDuration < 30){
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
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SText(
                        text: "Hoping to make a withdrawal?",
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
                BankBox(bank: userBankAccountModel),
              ]
            ),
          )
        )
      );
    }
  }
}

addBankAccount({
  required BuildContext context,
  required UserInformationModel userInformationModel
}) async {
  final formKey = GlobalKey<FormState>();
  TextEditingController accountNumber = TextEditingController();
  String? myBank;
  bool verified = true;

  showModalBottomSheet(
    context: context,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    builder: (context) => KeyboardDismisser(
      gestures: const [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: StatefulBuilder(
        builder:(context, setState) => Container(
          padding: screenPadding,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
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
                        fillColor: Theme.of(context).backgroundColor,
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
                        fillColor: Theme.of(context).backgroundColor,
                        formColor: Theme.of(context).primaryColor,
                        enabledBorderColor: Theme.of(context).primaryColor,
                      ),
                      if(verified == false)
                      Column(
                        children: [
                          SFormField(
                            labelText: "${userInformationModel.firstName} ${userInformationModel.lastName}",
                            formName: "Account Name",
                            enabled: false,
                            cursorColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).backgroundColor,
                            formStyle: STexts.normalForm(context),
                            formColor: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 20)
                        ],
                      )
                      else
                      const SizedBox(height: 20),
                      if(verified == false)
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
      ),
    )
  );
}

class NoBankCard extends StatelessWidget {
  const NoBankCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.credit_card_off_rounded, color: Theme.of(context).primaryColorLight, size: 26),
            const SizedBox(width: 5),
            SText(
              text: "No Credit Card",
              size: 16,
              weight: FontWeight.bold,
              color: Theme.of(context).primaryColorLight
            )
          ]
        ),
      ),
    );
  }
}

class AddBankAccount extends StatelessWidget {
  const AddBankAccount({super.key});

  @override
  Widget build(BuildContext context) {
    UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
    return Material(
      color: Theme.of(context).backgroundColor,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: () => addBankAccount(context: context, userInformationModel: userInformationModel),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
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
    );
  }
}

class TransactionBox extends StatelessWidget {
  final UserMoneyModel userMoneyModel;
  const TransactionBox({super.key, required this.userMoneyModel});

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
          Expanded(
            child: Row(
              children: [
                UserAvatar.small(image: userMoneyModel.transactImage),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SText(
                        text: userMoneyModel.transactName, size: 18,
                        color: Theme.of(context).primaryColorLight, weight: FontWeight.bold
                      ),
                      const SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Text(
                              CurrencyFormatter.formatter.format(double.parse(userMoneyModel.transactAmount)),
                              style: const TextStyle(
                                fontFamily: "",
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: SColors.hint
                              ),
                            ),
                          ),
                          SText(
                            text: userMoneyModel.transactDate,
                            color: SColors.hint, weight: FontWeight.bold,
                          ),
                          Icon(
                            userMoneyModel.transactionType == "Outgoing" ? Icons.arrow_upward_rounded
                            : Icons.arrow_downward_rounded,
                            color: userMoneyModel.transactionType == "Outgoing" ? SColors.red : SColors.green,
                            size: 18
                          )
                        ]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 60,
            child: SText(
              text: userMoneyModel.transactStatus,
              color: userMoneyModel.transactStatus == "Pending" ? Scolors.info2
              : userMoneyModel.transactStatus == "Received" ? Scolors.success : Scolors.error,
              weight: FontWeight.bold
            ),
          ),
        ],
      )
    );
  }
}

class BankBox extends StatelessWidget{
  final UserBankAccountModel bank;
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
                Row(
                  children: [
                    Expanded(
                      child: SText(
                        color: SColors.white,
                        text: bank.bankName,
                        size: 18, weight: FontWeight.bold,
                        flow: TextOverflow.ellipsis,
                      ),
                    )
                    ,
                  ],
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
                  text: "${bank.accountNumber.substring(0, 6)}****",
                  size: 18, weight: FontWeight.bold,
                ),
                const SizedBox(height: 5),
                //Icon for more options and Bank Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(SImages.layers, width: 25,),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: onMoreOptions,
                      icon: const Icon( Icons.delete, size: 24, color: Scolors.error)
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