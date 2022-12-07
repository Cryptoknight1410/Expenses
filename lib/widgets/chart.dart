import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get grouped_trasactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total_sum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          total_sum = recentTransaction[i].amount + total_sum;
        }
      }
      return {
        'Day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': total_sum
      };
    }).reversed.toList();
  }

  double get total_spending {
    return grouped_trasactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(grouped_trasactions);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: grouped_trasactions.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    data['Day'] as String,
                    data['amount'] as double,
                    total_spending == 0.0
                        ? 0.0
                        : ((data['amount'] as double) / total_spending)),
              );
            }).toList()),
      ),
    );
  }
}
