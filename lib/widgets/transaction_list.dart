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
            ? Column(
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
                    height: 250,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
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
                      trailing: IconButton(
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
