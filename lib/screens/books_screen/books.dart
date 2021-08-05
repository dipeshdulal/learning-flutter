import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({Key? key}) : super(key: key);

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  int _currentIndex = 0;

  static const List<Widget> _options = <Widget>[
    Text(
      "Index 0: Home",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Text(
      "Index 1: Business",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
    Text(
      "Index 2: School",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book screen"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  "Drawer Header",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              title: const Text("Item 1"),
              onTap: () {},
            ),
            Divider(height: 2),
            ListTile(
              title: const Text("Item 2"),
              onTap: () {},
            ),
            Divider(height: 2),
            ListTile(
              title: const Text("Item 3"),
              onTap: () {},
            ),
            Divider(height: 2),
            ListTile(
              title: const Text("Item 4"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("book screen"),
              TextButton(
                onPressed: () {
                  AutoRouter.of(context).pushNamed("/books/Karma");
                },
                child: Text("Goto details page"),
              ),
              _options.elementAt(_currentIndex),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.business), label: "Business"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "School"),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (idx) {
          setState(() {
            _currentIndex = idx;
          });
        },
      ),
    );
  }
}
