import 'package:bookzapp/Widgets/CatalogSearch.dart';
import 'package:bookzapp/screens/MyCatalogPage.dart';
import 'package:bookzapp/screens/MyHomePage.dart';
import 'package:bookzapp/screens/MyProfileScreen.dart';
import 'package:bookzapp/screens/MyShoppingList.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MainScreenState();

}
class _MainScreenState extends State<MainScreen>{

  int _selectedIndex = 0;
  Widget _title = Text("Home");
  Widget _leading;
  Widget _body = _widgetOptions.elementAt(0);

  List<Widget> _actions;

  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyCatalogPage(),
    MyProfileScreen(),
  ];

  void showSearchBar() {
    showSearch(context: context, delegate: CatalogSearch());
  }

  void showShoppingCart() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyShoppingList(),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _title = Text("Home");
          _actions = null;
          _leading = null;
          break;
        case 1:
          _title = Text("Catalog");
          _actions = [
            IconButton(
                icon: Icon(Icons.search),
                tooltip: "Search",
                onPressed: showSearchBar),
            IconButton(
                icon: Icon(Icons.shopping_cart),
                tooltip: "Show cart",
                onPressed: showShoppingCart),
          ];
          _leading = null;
          break;
        case 2:
          _title = Text("Profile");
          _actions = null;
          _leading = null;
          break;
      }
      _body = _widgetOptions.elementAt(_selectedIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _leading,
        title: _title,
        actions: _actions,
      ),
      body: _body,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Catalog',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }


}
