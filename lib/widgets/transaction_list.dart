import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    return (
        // alignment: Alignment.center,
        // height: 400,
        // height: MediaQuery.of(context).size.height * 0.5,
        // child:
        transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                /**By using LayoutBuilder, it is
               * possible to get the constraint
               * of the container where
               * transaction_list widget
               * is used (which is main.dart
               * in this case)
               */
                return Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No transactions added yet',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              })
            : ListView(
                children:
                    /**Since we have only one widget
                 * we don't need to enclose the
                 * widget in a list[] and we do
                 * not need spread operator
                 * 
                 * Had to change ListView cos
                 * key from constructor is
                 * needed
                 */
                    transactions
                        .map((tx) => TransactionItem(
                              key: ValueKey(tx.id),
                              transaction: tx,
                              deleteTx: deleteTx,
                            ))
                        .toList()));

    // ListView.builder(

    //     itemBuilder: (ctx, index) {
    //       return TransactionItem(
    //           transaction: transactions[index], deleteTx: deleteTx);
    //     },
    //     itemCount: transactions.length,
    //   ));
  }
}



// return Card(
//                   child: Row(
//                     children: [
//                       Container(
//                         margin: const EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 15,
//                         ),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             // color: Colors.purple,
//                             color: Theme.of(context).primaryColor,
//                             width: 2,
//                           ),
//                         ),
//                         padding: const EdgeInsets.all(6),
//                         child: Text(
//                           '\$${transactions[index].amount.toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 12,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             transactions[index].title,
//                             // style: const TextStyle(
//                             //   fontSize: 12,
//                             //   fontWeight: FontWeight.bold,
//                             // ),
//                             style: Theme.of(context).textTheme.titleSmall,
//                           ),
//                           Text(
//                             DateFormat.yMMMd().format(transactions[index].date),
//                             style: const TextStyle(
//                               color: Colors.grey,
//                               fontSize: 10,
//                             ),
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 );
