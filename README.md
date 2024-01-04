# Motion Tab Bar compatible with Flutter 3 and RTL support

[![pub package](https://img.shields.io/pub/v/motion_tab_bar)](https://pub.dev/packages/motion_tab_bar)
[![likes](https://img.shields.io/pub/likes/motion_tab_bar)](https://pub.dev/packages/motion_tab_bar/score)
[![popularity](https://img.shields.io/pub/popularity/motion_tab_bar)](https://pub.dev/packages/motion_tab_bar/score)
[![pub points](https://img.shields.io/pub/points/motion_tab_bar)](https://pub.dev/packages/motion_tab_bar/score)

A beautiful animated widget for your Flutter apps

![MotionTabBar Gif](https://github.com/therezacuet/Motion-Tab-Bar/blob/master/motiontabbar.gif?raw=true)

| Without Badge  | With Badge |
| ------------- | ------------- |
| ![MotionTabBar Gif](https://github.com/therezacuet/Motion-Tab-Bar/blob/master/motiontabbar_v2.gif?raw=true)  | ![MotionTabBar Gif](https://github.com/therezacuet/Motion-Tab-Bar/blob/master/motiontabbar_v2.1.gif?raw=true)  |

## Getting Started

Add the plugin:

```yaml
dependencies:
  motion_tab_bar: ^2.0.4
```

## Basic Usage

### Use default TabController or MotionTabBarController:

```dart
  // TabController _tabController;
  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    super.initState();
    
    //// Use normal tab controller
    // _tabController = TabController(
    //   initialIndex: 1,
    //   length: 4,
    //   vsync: this,
    // );

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 1,
      length: 4,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();

    // _tabController.dispose();
    _motionTabBarController!.dispose();
  }
```

### Add Motion Tab Bar to Scaffold bottomNavigationBar:

```dart
  bottomNavigationBar: MotionTabBar(
    controller: _motionTabBarController, // ADD THIS if you need to change your tab programmatically
    initialSelectedTab: "Home",
    labels: const ["Dashboard", "Home", "Profile", "Settings"],
    icons: const [Icons.dashboard, Icons.home, Icons.people_alt, Icons.settings],

    // optional badges, length must be same with labels
    badges: [
      // Default Motion Badge Widget
      const MotionBadgeWidget(
        text: '10+',
        textColor: Colors.white, // optional, default to Colors.white
        color: Colors.red, // optional, default to Colors.red
        size: 18, // optional, default to 18
      ),

      // custom badge Widget
      Container(
        color: Colors.black,
        padding: const EdgeInsets.all(2),
        child: const Text(
          '11',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),

      // allow null
      null,

      // Default Motion Badge Widget with indicator only
      const MotionBadgeWidget(
        isIndicator: true,
        color: Colors.blue, // optional, default to Colors.red
        size: 5, // optional, default to 5,
        show: true, // true / false
      ),
    ],
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
    tabBarColor: Colors.white,
    onTabItemSelected: (int value) {
      setState(() {
        // _tabController!.index = value;
        _motionTabBarController!.index = value;
      });
    },
  ),
```

### add TabBarView to Scaffold body

```dart
  body: TabBarView(
    physics: NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
    // controller: _tabController,
    controller: _motionTabBarController,
    children: <Widget>[
      const Center(
        child: Text("Dashboard"),
      ),
      const Center(
        child: Text("Home"),
      ),
      const Center(
        child: Text("Profile"),
      ),
      const Center(
        child: Text("Settings"),
      ),
    ],
  ),
```


### to change tabs programmatically
```dart
...

ElevatedButton(
  // set MotionTabBarController index to new tab index
  onPressed: () => _motionTabBarController.index = 0,
  child: const Text('Dashboard Page'),
),
ElevatedButton(
  // set MotionTabBarController index to new tab index
  onPressed: () => _motionTabBarController.index = 1,
  child: const Text('Home Page'),
),

...
```


Catch me up on **LinkedIn** @[Rezaul Islam](www.linkedin.com/in/therezacuet "Rezaul Islam")

💙 to Code👨🏽‍💻 Flutter Expert • Dart Kotlin Swift Node Js • Android • Full Stack Developer
