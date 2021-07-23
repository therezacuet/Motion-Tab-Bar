import 'package:flutter/material.dart';
import 'package:motion_tab_bar/MotionTabBarView.dart';
import 'package:motion_tab_bar/MotionTabController.dart';
import 'package:motion_tab_bar/motiontabbar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motion Tab Bar Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Motion Tab Bar Sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  MotionTabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = MotionTabController(initialIndex: 1, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      bottomNavigationBar: MotionTabBar(
        labels: const ["Account", "Home", "Dashboard"],
        initialSelectedTab: "Home",
        tabIconColor: Colors.green,
        tabSelectedColor: Colors.red,
        onTabItemSelected: (int value) {
          // ignore: avoid_print
          print(value);
          setState(() {
            _tabController!.index = value;
          });
        },
        icons: const [Icons.account_box, Icons.home, Icons.menu],
        textStyle: const TextStyle(color: Colors.red),
      ),
      body: MotionTabBarView(
        controller: _tabController,
        // ignore: prefer_const_literals_to_create_immutables
        children: <Widget>[
          const Center(
            child: Text("Account"),
          ),
          const Center(
            child: Text("Home"),
          ),
          const Center(
            child: Text("Dashboard"),
          ),
        ],
      ),
    );
  }
}
