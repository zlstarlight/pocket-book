import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../cost/cost_page.dart';
import '../page1.dart';
import '../page3.dart';

//登录后的主界面
class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  static String tag = 'home_page';

  @override
  ConsumerState<HomePage> createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  final List _tabPages = [const CostPage(), const Page1(), const Page3()];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 24.0,
              ),
              label: '主页',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.event_note,
                size: 24.0,
              ),
              label: '统计',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24.0,
              ),
              label: '我的',
              backgroundColor: Colors.blue,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }),
    );
  }
}
