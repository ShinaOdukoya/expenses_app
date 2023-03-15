// import 'package:flutter/material.dart';
// import './new_transaction.dart';
// import './transaction_list.dart';
// import '../model/transaction.dart';

// class UserTransactions extends StatefulWidget {
//   const UserTransactions({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _UserTransactionsState createState() => _UserTransactionsState();
// }

// class _UserTransactionsState extends State<UserTransactions> {
//   final List<Transaction> _userTransactions = [
//     Transaction(
//       id: 't1',
//       title: 'New shoes',
//       amount: 69.99,
//       date: DateTime.now(),
//     ),
//     Transaction(
//       id: 't2',
//       title: 'New dress',
//       amount: 48.99,
//       date: DateTime.now(),
//     ),
//   ];
//   // with SingleTickerProviderStateMixin {
//   // late AnimationController _controller;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = AnimationController(vsync: this);
//   // }

//   // @override
//   // void dispose() {
//   //   super.dispose();
//   //   _controller.dispose();
//   // }

//   void _addNewTransaction(String txTitle, double txAmount) {
//     final newTx = Transaction(
//       title: txTitle,
//       amount: txAmount,
//       date: DateTime.now(),
//       id: DateTime.now().toString(),
//     );

//     setState(() {
//       _userTransactions.add(newTx);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         NewTransaction(
//           addTransaction: _addNewTransaction,
//         ),
//         TransactionList(_userTransactions, ),
//       ],
//     );
//   }
// }
