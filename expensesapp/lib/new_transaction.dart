import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titlecontroller=TextEditingController();

  final amountcontroller=TextEditingController();
  DateTime selecteddate;

  void submitdata()
  {
    final entertitle=titlecontroller.text;
    final enteramount=double.parse(amountcontroller.text);
    if(entertitle.isEmpty ||enteramount<=0||selecteddate==null)
      {
        return;
      }

    widget.addtx(
        entertitle,
       enteramount,
      selecteddate,
    );
    Navigator.of(context).pop();
  }
  void presentdatepicker()
  {
    showDatePicker(context:context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now()).then(((pickedDate){
          if(pickedDate==null)
            {
              return;
            }
          setState(() {
            selecteddate=pickedDate;
          });

    }));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom+10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:<Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                controller: titlecontroller,
                onSubmitted: (_)=>submitdata(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'amount',

                ),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (_)=>submitdata(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(selecteddate==null?'No date chosen':DateFormat.yMd().format(selecteddate))),
                    FlatButton(child: Text('Choose Date',style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                    textColor: Colors.green,
                    onPressed: presentdatepicker,),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Colors.green,
                onPressed: submitdata,
                textColor: Colors.white,

              )

            ],
          ),
        ),
      ),
    );
  }
}
