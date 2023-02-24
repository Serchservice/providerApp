import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provide/lib.dart';

class SummaryRatingScreen extends StatefulWidget {
  const SummaryRatingScreen({super.key});

  @override
  State<SummaryRatingScreen> createState() => _SummaryRatingScreenState();
}

class _SummaryRatingScreenState extends State<SummaryRatingScreen> {
  UserInformationModel userInformationModel = HiveUserDatabase().getProfileData();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: SColors.yellow,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: const SText(text: "NOTE: Ratings are summarized on a three-month basis. Be advised.",)
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: double.parse(userInformationModel.totalRating),
                itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                itemCount: 5,
                itemSize: 15.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.arrow_up_arrow_down,
                    size: 16,
                    color: double.parse(userInformationModel.totalRating) >= 3.5 ? SColors.green
                    : double.parse(userInformationModel.totalRating) >= 1.5 ? SColors.yellow : SColors.red
                  ),
                  const SizedBox(width: 10),
                  SText(
                    text: userInformationModel.totalRating,
                    size: 16,
                    weight: FontWeight.bold,
                    color: double.parse(userInformationModel.totalRating) >= 3.5 ? SColors.green
                    : double.parse(userInformationModel.totalRating) >= 1.5 ? SColors.yellow : SColors.red
                  )
                ],
              )
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const SummaryRateChart(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: double.parse(userInformationModel.totalRating) >= 3.5 ? SColors.green
                  : double.parse(userInformationModel.totalRating) >= 1.5 ? SColors.yellow : SColors.shimmer,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: double.parse(userInformationModel.totalRating) >= 3.5 ? Wrap(
                  runSpacing: 5.0,
                  children: const [
                    SText(text: "You are doing great so far, and we commend you for that. ", color: SColors.white, size: 16),
                    SText(text: "Never stop in these good reviews, that is a sign that people love what you do. ", color: SColors.white, size: 16),
                    SText(text: "It's also a sign that you love what Serch does for you. ", color: SColors.white, size: 16),
                    Center(child: Icon(FontAwesomeIcons.solidFaceGrinHearts, size: 24, color: SColors.rate))
                  ],
                )
                : double.parse(userInformationModel.totalRating) >= 1.5 ? Wrap(
                  runSpacing: 5.0,
                  children: const [
                    SText(text: "We see your efforts and we commend that very well. More to your elbow!.", color: SColors.white, size: 16),
                    SText(text: "Looking forward to seeing you grow in these good ratings. We are so thrilled.", color: SColors.white, size: 16),
                    SText(text: "Serch's got your back by providing you details on how far you have gone.", color: SColors.white, size: 16),
                    Center(child: Icon(FontAwesomeIcons.solidFaceGrinWink, size: 24, color: SColors.rate))
                  ],
                )
                : Wrap(
                  runSpacing: 5.0,
                  children: const [
                    SText(text: "Starting out newly or having a bad day? Serch believes in your ability to do more.", color: SColors.white, size: 16),
                    SText(text: "There are several ways which you can improve your rating and Serch has such tips for you on our youtube platform.", color: SColors.white, size: 16),
                    SText(text: "NOTE: SERCH RESERVES THE RIGHT TO SUSPEND YOUR ACCOUNT IF YOUR RATING IS CONSISTENTLY LOW.", color: SColors.rate, size: 18),
                    Center(child: Icon(FontAwesomeIcons.solidFaceAngry, size: 24, color: SColors.rate))
                  ],
                )
              ),
              const SizedBox(height: 20)
            ],
          )
        )
      ],
    );
  }
}

class SummaryRateChart extends StatefulWidget {
  const SummaryRateChart({super.key});

  @override
  State<StatefulWidget> createState() => SummaryRateChartState();
}

class SummaryRateChartState extends State<SummaryRateChart> {
  List<UserRatingsModel> userRatings = HiveUserDatabase().getRatingsDataList();
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          gradient: LinearGradient(
            colors: [
              Color(0xFF0D0B17),
              Color(0xFF0A0A0A),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 30),
                const SText.center(text: 'Your Serch Account Rating Summary', color: Color(0xff827daa), size: 16,),
                const SizedBox(height: 4),
                const SText.center(text: 'Monthly Summary', color: SColors.white, size: 26, weight: FontWeight.bold,),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child: LineChart(sampleData),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }

  LineChartData get sampleData => LineChartData(
    lineTouchData: lineTouchData,
    gridData: gridData,
    titlesData: titlesData,
    borderData: borderData,
    lineBarsData: lineBarsData,
    minX: 0,
    maxX: 15,
    maxY: 5,
    minY: 0,
  );

