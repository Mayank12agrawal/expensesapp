import 'package:expensesapp/chart.dart';
import 'package:expensesapp/new_transaction.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'transaction_list.dart';
import 'new_transaction.dart';
import 'transaction.dart';
import './chart.dart';
import 'package:flutter/services.dart';


void main()
{
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp,
    //DeviceOrientation.portraitDown,
  //]);
  runApp(new myApp());
}
class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      home: new Myhomepage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.red
      ),
    );
  }
}
class Myhomepage extends StatefulWidget {

  @override
  _MyhomepageState createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  final List<Transaction>transactions=[

  ];
  bool showchart=false;
  List<Transaction> get recenttransaction
  {
    return transactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),));
    }).toList();
  }
  void _addtrans(String title,double amount,DateTime chosendate)
  {
    final newTx=Transaction(
      title: title,
      amount: amount,
      date: chosendate,
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(newTx);
    });

  }


  void startAddNewTransaction(BuildContext ctx)
  {
    showModalBottomSheet(context: ctx,
        builder:(_){
           return GestureDetector(
             onTap: (){},
               child:NewTransaction(_addtrans),
           behavior: HitTestBehavior.opaque,
           );

        }, );
  }
  void deletertrans( String id)
  {
    setState(() {
      recenttransaction.removeWhere((tx) => tx.id == id);

    });
  }
  @override
  Widget build(BuildContext context) {
    final islandscape =MediaQuery.of(context).orientation==Orientation.landscape;

    final appbar=AppBar(
      title: Text('My Expenses App',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),

      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: ()=>startAddNewTransaction(context),
        )
      ],
    );
    final txwidget=Container(
        height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
        child: translist(transactions,deletertrans));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(islandscape) Row(
              mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Text('Show Chart'),
               Switch(value: showchart,
               onChanged: (val){
                 setState(() {
                   showchart=val;
                 });
               },),
             ],
            ),
            if(!islandscape)
              Container(
                  height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
                  child: Chart(recenttransaction)),
            if(!islandscape)
              txwidget,
            if(islandscape)
              showchart?Container(
                height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
                child: Chart(recenttransaction))
            :txwidget

          ],


        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>startAddNewTransaction(context),
      ),
    );
  }
}

