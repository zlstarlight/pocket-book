import 'package:flutter/material.dart';

//登录后的主界面
class Page3 extends StatefulWidget {
  const Page3({super.key});
  static String tag = 'home_page';

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Center(
              child: Text(
                'Page3',
              ),
            )),
        body: Container());
  }
}
