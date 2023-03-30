import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/transaction.dart';

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
            : ListView.builder(
                /**
       * child: ListView(
       *  children[
        *  transactionsList.map((ctx)=>{
        *    Card()
        *  })
       *  ]
       * )
       */
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 2,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        // radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date),
                        style: const TextStyle(fontSize: 9),
                      ),
                      trailing: MediaQuery.of(context).size.width > 420
                          /**The condition is for displaying
                       * depending on type of screen
                       * rather than orientation
                       */
                          ? TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                              label: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            )
                          : IconButton(
                              icon: const Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () => deleteTx(transactions[index].id),
                            ),
                    ),
                  );
                },
                itemCount: transactions.length,
                // children: [
                //   ...transactions
                //       .map((tx) =>
                //       .toList(),
                // ],
              ));
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
