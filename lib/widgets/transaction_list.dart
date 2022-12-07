import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;

  final Function deletetx;
  TransactionList(this.transaction, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added Yet',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 250,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.contain,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.purple,
                              width: 2,
                              style: BorderStyle.solid)),
                      child: Text(
                        'Rs.${transaction[index].amount..toStringAsFixed(2)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                      padding: EdgeInsets.all(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transaction[index].title,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat.yMMMd().format(transaction[index].date),
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () => {deletetx(transaction[index].id)},
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    )
                  ],
                ));
              },
              itemCount: transaction.length,
            ),
    );
  }
}
