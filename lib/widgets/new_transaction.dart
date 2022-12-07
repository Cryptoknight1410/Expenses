import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class newTransaction extends StatefulWidget {
  Function add_new;
  newTransaction(this.add_new);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
  final _textcontroller = TextEditingController();

  final _amountcontroller = TextEditingController();
  DateTime? _selectDate = null;

  void submit_data() {
    final entered_tilte = _textcontroller.text;
    final entered_amount = double.parse(_amountcontroller.text);
    if (entered_tilte.isEmpty || entered_amount <= 0 || _selectDate == null) {
      return;
    } else {
      widget.add_new(_textcontroller.text, double.parse(_amountcontroller.text),
          _selectDate);
    }
    Navigator.of(context).pop();
  }

  void _presentDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
              decoration: InputDecoration(labelText: "Enter Title"),
              controller: _textcontroller,
              onSubmitted: (_) {
                submit_data();
                print(_);
              }),
          TextField(
              decoration: InputDecoration(label: Text('Enter Amount')),
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) {
                submit_data;
                print(_);
              }),
          Container(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(_selectDate == null
                      ? 'No date chosen'
                      : DateFormat.yMd().format(_selectDate!)),
                ),
                TextButton(
                  onPressed: _presentDatepicker,
                  child: Text('Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.purple),
              onPressed: submit_data,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
