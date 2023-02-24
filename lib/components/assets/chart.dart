
// return LineChartData(
//   lineTouchData: lineTouchData1,
//   gridData: gridData,
//   titlesData: titlesData1,
//   borderData: borderData,
//   lineBarsData: [
//     LineChartBarData(
//       spots: [
//         FlSpot(0, data['rating1']),
//         FlSpot(1, data['rating2']),
//         ...
//       ],
//       isCurved: true,
//       colors: [
//         Colors.red,
//       ],
//       barWidth: 4,
//       isStrokeCapRound: true,
//       dotData: FlDotData(
//         show: false,
//       ),
//       belowBarData: BarAreaData(
//         show: false,
//       ),
//     ),
//   ],
//   minX: 0,
//   maxX: data['numRatings'].toDouble(),
//   maxY: data['maxRating'].toDouble(),
//   minY: data['minRating'].toDouble(),
// );

// class SLineChart extends StatefulWidget {
//   @override
//   _SLineChartState createState() => _SLineChartState();
// }

// class _SLineChartState extends State<SLineChart> {
//   List<double> userRatings;
//   int numberOfRatings;

//   @override
//   void initState() {
//     super.initState();
//     // Call your function to fetch the user's data from your Supabase table here
//     // and store the results in the userRatings and numberOfRatings variables
//     fetchUserData().then((result) {
//       setState(() {
//         userRatings = result['userRatings'];
//         numberOfRatings = result['numberOfRatings'];
//       });
// /LineChartData get userData => LineChartData(
//   lineTouchData: lineTouchData1,
//   gridData: gridData,
//   titlesData: titlesData1,
//   borderData: borderData,
//   lineBarsData: userLineBarsData,
//   minX: minX,
//   maxX: maxX,
//   maxY: maxY,
//   minY: minY,
// );

// List<LineChartBarData> get userLineBarsData {
//   List<LineChartBarData> barData = [];
//   // Loop through the data from your database and create LineChartBarData objects
//   for (int i = 0; i < dataFromDatabase.length; i++) {
//     barData.add(LineChartBarData(
//       spots: dataFromDatabase[i].spots,
//       isCurved: dataFromDatabase[i].isCurved,
//       colors: dataFromDatabase[i].colors,
//       barWidth: dataFromDatabase[i].barWidth,
//       isStrokeCapRound: dataFromDatabase[i].isStrokeCapRound,
//       dotData: dataFromDatabase[i].dotData,
//       belowBarData: dataFromDatabase[i].belowBarData,
//     ));
//   }
//   return barData;
// }

// double get minX {
//   // Calculate the minimum value for the X axis based on the data from your database
//   return ...;
// }

// double get maxX {
//   // Calculate the maximum value for the X axis based on the data from your database
//   return ...;
// }

// double get maxY {
//   // Calculate the maximum value for the Y axis based on the data from your database
//   return ...;
// }

// double get minY {
//   // Calculate the minimum value for the Y axis based on the data from your database
//   return ...;
// }

// class UserLineChart extends StatelessWidget {
//   final List<double> userRatings;
//   final int numRatings;

//   UserLineChart({@required this.userRatings, @required this.numRatings});

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       getLineChartData(),
//       swapAnimationDuration: const Duration(milliseconds: 250),
//     );
//   }

//   LineChartData getLineChartData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(handleBuiltInTouches: true),
//       gridData: GridData(
//         show: true,
//         horizontalInterval: 1,
//         verticalInterval: 1,
//       ),
//       titlesData: FlTitlesData(
//         bottomTitles: AxisTitles(sideTitles: bottomTitles()),
//         leftTitles: AxisTitles(sideTitles: leftTitles()),
//       ),
//       lineBarsData: [
//         LineChartBarData(
//           spots: getSpots(),
//           isCurved: true,
//           colors: [Colors.blue],
//           barWidth: 4,
//         ),
//       ],
//       minX: 0,
//       maxX: userRatings.length - 1,
//       minY: 0,
//       maxY: 5,
//     );
//   }

//   List<FlSpot> getSpots() {
//     final spots = <FlSpot>[];
//     for (int i = 0; i < userRatings.length; i++) {
//       spots.add(FlSpot(i.toDouble(), userRatings[i]));
//     }
//     return spots;
//   }

//   SideTitles bottomTitles() {
//     return SideTitles(
//       showTitles: true,
//       reservedSize: 22,
//       textStyle: const TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//       getTitles: (value) {
//         final index = value.toInt();
//         if (index % 2 == 0) {
//           return 'Month ${index + 1}';
//         } else {
//           return '';
//         }
//       },
//     );
//   }

//   SideTitles leftTitles() {
//     return SideTitles(
//       showTitles: true,
//       reservedSize: 28,
//       textStyle: const TextStyle(
//         color: Colors.black,
//         fontWeight: FontWeight.bold,
//         fontSize: 14,
//       ),
//       getTitles: (value) {
//         return '${value.toInt()}';
//       },
//     );
//   }
// }


// List<FlSpot> getSpots(List<UserRatingsModel> userRatingsModel) {
//   final groupedRatings = groupBy(userRatingsModel, (rating) => rating.day);
//   final spots = <FlSpot>[];

//   groupedRatings.forEach((day, ratings) {
//     final totalRatings = ratings.length;
//     final totalRate = ratings.fold(0, (sum, rating) => sum + rating.rate);
//     final averageRate = totalRate / totalRatings;
//     spots.add(FlSpot(day.toDouble(), averageRate));
//   });

//   return spots;
// }


// List<UserRatingsModel> userRatingsModel = HiveUserDatabase().getRatingsDataList();

// List<FlSpot> getSpots() {
//   final spots = <FlSpot>[];
//   for (int i = 0; i < userRatingsModel.length; i++) {
//     double sum = userRatingsModel.where((rating) => rating.day == i + 1).map((rating) => rating.rate).reduce((a, b) => a + b);
//     int count = userRatingsModel.where((rating) => rating.day == i + 1).length;
//     double average = count == 0 ? 0 : sum / count;
//     spots.add(FlSpot(i.toDouble(), average));
//   }
//   return spots;
// }