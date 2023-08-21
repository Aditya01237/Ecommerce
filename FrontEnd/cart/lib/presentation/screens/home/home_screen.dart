import 'package:cart/presentation/screens/home/category_screen.dart';
import 'package:cart/presentation/screens/home/profile_screen.dart';
import 'package:cart/presentation/screens/home/user_feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> screens = const [
    UserFeedScreen(),
    CategoryScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "S8UL STORE",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart_fill),
          )
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        unselectedItemColor: Colors.indigo[100],
        fixedColor: Colors.indigo[100],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: Colors.blueGrey[900],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.indigo[100]),
            label: "Home", // Change this to your desired text color
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category, color: Colors.indigo[100]),
            label: "Category",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.indigo[100]),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
