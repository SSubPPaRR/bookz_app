import 'package:bookzapp/screens/MyHomePage.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MainScreenState();

}
class _MainScreenState extends State<MainScreen>{

  int _selectedIndex = 0;
  String _title = "Home";
  List<Widget> _actions;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    Text(
      'Index 1: Catalog',
      style: optionStyle,
    ),
    Text(
      'Index 2: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch(index){
        case 0: _title = "Home";
                _actions = null;
        break;
        case 1: _title = "Catalog";
                _actions = [
                  IconButton(icon: Icon(Icons.search), tooltip: "Search", onPressed: null),
                  IconButton(icon: Icon(Icons.shopping_cart), tooltip: "Show cart", onPressed: null),
                ];
        break;
        case 2: _title = "Profile";
                _actions = null;
        break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        actions: _actions,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text('Catalog'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }


}
