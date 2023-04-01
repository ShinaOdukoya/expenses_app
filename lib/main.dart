import 'dart:io';
// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
// import './widgets/user_transactions.dart';
import './model/transaction.dart';
import './widgets/chart.dart';

void main() {
  /**This need to be added first
   * otherwise SystemChrome...
   * might not work on some device
   */
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.grey,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleSmall: const TextStyle(
                fontFamily: 'OpenSans',
                // fontWeight: FontWeight.bold,
              ),
              //This was white implicitly
              //Just wanted to set it
              //explicitly
              //button: const TextStyle(color: Colors.white),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            // fontStyle: FontStyle.italic,
          ),
        ),
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.teal)
        //     .copyWith(secondary: Colors.grey),
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final titleController = TextEditingController();
  // final amountController = TextEditingController();

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New dress',
    //   amount: 48.99,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(
    String txTitle,
    double txAmount,
    DateTime chosenDate,
  ) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  bool _showChart = false;

  List<Transaction> get _recenTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();

    /**The algorithm below is also valid
     * just decided to go with the one
     * above.
     */
    // List<Transaction> recentTx = [];
    // for(var tx in _recenTransaction){
    //   if(tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
    //   {
    //     recentTx.add(tx);
    //   }
    // }
    // return recentTx;
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        /**Reason for GestureDetector
         * is to prevent BottomSheet from
         * closing when it is tapped.
         * Although it works perfeclty 
         * on ios.
         */
        return GestureDetector(
          onTap: () {},
          /**Then behavior is added to
           * so that the click on 
           * BottomSheet is captured
           * not to be captured by another
           * function
           */
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(
            addTransaction: _addNewTransaction,
          ),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Switch.adaptive(
              activeColor: Theme.of(context).accentColor,
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      mediaQuery.padding.top -
                      appBar.preferredSize.height) *
                  0.7, //0.3
              child: Chart(_recenTransaction),
            )
          :
          // UserTransactions(),
          txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
                mediaQuery.padding.top -
                appBar.preferredSize.height) *
            0.3, //0.3
        child: Chart(_recenTransaction),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expense'),
            trailing: Row(
              /**Cos the Row took all the 
               * available space. Had to
               * reduce
              */
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ))
        : AppBar(
            title: const Text(
              'Personal Expenes',
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(
                  Icons.add,
                ),
              )
            ],
          );

    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              mediaQuery.padding.top -
              appBar.preferredSize.height) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),
            // Container(
            //   width: double.infinity,
            //   child: const Card(
            //     color: Colors.blue,
            //     elevation: 5,
            //     child: Text('CHART!'),
            //   ),
            // ),
            if (!isLandscape)
              /**Requires a single widget
               * not list of widget
               * hence, the use of
               * spread operator
               */
              ..._buildPortraitContent(mediaQuery, appBar, txListWidget),
            if (!isLandscape) txListWidget,
            if (isLandscape)
              ..._buildPortraitContent(mediaQuery, appBar, txListWidget)
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? const SizedBox()
                : FloatingActionButton.small(
                    onPressed: () => _startAddNewTransaction(context),
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
          );
  }
}
