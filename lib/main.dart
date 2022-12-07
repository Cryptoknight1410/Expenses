import 'package:expenses/widgets/chart.dart';
import 'package:expenses/widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());

  // var transactions1=[{'Khushi':1},{'Romil':2}];
  // print(transactions1[0]['Nirav']);
}

final _textcontroller = TextEditingController();
final _amountcontroller = TextEditingController();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'QuickSand',
          errorColor: Colors.red),
      home: HomePage(),
    );
  }
}

final List<Transaction> _usertransactions = [];
List<Transaction> get _recentTrasactions {
  return _usertransactions.where((tx) {
    return tx.date.isAfter(
      DateTime.now().subtract(Duration(days: 7)),
    );
  }).toList();
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _add_new_transaction(
      String txtitle, double txamount, DateTime chosen_date) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        date: chosen_date);

    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _delete_transaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _start_new_transaction_here(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return newTransaction(_add_new_transaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                _start_new_transaction_here(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTrasactions),
            TransactionList(_usertransactions, _delete_transaction)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColorDark,
        child: Icon(Icons.add),
        onPressed: () {
          _start_new_transaction_here(context);
        },
      ),
    );
  }
}
