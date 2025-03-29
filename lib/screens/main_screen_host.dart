import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/utils/constants.dart';

class MainScreenHost extends StatefulWidget {
  const MainScreenHost({super.key});

  @override
  State<MainScreenHost> createState() => _MainScreenHostState();
}

class _MainScreenHostState extends State<MainScreenHost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
        selectedItemColor: secondaryDark,
        unselectedItemColor: fontLight,
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/icons/home-1.png'), label: 'Home'),
          BottomNavigationBarItem(icon: Image.asset('assets/icons/chart-vertical.png'), label: 'Reports'),
          BottomNavigationBarItem(icon: Image.asset('assets/icons/wallet.png'), label: 'Saving Goals'),
          BottomNavigationBarItem(icon: Image.asset('assets/icons/user-1.png'), label: 'Profile'),
        ],
      ),
    );
  }
}