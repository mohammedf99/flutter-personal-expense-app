import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isNotEmpty
        ? ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              // return Card(
              //   child: Container(
              //     width: double.infinity,
              //     height: 75,
              //     padding: const EdgeInsets.all(2),
              //     child: Row(
              //       children: <Widget>[
              //         Container(
              //           margin: const EdgeInsets.symmetric(
              //             vertical: 5,
              //             horizontal: 7.5,
              //           ),
              //           decoration: BoxDecoration(
              //             border: Border.all(
              //               color: Theme.of(context).primaryColorDark,
              //               width: 2,
              //             ),
              //           ),
              //           padding: const EdgeInsets.all(10),
              //           child: Text(
              //             '\$${transactions[index].amount.toStringAsFixed(2)}',
              //             style: TextStyle(
              //               fontSize: 26,
              //               color: Theme.of(context).primaryColorDark,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ),
              //         Container(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: <Widget>[
              //               Text(
              //                 transactions[index].title,
              //                 style: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w500,
              //                 ),
              //               ),
              //               Text(
              //                 DateFormat('EEEE MMM d, y')
              //                     .format(transactions[index].date),
              //                 style: const TextStyle(
              //                   fontSize: 16,
              //                   fontWeight: FontWeight.w400,
              //                   color: Colors.grey,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // );
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                elevation: 3,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMEd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 420
                      ? TextButton.icon(
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: const Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () =>
                              deleteTransaction(transactions[index].id),
                        ),
                ),
              );
            },
          )
        : LayoutBuilder(
            builder: ((context, constraints) {
              return Column(
                children: [
                  Text(
                    'Nothing is added',
                    style: Theme.of(context).appBarTheme.titleTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.75,
                    child: Image.asset(
                      'assets/images/empty.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              );
            }),
          );
  }
}