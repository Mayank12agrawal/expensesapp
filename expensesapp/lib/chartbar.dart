import 'package:flutter/material.dart';
class Chartbar extends StatelessWidget {
  final String label;
  final double tranamount;
  final double transperc;
  Chartbar(this.label,this.tranamount,this.transperc);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx,constraints)
    {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight*0.15,
            child: FittedBox(
                child: Text('\$${tranamount.toStringAsFixed(0)}')),
          ),
          SizedBox(
            height: constraints.maxHeight*0.05,
          ),
          Container(
            height: constraints.maxHeight*0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,
                        width: 1.0),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),

                ),
                FractionallySizedBox(
                  heightFactor: transperc,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight*0.05,
          ),
          Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(child: Text(label))),
        ],

      );
    },);
  }
}
