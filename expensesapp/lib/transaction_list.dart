import 'dart:ui';

import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';
class translist extends StatelessWidget {

 final List<Transaction> transactions;
 final Function deletetx;
 translist(this.transactions,this.deletetx);
  @override
  Widget build(BuildContext context) {
    return
        SingleChildScrollView(
          child: Container(

            child: Column(
              children: transactions.map((tx){
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 15
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 2,
                            )
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tx.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),),
                          Text(
                            DateFormat('yyyy/MM/dd').format(tx.date),
                            style: TextStyle(
                              color: Colors.grey,
                            ),),

                        ],
                      ),

                    ],

                  ),
                );
              }).toList(),

    ),
          ),
        );
  }
}
