import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:zappy_meal/screens/home/home_screen.dart';
import 'package:zappy_meal/shared/components/radius.dart';
import 'package:zappy_meal/shared/utils/index.dart';

class BaseHomeLayout extends StatefulWidget {
  const BaseHomeLayout({super.key});

  @override
  State<BaseHomeLayout> createState() => _BaseHomeLayoutState();
}

class _BaseHomeLayoutState extends State<BaseHomeLayout> {
  int current_index = 0;
  List<Widget> screen = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: screen[current_index],
      bottomNavigationBar: SalomonBottomBar(
        itemShape: BeveledRectangleBorder(borderRadius: radiusSm()),
        currentIndex: current_index,
        onTap: (i) => setState(() => current_index = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              AppIcons.home,
              color: current_index == 0 ? selectedColor : null,
            ),
            title: Text("Home"),
            selectedColor: selectedColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              AppIcons.report,
              color: current_index == 1 ? selectedColor : null,
            ),
            title: Text("Likes"),
            selectedColor: selectedColor,
          ),

          /// Search
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              AppIcons.cart,
              color: current_index == 2 ? selectedColor : null,
            ),
            title: Text("Cart"),
            selectedColor: selectedColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              AppIcons.profile,
              color: current_index == 3 ? selectedColor : null,
            ),
            title: Text("Profile"),
            selectedColor: selectedColor,
          ),
        ],
      ),

      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (val) => setState(() => current_index = val),
      //   type: BottomNavigationBarType.shifting,
      //   backgroundColor: Theme.of(context).cardColor,
      //   currentIndex: 0,
      //   items: [
      //     BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.home), label: ""),
      //     BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.report), label: ""),
      //     BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.cart), label: ""),
      //     BottomNavigationBarItem(icon: SvgPicture.asset(AppIcons.profile), label: ""),
      //   ],
      // ),
    );
  }
}
