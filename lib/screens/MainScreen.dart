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
  static final myController = TextEditingController();

  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    MyCatalogPage(""),
    MyProfileScreen(),
  ];

  void showSearchBar() {
    List<Widget> _searchActions = [
      IconButton(icon: Icon(Icons.more_vert), tooltip: "More", onPressed: null),
    ];

    setState(() {
      //TODO: remove search query from search bar if necessary
      _leading = IconButton(
          icon: Icon(Icons.arrow_back), onPressed: () => _onItemTapped(1));
      _title = TextField(
          controller: myController,
          style: TextStyle(fontSize: 22),
          decoration: InputDecoration(
              border: UnderlineInputBorder(), hintText: "Search..."),
          maxLines: 1,
          autofocus: true,
          cursorColor: Colors.white,
          onSubmitted: setSearchQuery);
      _actions = _searchActions;
    });
  }

  void setSearchQuery(String string) {
    print(string);

    setState(() {
      _body = MyCatalogPage(string);
    });
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
            //TODO: Implement function for shoppingCart screen here
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
