# Motion Tab Bar

A beautiful animated widget for your Flutter apps

| Preview |
|---------|
|![MotionTabBar Gif](https://github.com/therezacuet/Motion-Tab-Bar/blob/master/motiontabbar.gif?raw=true) |


## Getting Started

Add the plugin:

```yaml
dependencies:
  motion_tab_bar: ^0.1.3
```

## Basic Usage

Adding the widget

```dart
  MotionTabController _tabController;
  
    @override
    void initState() {
      super.initState();
      _tabController = MotionTabController(initialIndex: 1, vsync: this);
    }
  
    @override
    void dispose() {
      super.dispose();
      _tabController.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        bottomNavigationBar: MotionTabBar(
          labels: ["Home", "Search", "Profile"],
          icons: [Icons.home, Icons.search, Icons.account_box],
          initialSelectedTab: "Search",
          tabIconColor: Colors.green,
          tabSelectedColor: Colors.red,
          textStyle: TextStyle(color: Colors.red),
          onTabItemSelected: (int value) {
            print(value);
            setState(() => _tabController.index = value);
          },
        ),
        body: MotionTabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              child: Center(
                child: Text("Home"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Search"),
              ),
            ),
            Container(
              child: Center(
                child: Text("Profile"),
              ),
            ),
          ],
        ),
      );
    }
```


Catch me up on **LinkedIn** @[Rezaul Islam](www.linkedin.com/in/therezacuet "Rezaul Islam")

💙 to Code👨🏽‍💻 Flutter Expert • Dart Kotlin Swift Node Js • Android • Full Stack Mobile Developer
