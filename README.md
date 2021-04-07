# Motion Tab Bar

A beautiful animated widget for your Flutter apps

**Preview:**

|![MotionTabBar Gif](https://github.com/therezacuet/Motion-Tab-Bar/blob/master/motiontabbar.gif?raw=true) |

## Getting Started

Add the plugin:

```yaml
dependencies:
  motion_tab_bar: ^0.1.5
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
          labels: [
            "Account","Home","Dashboard"
          ],
          initialSelectedTab: "Home",
          tabIconColor: Colors.green,
          tabSelectedColor: Colors.red,
          onTabItemSelected: (int value){
               print(value);
               setState(() {
                  _tabController.index = value;
               });
          },
          icons: [
            Icons.account_box,Icons.home,Icons.menu
          ],
          textStyle: TextStyle(color: Colors.red),
  ),

```


Catch me up on **LinkedIn** @[Rezaul Islam](www.linkedin.com/in/therezacuet "Rezaul Islam")

💙 to Code👨🏽‍💻 Flutter Expert • Dart Kotlin Swift Node Js • Android • Full Stack Mobile Developer
