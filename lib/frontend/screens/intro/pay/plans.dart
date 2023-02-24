import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import 'package:provide/lib.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  final plugin = PaystackPlugin();
  final padding = const EdgeInsets.all(16.0);

  @override
  void initState() {
    super.initState();
    plugin.initialize(publicKey: paystackPublicKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: padding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        SImages.logo,
                        width: 35,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SText(
                    text: "Best Plans, Best Choices",
                    color: Theme.of(context).primaryColor,
                    size: 24,
                    weight: FontWeight.w900,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: horizontalPadding,
                    child: SText.center(
                      text: "We have curated a list of plans suitable for you at any time.",
                      color: SColors.hint,
                      size: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Wrap(
                      children: [
                        const SText(
                          text: "NOTE: Before subscribing to a plan or activating your free plan, it is important to check if Serch has launched in your city, state or country.",
                          color: SColors.hint,
                          weight: FontWeight.bold,
                          size: 14
                        ),
                        SButtonText(
                          text: "If you want to be sure,",
                          textButton: "click here to know more",
                          textColor: SColors.hint,
                          textButtonColor: SColors.lightPurple,
                          spacing: 3,
                          size: 14,
                          weight: FontWeight.bold,
                          onClick: () {},
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: padding,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index){
                  var plan = serchPlans[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Material(
                      borderRadius: BorderRadius.circular(6),
                      color: plan.bgColor,
                      elevation: 1,
                      shadowColor: Colors.black26,
                      child: InkWell(
                        onTap:() => plan.planName.contains("Free")
                        ? Get.to(() => const FreeTrialActivatedScreen())
                        : openPayForm(context: context, selectedPlan: plan.planName),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                Image.asset(plan.planImage, width: 50,),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SText(text: plan.planName, size: 20, weight: FontWeight.bold,),
                                      plan.price.contains("No fees") ? SText(
                                        text: plan.price,
                                        // : MoneyFormats().formatter.format(double.parse(plan.price)),
                                        size: 16, weight: FontWeight.bold,
                                      ) : Text(
                                        // "₦${plan.price}",
                                        CurrencyFormatter.formatter.format(double.parse(plan.price)),
                                        style: const TextStyle(
                                          fontFamily: "",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: SColors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],),
                              const SizedBox(height: 10),
                              ...plan.content.map((content) => Padding(
                                padding: const EdgeInsets.only(left: 60, bottom: 5),
                                child: Row(children: [
                                  Image.asset(SImages.checked, width: 15, color: SColors.white,),
                                  const SizedBox(width: 5),
                                  Expanded(child: SText(text: content, size: 16))
                                ]),
                              )).toList(),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SButton(
                                    text: "Get ${plan.planName}",
                                    padding: const EdgeInsets.all(8),
                                    textSize: 16, textWeight: FontWeight.bold,
                                    onClick: () => plan.planName.contains("Free")
                                    ? Get.offAll(() => const FreeTrialActivatedScreen())
                                    : openPayForm(context: context, selectedPlan: plan.planName),
                                  ),
                                  SText.right(text: plan.duration, size: 16, weight: FontWeight.bold,),
                                ],
                              )
                            ]
                          ),
                        ),
                      ),
                    ),
                  );
                },
                childCount: serchPlans.length
              )
            )
          ),

          SliverPadding(
            padding: padding,
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SButtonText(
                    text: "Need help selecting?",
                    textButton: "Read about Serch plans",
                    textColor: Theme.of(context).primaryColor,
                    textButtonColor: SColors.lightPurple,
                    onClick: () => Get.to(() => const WebViewScreen(url: "help.serchservice.com")),
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                  )
                ],
              )
            ),
          )
        ],
      ),
    );
  }
}

void openPayForm({required BuildContext context, required String selectedPlan}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: 1,
    isScrollControlled: true,
    builder:(context) {
      return StatefulBuilder(builder:(context, setState) {
        final formKey = GlobalKey<FormState>();
        String cardName = "";
        String cardNumber = "";
        String cardCode = "";
        String date = "";

        void onCreditCardModelChange(UserBankCardModel creditCardModel) {
          setState(() {
            cardNumber = creditCardModel.cardNumber;
            date = creditCardModel.cardExpiryDate;
            cardName = creditCardModel.cardName;
            cardCode = creditCardModel.cardCode;
          });
        }
        final width = MediaQuery.of(context).size.width;

        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: screenPadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.chevron_left_rounded, color: Theme.of(context).primaryColor, size: 40,)
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 2, top: 6),
                            child: SText.center(
                              text: "Enter Card Details to Proceed",
                              color: Theme.of(context).primaryColor,
                              size: 18,
                              weight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SPayCard(
                        cardCode: cardCode,
                        cardName: cardName,
                        cardNumber: cardNumber,
                        date: date,
                        width: width
                      ),
                      PayForm(
                        cardCode: cardCode,
                        cardName: cardName,
                        cardNumber: cardNumber,
                        date: date,
                        formKey: formKey,
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      const SizedBox(height: 40),
                      SButton(
                        text: "Enjoy $selectedPlan",
                        width: width,
                        padding: const EdgeInsets.all(12),
                        textWeight: FontWeight.bold,
                        textSize: 18,
                        onClick: () => {},
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset(SImages.tagline, width: 150, color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        );
      },);
    },
  );
}