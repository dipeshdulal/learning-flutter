import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BooksDetailScreen extends StatelessWidget {
  const BooksDetailScreen({Key? key, @PathParam("bookId") this.bookId})
      : super(key: key);

  final String? bookId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$bookId Book"),
      ),
      body: Container(
        child: Center(
          child: Text("book detail screen"),
        ),
      ),
    );
  }
}