  LineTouchData get lineTouchData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesData => FlTitlesData(
    bottomTitles: AxisTitles(sideTitles: bottomTitles),
    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    leftTitles: AxisTitles(sideTitles: leftTitles()),
  );

  List<LineChartBarData> get lineBarsData => [
    lineChartBarData1,
    // lineChartBarData2,
    // lineChartBarData3,
  ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1: text = '1.0'; break;
      case 2: text = '2.0'; break;
      case 3: text = '3.0'; break;
      case 4: text = '4.0'; break;
      case 5: text = '5.0'; break;
      default: return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2: text = Text(getMonths().lastTwoMonths, style: style); break;
      case 7: text = Text(getMonths().lastMonth, style: style); break;
      case 12: text = Text(getMonths().currentMonth, style: style); break;
      default: text = const Text(''); break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: const Border(
      bottom: BorderSide(color: Color(0xFF292929), width: 4),
      left: BorderSide(color: Colors.transparent),
      right: BorderSide(color: Colors.transparent),
      top: BorderSide(color: Colors.transparent),
    ),
  );

  List<FlSpot> getSpots() {
    final spots = <FlSpot>[];
    // Create a map to keep track of the counts of each rating for each day
    final counts = <int, Map<int, int>>{};
    for (final rating in userRatings) {
      final day = rating.day;
      if (!counts.containsKey(day)) {
        counts[day] = {};
      } else {
        final count = counts[day];
        count![rating.rate.toInt()] = (count[rating.rate.toInt()] ?? 0) + 1;
      }
    }

    // Calculate the average for each day based on the counts
    for (final entry in counts.entries) {
      final day = entry.key;
      final count = entry.value;
      final total = count.values.fold(0, (sum, count) => sum + count);
      final average = total == 0 ? 0 : count.entries.fold(0, (sum, entry) => sum + entry.key * entry.value) / total;
      spots.add(FlSpot(day.toDouble(), average.toDouble()));
    }

    return spots;
  }

  LineChartBarData get lineChartBarData1 => LineChartBarData(
    isCurved: true,
    color: const Color(0xff4af699),
    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: getSpots(),
  );

  LineChartBarData get lineChartBarData2 => LineChartBarData(
    isCurved: true,
    color: const Color(0xffaa4cfc),
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: const Color(0x00aa4cfc),
    ),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarData3 => LineChartBarData(
    isCurved: true,
    color: const Color(0xff27b6fc),
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 2.8),
      FlSpot(3, 1.9),
      FlSpot(6, 3),
      FlSpot(10, 1.3),
      FlSpot(13, 2.5),
    ],
  );
}

class Months{
  String currentMonth;
  String lastMonth;
  String lastTwoMonths;
  Months({required this.currentMonth, required this.lastMonth, required this.lastTwoMonths});
}

Months getMonths() {
  var now = DateTime.now();
  int currentMonth = now.month;

  switch (currentMonth) {
    case 1:
      return Months(currentMonth: "JAN", lastMonth: "DEC", lastTwoMonths: "NOV");
    case 2:
      return Months(currentMonth: "FEB", lastMonth: "JAN", lastTwoMonths: "DEC");
    case 3:
      return Months(currentMonth: "MAR", lastMonth: "FEB", lastTwoMonths: "JAN");
    case 4:
      return Months(currentMonth: "APR", lastMonth: "MAR", lastTwoMonths: "FEB");
    case 5:
      return Months(currentMonth: "MAY", lastMonth: "APR", lastTwoMonths: "MAR");
    case 6:
      return Months(currentMonth: "JUN", lastMonth: "MAY", lastTwoMonths: "APR");
    case 7:
      return Months(currentMonth: "JUL", lastMonth: "JUN", lastTwoMonths: "MAY");
    case 8:
      return Months(currentMonth: "AUG", lastMonth: "JUL", lastTwoMonths: "JUN");
    case 9:
      return Months(currentMonth: "SEP", lastMonth: "AUG", lastTwoMonths: "JUL");
    case 10:
      return Months(currentMonth: "OCT", lastMonth: "SEP", lastTwoMonths: "AUG");
    case 11:
      return Months(currentMonth: "NOV", lastMonth: "OCT", lastTwoMonths: "SEP");
    default:
      return Months(currentMonth: "DEC", lastMonth: "NOV", lastTwoMonths: "OCT");
  }
}