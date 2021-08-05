import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book screen"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Text("book screen"),
                TextButton(
                    onPressed: () {
                      AutoRouter.of(context).pushNamed("/books/Karma");
                    },
                    child: Text("Goto details page"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
