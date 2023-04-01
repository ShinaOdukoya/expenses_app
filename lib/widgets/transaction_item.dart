import 'package:flutter/material.dart';
import '../model/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
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
              child: Text('{\$$transaction.amount}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        subtitle: Text(
          DateFormat.yMMMMd().format(transaction.date),
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
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}
