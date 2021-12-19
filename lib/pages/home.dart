import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:time_tracker/pages/action_home.dart';
import 'package:time_tracker/pages/activity_home.dart';
import 'package:time_tracker/pages/stats.dart';

class Home extends StatefulWidget {

  static const String routeName = '/home';

  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedItem;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedItem = 1;
    _pageController = PageController(initialPage: _selectedItem);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToProfile(){

  }

  void _onItemTapped(int index){
    setState(() {
      _selectedItem = index;
      _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.face),
            onPressed: _goToProfile,
          )
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index){
          setState(() => _selectedItem = index);
        },
        children: [
          ActivityHome(),
          ActionHome(),
          Stats()
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() => BottomNavigationBar(
    items: [
      BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Activity',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(EvilIcons.chart),
        label: 'Stats',
      )
    ],
    currentIndex: _selectedItem,
    onTap: _onItemTapped,
    selectedItemColor: Colors.green,
  );
}

