import 'package:flutter/material.dart';

class newTransaction extends StatefulWidget {
  Function add_new;
  newTransaction(this.add_new);

  @override
  State<newTransaction> createState() => _newTransactionState();
}

class _newTransactionState extends State<newTransaction> {
final _textcontroller=TextEditingController();

final _amountcontroller=TextEditingController();

void submit_data(){
  final entered_tilte=_textcontroller.text;
  final entered_amount=double.parse(_amountcontroller.text);
  if(entered_tilte.isEmpty || entered_amount<=0){
      return;
  }
  else{
  widget.add_new(_textcontroller.text,double.parse(_amountcontroller.text));

  }
  Navigator.of(context).pop();
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
                          controller: _textcontroller  ,
                              onSubmitted:(_){submit_data();print(_);}
                            ),
                          TextField(
                            decoration:
                                InputDecoration(label: Text('Enter Amount')),
                                 controller: _amountcontroller,
                                 keyboardType: TextInputType.number,
                                 onSubmitted:(_){submit_data;print(_);}
                          
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.white),
                                                          onPressed: submit_data,
                              child: Text(
                                'Add Transaction',
                                style: TextStyle(color: Theme.of(context).primaryColorDark),
                              ))
                        ],),
                  );
  }
}