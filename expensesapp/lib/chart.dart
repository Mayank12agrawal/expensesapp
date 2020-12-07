import 'package:expensesapp/chartbar.dart';
import 'package:expensesapp/transaction.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';
class Chart extends StatelessWidget {
  final List<Transaction> recenttrans;
  Chart(this.recenttrans);
  List<Map<String,Object>>get Groupedtransactionvalue
  {
     return List.generate(7, (index) {
       final weekday=DateTime.now().subtract(Duration(days: index),);
       var totalsum=0.00;
       for(var i=0;i<recenttrans.length;i++)
         {
           if(recenttrans[i].date.day==weekday.day &&recenttrans[i].date.month==weekday.month&&recenttrans[i].date.year==weekday.year)
             {
               totalsum+=recenttrans[i].amount;
             }
         }
      return{
       'day':DateFormat.E().format(weekday).substring(0,1),
       'amount':totalsum,
      };
     }).reversed.toList();
  }
  double get totalspending
  {
    return Groupedtransactionvalue.fold(0.0, (sum, item){
      return sum+item['amount'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children:
              Groupedtransactionvalue.map((data){
                return Flexible(
                  fit: FlexFit.tight,
                  child: Chartbar(
                      data['day'],
                      data['amount'],
                      totalspending==0?0.0:(data['amount'] as double)/totalspending),
                );
              }).toList(),


          ),
        ),
      ),
    );
  }
}
