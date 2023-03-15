import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions, {super.key});

  List<Map<String, Object>> get groupTransactionsValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        // for(var j=0; j < 7; j++){
        //   final wkDay = DateTime.now().subtract(
        //     Duration(days: j)
        //   );
        // }

        double totalSum = 0;

        for (var i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date.day == weekDay.day &&
              recentTransactions[i].date.month == weekDay.month &&
              recentTransactions[i].date.year == weekDay.year) {
            totalSum += recentTransactions[i].amount;
          }
        }
        // print(DateFormat.E().format(weekDay));
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum
        };
      },
      //Had to reverse the list
      //so the days of the week
      //wld start from tomorrow
    ).reversed.toList();
  }

  double get totalSpending {
    return groupTransactionsValues.fold(0.0, (previousValue, item) {
      return previousValue + (item['amount'] as double);
    });
  }

  // ignore: slash_for_doc_comments
  /**Another way of implementing
   * the method
   */
  // double get totalSpending {
  //   List currentAmount = [];
  //   double sum = 0;
  //   for (var i = 0; i < groupTransactionsValues.length; i++) {
  //     currentAmount[i] = groupTransactionsValues[i]['amount'];
  //     sum += currentAmount[i];
  //   }
  //   return sum;
  // }

  @override
  Widget build(BuildContext context) {
    // print(groupTransactionsValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          ...groupTransactionsValues.map((data) {
            return Flexible(
              /**Flexible isn't necessary
                 * as far as Text is
                 * wrap with FittedBox
                 * widget
                 */
              // fit: FlexFit.tight,
              child: ChartBar(
                  (data['day'] as String),
                  double.parse(data['amount'].toString()),
                  totalSpending == 0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            );
          }).toList()
        ]),
      ),
    );
  }
}
