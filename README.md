# Motion Tab Bar

A beautiful animated widget for your Flutter apps

**Preview:**

|![MotionTabBar Gif](https://github.com/therezacuet/Motion-Tab-Bar/blob/master/motiontabbar.gif?raw=true) |

## Getting Started

Add the plugin:

```yaml
dependencies:
  motion_tab_bar: ^0.2.0
```

## Basic Usage

Adding the widget

```dart
   MotionTabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = new MotionTabController(initialIndex:1,vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  bottomNavigationBar: MotionTabBar(
    initialSelectedTab: "Home",
    labels: const ["Dashboard", "Home", "Profile"],
    icons: const [Icons.dashboard, Icons.home, Icons.people_alt],
    tabSize: 50,
    tabBarHeight: 55,
    textStyle: const TextStyle(
      fontSize: 12,
      color: Colors.black,
      fontWeight: FontWeight.w500,
    ),
    tabIconColor: Colors.blue[600],
    tabIconSize: 28.0,
    tabIconSelectedSize: 26.0,
    tabSelectedColor: Colors.blue[900],
    tabIconSelectedColor: Colors.white,
    tabBarColor: const Color(0xFFCFCFCF),
    onTabItemSelected: (int value) {
      // ignore: avoid_print
      print(value);
      setState(() {
        _tabController!.index = value;
      });
    },
  ),

```


Catch me up on **LinkedIn** @[Rezaul Islam](www.linkedin.com/in/therezacuet "Rezaul Islam")

💙 to Code👨🏽‍💻 Flutter Expert • Dart Kotlin Swift Node Js • Android • Full Stack Mobile Developer
