import 'package:cart/logic/cubits/user_cubit/user_cubit.dart';
import 'package:cart/presentation/screens/cart/cart_screen.dart';
import 'package:cart/presentation/screens/home/category_screen.dart';
import 'package:cart/presentation/screens/home/profile_screen.dart';
import 'package:cart/presentation/screens/home/user_feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubits/cart_cubit/cart_cubit.dart';
import '../../../logic/cubits/cart_cubit/cart_state.dart';
import '../../../logic/cubits/user_cubit/user_state.dart';
import '../splash/splash_screen.dart';

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
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserLoggedOutState) {
          Navigator.pushReplacementNamed(context, SplashScreen.routeName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "S8UL STORE",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return Badge(
                    label: Text("${state.items.length}"),
                    isLabelVisible:
                        (state is CartLoadingState || state.items.isEmpty)
                            ? false
                            : true,
                    child: const Icon(CupertinoIcons.cart_fill),
                  );
                },
              ),
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
      ),
    );
  }
}
